--- @type SMODS.Joker
local j = {
    key = "great_red_spot",
    atlas = "jokers",
    pos = { x = 5, y = 0 },
    config = { extra = { hand = "Flush", levels = 1, Xmult = 1, Xmult_add = 0.25 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { localize(stg.hand, "poker_hands"),
                stg.levels,
                stg.Xmult_add,
                stg.Xmult
            }
        }
    end,
    blueprint_compat = true,
    perishable_compat = false,
    discovered = false,
    rarity = 2,
    cost = 8,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.hand and to_big(G.GAME.hands[context.scoring_name].level) > to_big(card.ability.extra.levels) then
            level_up_hand(card, card.ability.extra.hand, nil, -1)
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
            return {
                message = localize("k_upgrade_ex")
            }
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

return j
