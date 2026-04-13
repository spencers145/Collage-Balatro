local jokerInfo = {
discovered = false,
    key = "paid_vacation",
    pos = LOSTEDMOD.funcs.coordinate(55),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { money = 8, hands_left = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.hands_left } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.hands_left <= 1 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        
        if context.end_of_round and context.game_over == false and context.main_eval then
            if G.GAME.current_round.hands_left <= card.ability.extra.hands_left then
                ease_dollars(card.ability.extra.money)
                return {
                    message = localize('$') .. card.ability.extra.money,
                    colour = G.C.MONEY
                }
            end
        end
    end
}

return jokerInfo