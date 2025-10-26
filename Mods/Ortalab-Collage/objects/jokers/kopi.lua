SMODS.Joker({
    key = "kopi",
    atlas = "jokers",
    pos = {x = 8, y = 11},
    soul_pos = {x = 9, y = 11},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {target = 4, current = 0}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.target, card.ability.extra.current}}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if not context.retrigger_joker then card.ability.extra.current = card.ability.extra.current + 1 end
            if card.ability.extra.current == card.ability.extra.target or (context.retrigger_joker and card.ability.extra.current == 0) then
                card.ability.extra.current = 0
                if #G.jokers.cards == 1 then SMODS.calculate_effect({message = localize('ortalab_kopi_no'), colour = HEX('dfb958')}, card); return end
                SMODS.calculate_effect({message = localize('ortalab_kopi'), colour = HEX('dfb958')}, card)
                local joker = pseudorandom_element(G.jokers.cards, 'ortalab_kopi')
                while (joker == card or joker.ability.kopi) do
                    joker = pseudorandom_element(G.jokers.cards, 'ortalab_kopi_resample')
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.7,
                    func = function()
                        local copy = copy_card(joker, nil, nil, nil, true) -- strips edition
                        copy:remove_sticker('eternal')
                        --copy:set_curse()
                        G.jokers:emplace(copy)
                        copy:add_to_deck()
                        copy:start_materialize({HEX('dc9d6c')})
                        copy.ability.kopi = true
                        copy.ability.shinku = nil
                        copy.ignore_base_shader = {kopi = true}
                        copy.ignore_shadow = {kopi = true}
                        copy:set_cost()
                        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                        return true
                    end
                }))
                return nil, true
            else
                SMODS.calculate_effect({message = card.ability.extra.current..'/'..card.ability.extra.target, colour = HEX('dc9d6c')}, card)
            end
        end
    end    
})

local ortalab_start_dissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    if self.ability.kopi then dissolve_colours = {HEX('dc9d6c')} end
    ortalab_start_dissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

SMODS.DrawStep {
    key = 'kopi',
    order = 100,
    func = function(self)
        if self.ability.kopi then
            self.children.center:draw_shader('ortalab_kopi', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Shader({key = 'kopi', path = 'kopi.fs'})

G.ARGS.LOC_COLOURS['kopi'] = HEX('dfb958')

--[[SMODS.JimboQuip({
    key = 'kopi_1',
    extra = {
        center = 'j_ortalab_kopi',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'win' and next(SMODS.find_card('j_ortalab_kopi')) then
            return true, { weight = 10 } 
        end
    end
})]]

--[[SMODS.JimboQuip({
    key = 'kopi_loss',
    extra = {
        center = 'j_ortalab_kopi',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'loss' then
            self.extra.text_key = self.key..'_'..math.random(1,3)
            return true, { weight = 1 }
        end
    end
})]]