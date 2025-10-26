SMODS.Joker({
	key = "reduce_reuse",
	atlas = "jokers",
	pos = {x = 6, y = 5},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {money = 2}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
	calc_dollar_bonus = function(self, card)
		if G.GAME.current_round.hands_played == 1 then
            return G.GAME.current_round.hands_left * card.ability.extra.money
        end
	end
})