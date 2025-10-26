SMODS.Joker({
	key = "basalt_column",
	atlas = "jokers",
	pos = {x = 5, y = 7},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult = 8, suit = 'Clubs'}},
	artist_credits = {'alex'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult, localize(card.ability.extra.suit, 'suits_singular'), colours = {G.C.SUITS[card.ability.extra.suit]}}}
    end,
    calculate = function(self, card, context)
        if not context.end_of_round and context.individual and context.cardarea == G.hand and context.other_card:is_suit(card.ability.extra.suit) then
            return {
				card = card,
                h_mult = card.ability.extra.mult
            }
        end
    end
})