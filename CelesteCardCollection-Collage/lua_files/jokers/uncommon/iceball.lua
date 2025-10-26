-- region Iceball

local iceball = {
	name = "ccc_Iceball",
	key = "iceball",
	config = {extra = {active = true, xmult = 3, count = 0}},
	pos = {x = 5, y = 8},
	rarity = 2,
	cost = 8,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "9Ts",
		code = "toneblock",
		concept = "Fytos"
	},
    description = "If your score display didn't catch fire in the previous round X3 mult"
}

iceball.calculate = function(self, card, context)
	if context.ccc_switch and context.ccc_switch['fire'] and not context.blueprint then
		local old_count = card.ability.extra.count
		card:set_ability(G.P_CENTERS['j_ccc_fireball'])
		card.ability.extra.count = old_count
	end
	if context.ccc_fire and not context.blueprint then
		card.ability.extra.count = 2	-- this int is to track state
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Fire", colour = G.C.RED})
	end
	if context.end_of_round and context.main_eval and not context.blueprint then
		card.ability.extra.count = math.max(0, card.ability.extra.count - 1)
		card.ability.extra.active = card.ability.extra.count == 0 and true or false
	end
	if context.joker_main then
		if card.ability.extra.active then
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

function iceball.loc_vars(self, info_queue, card)
	return {vars = {}}
end

return iceball
-- endregion Iceball