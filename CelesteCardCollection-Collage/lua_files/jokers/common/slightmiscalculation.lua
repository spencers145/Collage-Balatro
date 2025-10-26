---- -- region Slight Miscalculation

---- local slightmiscalculation ={
---- 	name = "ccc_Slight Miscalculation",
---- 	key = "slightmiscalculation",
----     config = {extra = {mult = 9}},
---- 	pos = {x = 9, y = 5},
---- 	rarity = 1,
---- 	cost = 3,
---- 	discovered = true,
---- 	blueprint_compat = true,
---- 	eternal_compat = true,
---- 	perishable_compat = true,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "Mr. Wolf",
---- 		code = "toneblock",
---- 		concept = "Fytos"
---- 	},
----     description = "+9 Mult if scoring hand starts and ends with the same rank"
---- }

---- slightmiscalculation.calculate = function(self, card, context)

---- 	if context.joker_main then
---- 		if (context.scoring_hand[1] and (context.scoring_hand[1]:get_id() == context.scoring_hand[#context.scoring_hand]:get_id())) or
---- 		-- keevin doesn't work well with this! so i'm hardcoding the interaction
---- 		(#SMODS.find_card('j_ccc_kevin') >= 1 and G.play.cards[#G.play.cards] == context.scoring_hand[#context.scoring_hand] and context.scoring_hand[1]:is_face()) then
---- 			return {
---- 				message = localize {
---- 					type = 'variable',
---- 					key = 'a_mult',
---- 					vars = { card.ability.extra.mult }
---- 				},
---- 				mult_mod = card.ability.extra.mult
----                 	}
---- 		end		
---- 	end

---- end

---- function slightmiscalculation.loc_vars(self, info_queue, card)
---- 	return {vars = {card.ability.extra.mult}}
---- end

---- return slightmiscalculation
---- -- endregion Slight Miscalculation