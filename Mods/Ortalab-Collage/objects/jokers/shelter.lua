SMODS.Joker({
	key = "shelter",
	atlas = "jokers",
	pos = {x = 1, y = 9},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 3, type = 'Two Pair'}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, localize(card.ability.extra.type, 'poker_hands')}}
    end,
    calculate = function(self, card, context) --The Mysterium Logic
        if context.joker_main then
            if next(context.poker_hands[card.ability.extra.type]) then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
})