SMODS.Joker {
	key = 'yo_gurt',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = false,
	config = { extra = { hands_left = 5, chips = 50 } },
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 8, y = 2 },
    credits = {
        idea = "LegEaterHK",
        remix = "Monachrome"
    },
	cost = 2,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.hands_left } }
	end,
    calculate = function (self, card, context)
        if context.joker_main then
            return {
                chips = (G.GAME.current_round.hands_played+1) * card.ability.extra.chips,
            }
        end
        if context.final_scoring_step then
            card.ability.extra.hands_left = card.ability.extra.hands_left - 1
            if card.ability.extra.hands_left <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:remove_from_deck()
                        card:start_dissolve(nil)
                        return true
                    end
                }))
                return {
                    message = "Consumed!"
                }
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips" }
            },
            text_config = { colour = G.C.CHIPS },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "hands_left" },
                { text = " hands left)" }
            },
            calc_function = function (card)
                card.joker_display_values.hands_left = card.ability.extra.hands_left
                card.joker_display_values.chips = (G.GAME.current_round.hands_played + 1) * card.ability.extra.chips
            end
        }
    end
}