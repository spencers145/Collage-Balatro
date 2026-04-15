function count_keys(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end
SMODS.Joker{ --Halftone Joker
    key = "halftonejoker",
    config = {
        extra = {
            dollars = 3
        }
    },
    loc_txt = {
        ['name'] = 'Halftone Joker',
        ['text'] = {
            [1] = 'Earn {C:money}$3{} if scoring hand',
            [2] = 'has {C:attention}3{} or more',
            [3] = 'different {C:attention}suits{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

     calculate = function(self, card, context)
        if context.cardarea ~= G.jokers or not context.joker_main then return end

        local unique_suits = {}

        for _, played_card in ipairs(context.scoring_hand) do
            if (SMODS.get_enhancements(played_card)["m_stone"] or SMODS.get_enhancements(played_card)["m_wild"]) and not played_card.debuff then
                unique_suits["Suitless"] = true
            elseif played_card.base.suit and not played_card.debuff then
                unique_suits[played_card.base.suit] = true
            end 
        end

        local total_suits = count_keys(unique_suits)

        if (total_suits) >= 3 then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
}