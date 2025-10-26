local jester_zombie = {
    object_type = "Joker",
    order = 236,
    key = "jester_zombie",
    config = {
        extra = {
            odds = 2
        }
    },
    rarity = 2,
    pos = { x = 4, y = 9},
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'jester_zombie')
        return { vars = {
            n,d
        }}
    end,
  
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            if (context.open_booster and context.card.config.center.kind ~= 'Standard' and context.card.config.center.kind ~= 'Buffoon') then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        forced_message("BRAINS...", card, G.C.PURPLE)
                        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.VT.y < G.ROOM.T.h then
                            if SMODS.pseudorandom_probability(card, pseudoseed('jester_zombie'), 1, card.ability.extra.odds, 'jester_zombie') then
                                local chosen = pseudorandom_element(G.pack_cards.cards)
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 1,
                                    func = function()
                                        rot_card(chosen, card, true)
                                        return true
                                    end
                                }))
                            end
                            return true
                        end
                    end
                }))
            end
        end
    end
}
return { name = {"Jokers"}, items = {jester_zombie} }