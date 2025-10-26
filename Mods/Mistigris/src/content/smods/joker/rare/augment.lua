
--- @type SMODS.Joker
local j = {
    key = "augment",
    atlas = "jokers",
    pos = { x = 8, y = 0 },
    config = { extra = { Xmult = 1.5 } },
    discovered = false,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS["m_gold"]
        local stg = card.ability.extra
        return { vars = { stg.Xmult } }
    end,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_gold") and not context.other_card.debuff and not context.end_of_round then
            return {
                dollars = 3
            }
        end
    end
}

return j
