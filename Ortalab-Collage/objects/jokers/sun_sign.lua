SMODS.Joker({
	key = "sun_sign",
	atlas = "jokers",
	pos = {x = 7, y = 13},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {dollars = 2}},
	artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, table.size(G.GAME.ortalab.zodiacs.activated or {})*card.ability.extra.dollars}}
    end,
    calc_dollar_bonus = function(self, card)
		return table.size(G.GAME.ortalab.zodiacs.activated)*card.ability.extra.dollars
	end
})