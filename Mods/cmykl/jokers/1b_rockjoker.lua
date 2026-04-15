--[[SMODS.Joker{ --Rock Joker
    key = "rockjoker",
    config = {
        extra = {
            ranker = 0,
            chips = 50
        }
    },
    loc_txt = {
        ['name'] = 'Rock Joker',
        ['text'] = {
            '{C:attention}Stone Cards{} held in',
            'hand give {C:blue}+50{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    discovered = false,
    enhancement_gate = "m_stone",
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round  then
            if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}]]