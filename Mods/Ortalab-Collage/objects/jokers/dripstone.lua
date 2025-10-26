SMODS.Joker({
	key = "dripstone",
	atlas = "jokers",
	pos = {x = 4, y = 7},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 40, suit = 'Spades'}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    calculate = function(self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) then
            return {
				card = card,
                chips = card.ability.extra.chips
            }
        end
    end
})