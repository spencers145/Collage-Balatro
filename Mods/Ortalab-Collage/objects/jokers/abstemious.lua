SMODS.Joker({
	key = "abstemious",
	atlas = "jokers",
	pos = {x = 4, y = 0},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 25, suit = 'Clubs'}},
    artist_credits = {'golddisco', 'flare'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, localize(card.ability.extra.suit, 'suits_singular')}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})