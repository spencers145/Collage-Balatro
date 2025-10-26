SMODS.Joker({
	key = "freezer",
	atlas = "jokers",
	pos = {x=1,y=11},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1, xmult_gain = 0.75, used = 0}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult_gain, card.ability.extra.xmult + (card.ability.extra.xmult_gain * card.ability.extra.used)}}
	end,
	set_ability = function(self, card, initial)
		card.ability.extra.base = card.ability.extra.xmult
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.retrigger_joker then
			card.ability.extra.xmult = card.ability.extra.base
			return {
				message = localize('ortalab_joker_miles_reset'),
				colour = G.C.RED
			}
		end
		if context.using_consumeable and G.GAME.blind.in_blind and not context.retrigger_joker and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "xmult_gain",
				message_key = 'a_xmult',
				message_colour = G.C.RED
			})
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
})