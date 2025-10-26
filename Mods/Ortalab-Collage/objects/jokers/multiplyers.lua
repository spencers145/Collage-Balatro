SMODS.Joker({
	key = "multiplyers",
	atlas = "jokers",
	pos = {x = 9, y = 6},
	rarity = 3,
	cost = 11,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {repetitions = 1}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.repetitions}}
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_numbered() and not context.other_card.config.center.always_scores then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
})
