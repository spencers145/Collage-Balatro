-- region To The Summit

local tothesummit = {
	name = "ccc_To The Summit",
	key = "tothesummit",
	config = { extra = { xmult = 1, min_money = 0, xmult_scale = 0.25 } }, -- rip debt lovers
	pos = { x = 0, y = 1 },
	rarity = 3,
	
	cost = 7,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Aurora Aquir"
	},
    description = "Gains +0.25 XMult for each consecutive Blind selected with more money than the previous Blind",
}


tothesummit.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		if to_big(card.ability.extra.min_money) >= math.max(0, (to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0))) then
			local last_xmult = card.ability.extra.xmult
			card.ability.extra.xmult = 1
			if last_xmult > 1 then
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
					{ message = "Reset", colour = G.C.FILTER })
			end
			card.ability.extra.min_money = math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
		elseif to_big(card.ability.extra.min_money) < math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0))) then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_scale
			card_eval_status_text(card, 'extra', nil, nil, nil,
				{ message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } })
			card.ability.extra.min_money = math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)))
		end
	end
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				Xmult_mod = card.ability.extra.xmult
			}
		end
	end
end

function tothesummit.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.xmult, card.ability.extra.min_money, card.ability.extra.xmult_scale } }
end

return tothesummit
-- endregion To The Summit