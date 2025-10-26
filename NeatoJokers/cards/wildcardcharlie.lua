SMODS.Joker {
    key = "wildcardcharlie",
    config = {extra = {x_mult = 1.5}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return { vars = { card.ability.extra.x_mult }}
    end,
    in_pool = function(self, args)
        return count_enhancement('m_wild') > 0
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    atlas = "NeatoJokers",
    pos = { x = 0, y = 1 },
    cost = 7,
    calculate = function(self, card, context)
        if context.individual and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
            if SMODS.has_enhancement(context.other_card, "m_wild") and not context.other_card.debuff then
                return {
                    x_mult = card.ability.extra.x_mult,
                    card = card,
                }
            end
        end
    end
}
