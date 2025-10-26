SMODS.Joker {
    key = "handicap_parking",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 3, y = 5 },
    atlas = "TextureAtlasJokers",
    config = { extra = { odds = 2, dollars = 2 } },
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { card.ability.extra.dollars, empty_slots, n, d } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and SMODS.pseudorandom_probability(card, pseudorandom('handicap_parking'), 1, card.ability.extra.odds, 'handicap_parking') then
            local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
            if empty_slots > 0 then
                local total_dollars = card.ability.extra.dollars * empty_slots
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + total_dollars
                return {
                    dollars = total_dollars,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            extra = {
                {
                    { text = "("},
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")"},
                }
            },
            text = {
                { text = "+$" },
                { ref_table = "card.joker_display_values", ref_value = "dollars" }
            },
            text_config = { colour = G.C.GOLD },
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local empty_slots = G.jokers and (G.jokers.config.card_limit - #G.jokers.cards) or 0
                card.joker_display_values.dollars = card.ability.extra.dollars * empty_slots
                
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
        }
    end,
}
