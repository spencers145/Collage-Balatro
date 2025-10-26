---- -- region Heavy Heart

---- local heavyheart = {
---- 	name = "ccc_Heavy Heart",
---- 	key = "heavyheart",
---- 	config = { extra = { money = 2 } },
---- 	pos = { x = 2, y = 8 },
---- 	rarity = 'ccc_secret',
---- 	cost = 15,
---- 	discovered = false,
---- 	blueprint_compat = true,
---- 	eternal_compat = true,
---- 	perishable_compat = false,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "N/A",
---- 		code = "toneblock",
---- 		concept = "Fytos"
---- 	},
---- 	description = "If played hand is a single Ace of Diamonds gives $2 multiplied by the amount of cards held in hand (Unaffected by retriggers)"
---- }

---- heavyheart.calculate = function(self, card, context)
---- 	if context.before and #context.full_hand == 1 and context.full_hand[1]:get_id() == 14 and context.full_hand[1]:is_suit('Diamonds', true) then
---- 		local money = 0
---- 		for i = 1, #G.hand.cards do
---- 			money = money + card.ability.extra.money
---- 		end
---- 		if #G.hand.cards > 0 then
---- 			return {
---- 				dollars = money,
---- 				colour = G.C.MONEY
---- 			}
---- 		end
---- 	end
---- end

---- heavyheart.yes_pool_flag = 'secretheart'

---- function heavyheart.loc_vars(self, info_queue, card)
---- 	return { vars = { card.ability.extra.money } }
---- end

---- return heavyheart
---- -- endregion Heavy Heart