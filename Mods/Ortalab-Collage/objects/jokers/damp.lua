SMODS.Joker({
	key = "damp",
	atlas = "jokers",
	pos = {x=9,y=8},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	artist_credits = {'gappie'},
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			local eval = function() return G.GAME.current_round.hands_played == 0 end
			juice_card_until(card, eval, true)
		end
		if context.end_of_round and context.main_eval and not context.blueprint and G.GAME.current_round.hands_played == 1 then
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.BLUE,
				level_up = true,
				level_up_hand = G.GAME.last_hand_played
			}
		end
	end
})