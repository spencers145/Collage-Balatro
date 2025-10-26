-- region Collapsing Bridge

local collapsingbridge = {
	name = "ccc_Collapsing Bridge",
	key = "collapsingbridge",
	config = { extra = { xmult = 4, prob_success = 3 } },
	pos = { x = 8, y = 1 },
	rarity = 3,
	cost = 8,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "if played hand contains a Straigh, X5 Mult and all played cards have a 1 in 3 chance of being destroyed"
}

collapsingbridge.calculate = function(self, card, context)
	if context.joker_main then
		if next(context.poker_hands['Straight']) then
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				Xmult_mod = card.ability.extra.xmult
			}
		end
	end

	if context.destroying_card and (context.cardarea == G.play or context.cardarea == "unscored") and next(context.poker_hands['Straight']) then
		if SMODS.pseudorandom_probability(card, pseudorandom('bridge'), 1, card.ability.extra.odds, 'bridge') then
			return { remove = true }
		end
	end
end

function collapsingbridge.loc_vars(self, info_queue, card)
	local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.prob_success)
	return {
		vars = { n, card.ability.extra.xmult, d }
	}
end

return collapsingbridge
-- endregion Collapsing Bridge