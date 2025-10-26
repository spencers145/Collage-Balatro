SMODS.Joker({
	key = "mirage",
	atlas = "jokers",
	pos = {x=6,y=4},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {xmult = 1, gain = 0.15}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.gain, card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.remove_playing_cards and not context.blueprint then
            for i=1, #context.removed do
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "gain",
					message_key = 'a_xmult'
				})
            end
        end
    end
})