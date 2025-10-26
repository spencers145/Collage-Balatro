SMODS.Joker({
	key = "knitted_sweater",
	atlas = "jokers",
	pos = {x=2,y=11},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, chip_gain = 12}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.chip_gain, card.ability.extra.chips, localize('Three of a Kind', 'poker_hands')}}
	end,
	calculate = function(self, card, context)
        if context.before and next(context.poker_hands['Three of a Kind']) and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chip_gain",
				message_colour = G.C.BLUE
			})
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})