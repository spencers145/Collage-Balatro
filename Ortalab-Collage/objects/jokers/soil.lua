SMODS.Joker({
	key = "soil",
	atlas = "jokers",
	pos = {x=7,y=9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1, xmult_gain = 0.5}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_gain}}
	end,
	set_ability = function(self, card, initial)
		card.ability.extra.base = card.ability.extra.xmult
	end,
	calculate = function(self, card, context)
        if context.after then
            card.ability.extra.xmult = card.ability.extra.base
			card.ability.extra.last_triggered = nil
        end
		if context.cardarea == G.play and context.individual and not context.blueprint and not context.retrigger_joker and not SMODS.has_no_rank(context.other_card) then
			if card.ability.extra.last_triggered == context.other_card.base.id then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_gain",
					message_key = 'a_xmult'
				})
			end
			card.ability.extra.last_triggered = context.other_card.base.id
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
})