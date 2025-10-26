SMODS.Joker {
    key = "9_ball",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 2, y = 5 },
    unlocked = true,
    discovered = false,
    atlas = "TextureAtlasJokers",
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, colours = { G.C.SET.Divine} } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if (context.other_card:get_id() == 9) and (pseudorandom(pseudoseed('vis_9_ball')) < G.GAME.probabilities.normal / card.ability.extra.odds) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    extra = {
                        message = localize('k_plus_divine'),
                        message_card = card,
                        func = function() -- This is for timing purposes, everything here runs after the message
                            G.E_MANAGER:add_event(Event({
                                func = (function()
                                    SMODS.add_card {
                                        set = 'Divine',
                                        key_append = 'vis_9_ball' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
                        end
                    },
                }
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
            },
            text_config = { colour = G.C.SECONDARY_SET.Divine },
            extra = {
                {
                    { text = "("},
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")"},
                }
            },
            extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:get_id() and scoring_card:get_id() == 9 then
                            count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.count = count
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
        }
    end
}