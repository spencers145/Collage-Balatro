SMODS.Joker({
	key = "collatz",
	atlas = "jokers",
	pos = {x = 4, y = 13},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {Xmult = 1.2, valid_ranks = {14, 10, 9, 8, 6, 4}}},
	artist_credits = {'crimson'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,
	calculate = function(self, card, context) --Logic
        if context.individual and context.cardarea == G.play and table.contains(card.ability.extra.valid_ranks, context.other_card:get_id()) and not SMODS.has_no_rank(context.other_card) then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
})