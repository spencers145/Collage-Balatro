SMODS.Joker({
	key = "prediction_dice",
	atlas = "jokers",
	pos = {x = 6, y = 13},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chance = 3}},
	artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {SMODS.get_probability_vars(card, 1, card.ability.extra.chance)}}
    end,
	
})