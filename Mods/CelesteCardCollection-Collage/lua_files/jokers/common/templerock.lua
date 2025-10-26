
---- -- region Temple Rock

---- local templerock = {
---- 	name = "ccc_Temple Rock",
---- 	key = "templerock",
---- 	config = { extra = { chips = 66 } },
---- 	pos = { x = 8, y = 0 },
---- 	rarity = 1,
---- 	cost = 4,
---- 	discovered = true,
---- 	blueprint_compat = true,
---- 	eternal_compat = true,
---- 	perishable_compat = true,
---- 	enhancement_gate = "m_stone",
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "Gappie",
---- 		code = "toneblock",
---- 		concept = "sunsetquasar"
---- 	},
----     description = "Each Stone Card held in hand gives +66 chips"
---- }

---- templerock.calculate = function(self, card, context)
---- 	if context.individual and context.poker_hands ~= nil then
---- 		if context.cardarea == G.hand then
---- 			if SMODS.has_enhancement(context.other_card, 'm_stone') then
---- 				return {
---- 					message = localize {
---- 						type = 'variable',
---- 						key = 'a_chips',
---- 						vars = { card.ability.extra.chips }
---- 					},
---- 					chip_mod = card.ability.extra.chips
---- 				}
---- 			end
---- 		end
---- 	end
---- end

---- function templerock.loc_vars(self, info_queue, card)
---- 	info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
---- 	return { vars = { card.ability.extra.chips } }
---- end

---- return templerock
---- -- endregion Temple Rock