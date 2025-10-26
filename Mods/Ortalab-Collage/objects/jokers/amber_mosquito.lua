SMODS.Joker({
	key = "amber_mosquito",
	atlas = "jokers",
	pos = {x = 3, y = 7},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1.5, suit = 'Hearts', denom = 2}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.denom)
        return {vars = {card.ability.extra.xmult, localize(card.ability.extra.suit, 'suits_singular'), a, b, colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    calculate = function(self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) then
			if SMODS.pseudorandom_probability(card, 'ortalab_mosquito', 1, card.ability.extra.denom) then
				return {
					card = card,
					x_mult = card.ability.extra.xmult
				}
			end
        end
    end
})