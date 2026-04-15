SMODS.Joker{ --The Mountain
    key = "themountain",
    config = {
        extra = {
            xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'The Mountain',
        ['text'] = {
            'If scoring hand has',
            'exactly {C:attention}1{} {C:spades}Spade{} card,',
            'it gives {C:white,X:mult}X#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
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
        if context.cardarea == G.play and context.individual and context.other_card:is_suit('Spades') then
            local spades = 0
            for key, value in pairs(context.scoring_hand) do
                if value:is_suit('Spades') then
                    spades = spades + 1
                end
            end

            if spades == 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}