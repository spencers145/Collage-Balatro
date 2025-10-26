---- -- region Grab

---- local grab = {
---- 	name = "ccc_Grab",
---- 	key = "grab",
---- 	config = {extra = {mult = 6}},
---- 	pixel_size = { w = 71, h = 81 },
---- 	pos = {x = 8, y = 7},
---- 	rarity = 1,
---- 	cost = 2,
---- 	discovered = true,
---- 	blueprint_compat = true,
---- 	eternal_compat = true,
---- 	perishable_compat = true,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "Gappie",
---- 		code = "toneblock",
---- 		concept = "Fytos"
---- 	},
----     description = "+6 Mult if there is a Joker to the right"
---- }

---- grab.calculate = function(self, card, context)

---- 	if context.joker_main and G.jokers.cards[#G.jokers.cards] ~= card then
---- 		return {
---- 			message = localize {
---- 				type = 'variable',
---- 				key = 'a_mult',
---- 				vars = { card.ability.extra.mult }
---- 			},
---- 			mult_mod = card.ability.extra.mult
---- 		}
---- 	end

---- end

---- function grab.loc_vars(self, info_queue, card)
---- 	return {vars = {card.ability.extra.mult}}
---- end

---- return grab

---- -- endregion Grab