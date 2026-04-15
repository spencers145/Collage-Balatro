SMODS.Joker{ --The Dune
    key = "thedune",
    config = {
        extra = {
            xmult = 0.2
        }
    },
    loc_txt = {
        ['name'] = 'The Dune',
        ['text'] = {
            'Each scoring {C:hearts}Heart{} card gives',
            '{X:mult,C:white}+X#1#{} Mult for each adjacent',
            'scoring {C:hearts}Heart{} card',
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
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
        if context.cardarea == G.play and context.individual and context.other_card:is_suit('Hearts') then
            local pos = -1
            for key, value in pairs(context.scoring_hand) do
                if value == context.other_card then
                    pos = key
                    break
                end
            end

            local xmult = 1
            if #context.scoring_hand ~= pos and context.scoring_hand[pos + 1]:is_suit('Hearts') then
                xmult = xmult + card.ability.extra.xmult
            end

            if pos ~= 1 and context.scoring_hand[pos - 1]:is_suit('Hearts') then
                xmult = xmult + card.ability.extra.xmult
            end

            if xmult > 1 then
                return {
                    xmult = xmult
                }
            end
        end
    end
}