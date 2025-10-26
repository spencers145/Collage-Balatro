-- region Hyperdash

local hyperdash = {
	name = "ccc_Hyperdash",
	key = "hyperdash",
	config = {extra = {mult = 3}},
	pixel_size = { w = 71, h = 81 },
	pos = {x = 6, y = 6},
	rarity = 2,
	cost = 6,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Fytos"
	}, 
    description = "After discarding a hand that contains Two Pair, X3 Mult for the next played hand"
}

hyperdash.calculate = function(self, card, context)

	if context.pre_discard and not context.blueprint then
		local poker_hands = evaluate_poker_hand(G.hand.highlighted)
		if next(poker_hands["Two Pair"]) then
			card.ability.active = true
			local thunk = function(_card) return _card.ability.active == true end
                	juice_card_until(card, thunk, true)
			return {
				message = localize('k_active_ex'),
			}
		end
	end
			

	if context.joker_main and card.ability.active then
		card.ability.active = false
		return {
			message = localize {
				type = 'variable',
				key = 'a_xmult',
				vars = { card.ability.extra.mult }
			},
			Xmult_mod = card.ability.extra.mult
		}
	end
			
end

function hyperdash.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.mult}}
end

return hyperdash
-- endregion Hyperdash