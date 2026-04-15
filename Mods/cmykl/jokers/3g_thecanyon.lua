SMODS.Joker{ --The Canyon
    key = "thecanyon",
    config = {
        extra = {
            xmult = 2,
        }
    },
    loc_txt = {
        ['name'] = 'The Canyon',
        ['text'] = {
            'The {C:attention}first{} and {C:attention}last{} scoring',
            '{C:diamonds}Diamond{} cards give {C:white,X:mult}X#1#{} Mult if',
            'scoring hand has exactly {C:attention}2{} {C:diamonds}Diamonds{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.scoring_hand and context.cardarea == G.play then
            local diamonds = {}

            for key, value in pairs(context.scoring_hand) do
                if value:is_suit('Diamonds') then
                    table.insert(diamonds, value)
                end
            end

            if #diamonds == 2 and (diamonds[1] == context.other_card or diamonds[2] == context.other_card) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}