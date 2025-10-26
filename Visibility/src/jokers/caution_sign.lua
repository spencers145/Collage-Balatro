SMODS.Joker {
    key = "caution_sign",
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    rarity = 1,
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 3 },
    cost = 5,
    config = { extra = { repetitions = 2 } }, -- trigger the same card twice
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        -- Check we're in repetition context and card is in hand
        if context.repetition and context.cardarea == G.hand then
            local first_card = G.hand.cards[1]
            -- Only apply if the card being evaluated is exactly the first in hand
            if context.other_card == first_card then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
    -- For other cards like baron
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
                return held_in_hand and JokerDisplay.calculate_joker_triggers(joker_card) or 0
            end
        }
    end
    
}

