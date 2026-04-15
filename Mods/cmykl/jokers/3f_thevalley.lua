SMODS.Joker{ --The Valley
    key = "thevalley",
    config = {
        extra = {
            xmult = 1.5,
            reduction = 0.25,
        }
    },
    loc_txt = {
        ['name'] = 'The Valley',
        ['text'] = {
            {'Each scoring {C:clubs}Club{} card',
            'gives {X:mult,C:white}X#1#{} Mult'},
            {'Each scoring {C:clubs}Club{} card gives',
            '{X:mult,C:white}-X#2#{} Mult for each adjacent',
            'scoring {C:clubs}Club{} card',}
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
                card.ability.extra.xmult,
                card.ability.extra.reduction
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card:is_suit('Clubs') then
            local pos = -1
            for key, value in pairs(context.scoring_hand) do
                if value == context.other_card then
                    pos = key
                    break
                end
            end

            local xmult = card.ability.extra.xmult
            if #context.scoring_hand ~= pos and context.scoring_hand[pos + 1]:is_suit('Clubs') then
                xmult = xmult - card.ability.extra.reduction
            end

            if pos ~= 1 and context.scoring_hand[pos - 1]:is_suit('Clubs') then
                xmult = xmult - card.ability.extra.reduction
            end

            if xmult > 1 then
                return {
                    xmult = xmult
                }
            end
        end
    end
}