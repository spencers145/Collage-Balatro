SMODS.Joker({
    key = "false_phd",
    atlas = "jokers",
    pos = {x = 7, y = 14},
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {cards = 2}},
    artist_credits = {'rowan'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.cards}}
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then 
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()     
                    local _suit = pseudorandom_element(SMODS.Suits, pseudoseed('ortalab_false_phd_suit')).card_key
                    local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('ortalab_false_phd_rank')).card_key
                    
                    local enhancement = SMODS.poll_enhancement({key = 'ortalab_false_phd_enhance', guaranteed = true})
                    local seal = SMODS.poll_seal({key = 'ortalab_false_phd_seal', guaranteed = true})
                    local edition = poll_edition('ortalab_false_phd_edition', nil, nil, true)
                    
                    for i=1, card.ability.extra.cards do
                        local new_card = create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = G.P_CENTERS[enhancement]}, G.hand)
                        new_card:set_edition(edition, true)
                        new_card:set_seal(seal, true)
                        new_card.ability.temporary = localize({set = 'Joker', key = self.key, type = 'name_text'})
                    end
                    card:juice_up()
                    save_run()
                    return true
                end
            }))
            
            return nil, true            
        end
        if context.end_of_round and context.main_eval then
            self.remove_temp_cards()
        end
    end,
    remove_temp_cards = function()
        for _, card in ipairs(G.playing_cards) do
            if card.ability.temporary then card:start_dissolve() end
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        self.remove_temp_cards()
    end
})

SMODS.Atlas({
    key = 'temporary',
    path = 'temporary.png',
    px = 71,
    py = 95
})

SMODS.DrawStep {
    key = 'temporary',
    order = 36,
    func = function(self)
        if self.ability.temporary then
            if not Ortalab.temporary_sprite then Ortalab.temporary_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['ortalab_temporary'], {x=0, y=0}) end
            Ortalab.temporary_sprite.role.draw_major = self
            Ortalab.temporary_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}