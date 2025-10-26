SMODS.Joker({
	key = "generous",
	atlas = "jokers",
	pos = {x = 1, y = 0},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 25, suit = 'Diamonds'}},
    artist_credits = {'golddisco','flare'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, localize(card.ability.extra.suit, 'suits_singular')}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})