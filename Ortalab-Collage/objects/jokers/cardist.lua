SMODS.Joker({
	key = "cardist",
	atlas = "jokers",
	pos = {x=8,y=5},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {hands = 1}},
	artist_credits = {'salad'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.hands}}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			ease_hands_played(card.ability.extra.hands)
			return {
				message = localize('ortalab_cardist'),
				colour = G.C.BLUE
			}
		end
	end
})