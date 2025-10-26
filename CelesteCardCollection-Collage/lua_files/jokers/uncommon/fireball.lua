-- region Fireball

local fireball = {
	name = "ccc_Fireball",
	key = "fireball",
	config = {extra = {active = false, count = 0}},
	pos = {x = 5, y = 7},
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
		concept = "AstralightSky"
	},
    description = "If your score display catches fire during the round, the next shop has an extra Mega booster pack"
}

fireball.calculate = function(self, card, context)
	if context.ccc_switch and context.ccc_switch['ice'] and not context.blueprint then
		local old_count = card.ability.extra.count
		card:set_ability(G.P_CENTERS['j_ccc_iceball'])
		card.ability.extra.count = old_count
		card.ability.extra.active = card.ability.extra.count == 0 and true or false
	end
	if context.setting_blind and not context.blueprint then
		card.ability.extra.active = false
	end
	if context.ccc_fire and not context.blueprint then
		card.ability.extra.active = true
		card.ability.extra.count = 2
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Fire!", colour = G.C.RED})
	end
	if context.end_of_round and context.main_eval and not context.blueprint then
		card.ability.extra.count = math.max(0, card.ability.extra.count - 1)
	end
	if context.ccc_shop_trigger and card.ability.extra.active then
		card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = '+1 Pack'})
		
		local mega = false
		local center = get_pack('ccc_fireball')
		local c = 0
		
		while c <= 1000 and mega == false do
			if not center.name:find('Mega') then
				center = get_pack('ccc_fireball')
			else
				mega = true
			end
			c = c + 1
		end
		local i = #G.GAME.current_round.used_packs + 1
		local _card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, center, {bypass_discovery_center = true, bypass_discovery_ui = true})
		create_shop_card_ui(_card, 'Booster', G.shop_booster)
		G.GAME.current_round.used_packs[i] = center.key
		_card.ability.booster_pos = i
		_card:start_materialize()
		G.shop_booster:emplace(_card)
	end
end

local fireballerref = end_round
function end_round()
	G.GAME.ccc_fire_triggered = false
	fireballerref()
end

function fireball.loc_vars(self, info_queue, card)
	return {vars = {}}
end

return fireball
-- endregion Fireball