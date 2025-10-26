SMODS.Joker{
	key = 'faces',
	atlas = 'roffers',
	rarity = 2,
	cost = 5,
	blueprint_compat = true,
	discovered = false,
	eternal_compat = true,
	pos = { x = 4, y = 8 },
	config = { extra = { probability = 2, dollars = 1 } },
	loc_vars = function(self,info_queue,card)
		return {vars = { G.GAME.probabilities.normal or 1, card.ability.extra.probability, card.ability.extra.dollars }}
	end,
	calculate = function(self,card,context)
		if context.discard then
			if context.other_card:is_face() then
				if pseudorandom('canioscaler') < G.GAME.probabilities.normal / card.ability.extra.probability then
					return {
						remove = true,
						dollars = card.ability.extra.dollars
					}
				else
					local effects
					SMODS.calculate_context({roff_probability_missed = true}, effects)
				end
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
