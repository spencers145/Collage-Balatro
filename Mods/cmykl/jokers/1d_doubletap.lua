SMODS.Joker{ --Double Tap
    key = "doubletap",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Double Tap',
        ['text'] = {
            'Retrigger {C:atttention}last{} played',
            'card used in scoring',
            '{C:attention}1{} more time'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
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
    config = { extra = { repetitions = 1 } },
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and (context.other_card == context.scoring_hand[#context.scoring_hand]) then
            return {
                repetitions = card.ability.extra.repetitions,
                message = "Bang!"
            }
        end
    end,
}