SMODS.Joker({
	key = "fools_gold",
	atlas = "jokers",
	pos = {x = 2, y = 7},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {money = 2, suit = 'Diamonds', chance = 2}},
	artist_credits = {'kosze'},
	loc_vars = function(self, info_queue, card)
		local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {vars = {a, b, card.ability.extra.money, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    calculate = function(self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) then
            if SMODS.pseudorandom_probability(card, 'fools_gold', 1, card.ability.extra.chance) then
				return {
					dollars = card.ability.extra.money
				}
			end
			return {
				message = localize('k_nope_ex')
			}
        end
    end
})