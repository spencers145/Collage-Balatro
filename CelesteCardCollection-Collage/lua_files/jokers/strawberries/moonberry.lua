
-- region Moon Berry

local moonberry = {
	name = "ccc_Moon Berry",
	key = "moonberry",
	config = { extra = { condition_satisfied = false, winged_poker_hand = 'Pair', old_winged_poker_hand = 'Pair', levels = 2 } }, -- old_winged_poker_hand is internal, winged_poker_hand is external
	pos = { x = 5, y = 1 },
	rarity = 2,
	cost = 8,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "IF round ends without playing hand that contains a randomly chosen Hand create its Planet card as a negative. Hand changes every round",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

moonberry.set_ability = function(self, card, initial, delay_sprites)
	local _handname, _played, _order = 'High Card', -1, 100
	for k, v in pairs(G.GAME.hands) do
		if v.played > _played or (v.played == _played and _order > v.order) then 
			_played = v.played
			_handname = k
		end
	end
	card.ability.extra.winged_poker_hand = _handname
	card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand
end

moonberry.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		card.ability.extra.old_winged_poker_hand = card.ability.extra.winged_poker_hand		-- delay old_winged_poker_hand from changing due to brainstorm
	end
	if context.end_of_round and not context.repetition and not context.individual then
		local card_type = 'Planet'
		local _card = context.blueprint_card or card
		if card.ability.extra.condition_satisfied == true then
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					--[[
					local _planet = 0
					for k, v in pairs(G.P_CENTER_POOLS.Planet) do
						if v.config.hand_type == card.ability.extra.old_winged_poker_hand then -- use old_winged_poker_hand
							_planet = v.key
						end
					end
					local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
					card:set_edition({ negative = true }, true)
					card:add_to_deck()
					G.consumeables:emplace(card)
					]]
					local _hand = card.ability.extra.old_winged_poker_hand
					update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(_hand, 'poker_hands'),chips = G.GAME.hands[_hand].chips, mult = G.GAME.hands[_hand].mult, level=G.GAME.hands[_hand].level})
					level_up_hand(_card, _hand, nil, card.ability.extra.levels)
					update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
					return true
				end)
			}))
		end
		if not context.blueprint then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = (function()
					local _handname, _played, _order = 'High Card', -1, 100
					for k, v in pairs(G.GAME.hands) do
						if v.played > _played or (v.played == _played and _order > v.order) then 
							_played = v.played
							_handname = k
						end
					end
					card.ability.extra.winged_poker_hand = _handname
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Reset", colour = G.C.FILTER })
					return true
				end)
			}))
		end
		if card.ability.extra.condition_satisfied == true then
			card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
				{ message = localize('k_level_up_ex'), colour = G.C.FILTER })
			return nil, true
		end
	end
	if context.cardarea == G.jokers then
		if context.before and not context.end_of_round then
			if context.scoring_name == card.ability.extra.winged_poker_hand and not context.blueprint then
				card.ability.extra.condition_satisfied = false
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
				{ message = localize(card.ability.extra.winged_poker_hand, 'poker_hands'), colour = G.C.RED })
			end
		end
	end
	if context.setting_blind then
		card.ability.extra.condition_satisfied = true
	end
end

function moonberry.loc_vars(self, info_queue, card)
	--info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
	return { vars = { card.ability.extra.winged_poker_hand, card.ability.extra.levels } }
end

return moonberry
-- endregion Moon Berry