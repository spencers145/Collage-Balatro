SMODS.Joker({
	key = "chameleon",
	atlas = "jokers",
	pos = {x = 9, y = 9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {copied_joker = nil, copied_joker_pos = 1}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        if card.ability.extra.copied_joker then
            if G.P_CENTERS[card.ability.extra.copied_joker.config.center_key] then
                info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.copied_joker.config.center_key]
            end
            return {vars = {localize{type = 'name_text', set = "Joker", key = card.ability.extra.copied_joker.config.center_key, nodes = {}}}}
        else
            return {vars = {localize('ortalab_na')}}
        end
    end,
    calculate = function(self, card, context) --Chameleon Joker Logic
        if context.setting_blind and not card.getting_sliced then
            card.ability.extra.copied_joker = nil
            local potential_jokers = {}
            for i=1, #G.jokers.cards do 
                if G.jokers.cards[i] ~= card and G.jokers.cards[i].config.center.key ~= 'chameleon_joker' and G.jokers.cards[i].config.center.blueprint_compat then
                    potential_jokers[#potential_jokers+1] = G.jokers.cards[i]
                end
            end
            if #potential_jokers > 0 then
                local chosen_joker = pseudorandom_element(potential_jokers, pseudoseed('chameleon'))
                for i, joker in ipairs(G.jokers.cards) do
                    if joker == chosen_joker then 
                        card.ability.extra.copied_joker_pos = i
                    end
                end
                card.ability.extra.copied_joker = chosen_joker
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ortalab_copied')})
                update_chameleon_atlas(card, G.ASSET_ATLAS[chosen_joker.config.center.atlas or 'Joker'], chosen_joker.config.center.pos)
            end	
        end
        if card.ability.extra.copied_joker and card.ability.extra.copied_joker.calculate_joker then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = card.ability.extra.copied_joker:calculate_joker(context)
            context.blueprint = nil
            local eff_card = context.blueprint_card or self
            context.blueprint_card = nil
            if other_joker_ret then
                other_joker_ret.card = card
                other_joker_ret.colour = G.C.GREEN
                return other_joker_ret
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        if card.ability.extra and card.ability.extra.copied_joker then
            local chosen_joker = card.ability.extra.copier_joker
            update_chameleon_atlas(card, G.ASSET_ATLAS[card.ability.extra.copied_joker.config.center.atlas or 'Joker'], card.ability.extra.copied_joker.config.center.pos)
        else
            update_chameleon_atlas(card, G.ASSET_ATLAS[self.atlas], self.pos)
        end
        card.ignore_base_shader = {chameleon = true}
        card.ignore_shadow = {chameleon = true}
    end,
    load = function(self, card, card_table, other_card)
        card.loaded = true
    end,
    update = function(self, card, dt)
        if card.loaded then
            card.ability.extra.copied_joker = G.jokers.cards[card.ability.extra.copied_joker_pos]
            if card.ability.extra.copied_joker then
                card.loaded = false
                update_chameleon_atlas(card, G.ASSET_ATLAS[card.ability.extra.copied_joker.config.center.atlas or 'Joker'], card.ability.extra.copied_joker.config.center.pos)
            end
        end
    end
})

SMODS.Shader({
    key = 'chameleon',
    path = 'chameleon.fs'
})

SMODS.DrawStep {
    key = 'chameleon',
    order = 1,
    func = function(self, layer)
        if self.config.center_key == 'j_ortalab_chameleon' then
            if self.ability.extra.copied_joker then
                if self.children.front then self.children.front:draw_shader('dissolve') end
                self.children.center:draw_shader('ortalab_chameleon', nil, self.ARGS.send_to_shader)
            else
                self.children.center:draw_shader('dissolve')
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

function update_chameleon_atlas(self, new_atlas, new_pos)
    self:juice_up()
    if not self.children.front then
        self.children.front = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, G.ASSET_ATLAS[new_atlas.name], new_pos)
        self.children.front.states.hover = self.states.hover
        self.children.front.states.click = self.states.click
        self.children.front.states.drag = self.states.drag
        self.children.front.states.collide.can = false
        self.children.front:set_role({major = self, role_type = 'Glued', draw_major = self})
    end
    self.children.front.sprite_pos = new_pos
    self.children.front.atlas.name = new_atlas and (new_atlas.key or new_atlas.name) or 'Joker'
    self.children.front:reset()
    self:juice_up()    
end
