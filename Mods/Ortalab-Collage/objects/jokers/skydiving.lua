SMODS.Joker({
	key = "skydiving",
	atlas = "jokers",
	pos = {x=0,y=3},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {curr_xmult = 1, xmult_add = 0.3, level_loss = 1}},
	artist_credits = {'alex'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult_add, card.ability.extra.curr_xmult, card.ability.extra.level_loss}}
    end,
	calculate = function(self, card, context)
		if context.before and G.GAME.hands[context.scoring_name].level ~= 1 and not context.blueprint and not context.retrigger_joker then
			if to_big(G.GAME.hands[context.scoring_name].level) > to_big(1) then
				SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "curr_xmult",
                    scalar_value = "xmult_add",
                    message_key = 'a_xmult'
                })
				return {
					level_up = -card.ability.extra.level_loss,
					no_retrigger = true
				}
			end
		end
		if context.joker_main and card.ability.extra.curr_xmult > 1 then
			return {
				xmult = card.ability.extra.curr_xmult
			}
		end
	end
})
