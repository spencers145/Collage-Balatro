SMODS.Joker({
	key = "blue_card",
	atlas = "jokers",
	pos = {x=2,y=4},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, gain = 5}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.gain, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})