-- region Dash

local dash = {
	name = "ccc_Dash",
	key = "dash",
	config = {extra = {mult = 1.5}},
	pixel_size = { w = 71, h = 81 },
	pos = {x = 7, y = 7},
	rarity = 1,
	cost = 2,
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
    description = "X1.5 Mult"
}

dash.calculate = function(self, card, context)

	if context.joker_main then
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

function dash.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.mult}}
end

return dash
-- endregion Dash