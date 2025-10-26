SMODS.Joker {
    key = 'conspiracy',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 5 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
	cost = 3,
    config = { extra = { odds = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.x_mult, card.ability.extra.x_chips, card.ability.extra.gain, card.ability.extra.cost } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('conspiracy') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    balance = true
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