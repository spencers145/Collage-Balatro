-- Ghost Print
SMODS.Joker {
	key = "ghost_print",
	config = { extra = {repetitions = 1, odds = 2 }},
	rarity = 2,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 2, y = 1},
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if pseudorandom(pseudoseed('ghost_print')) < G.GAME.probabilities.normal / card.ability.extra.odds then
				return {
					repetitions = card.ability.extra.repetitions
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
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
        }
    end,
}