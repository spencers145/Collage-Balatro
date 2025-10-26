-- region Winged Strawberry

local wingedstrawberry = {
	name = "ccc_Winged Strawberry",
	key = "wingedstrawberry",
	config = { extra = { --[[winged_poker_hand = 'Pair', money = 4,]] mult_scored = 2, mult_in_hand = 1 } },
	pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 5,
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
    --description = "Earn $3 if poker hand does not contain a randomly chosen hand. Changes each round",
    set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

wingedstrawberry.in_pool = function ()
	if G.playing_cards then
		for i=1 , #G.playing_cards do
			if SMODS.has_enhancement(G.playing_cards[i], 'm_sarc_strawberry') then
				return true
			end
		end
	end

	return false
end

--[[wingedstrawberry.set_ability = function(self, card, initial, delay_sprites)
	local _poker_hands = {}
	for k, v in pairs(G.GAME.hands) do
		if v.visible and k ~= 'High Card' then
			_poker_hands[#_poker_hands + 1] = k
		end
	end
	card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('winged'))
end]]

wingedstrawberry.calculate = function(self, card, context)
	if context.individual and SMODS.has_enhancement(context.other_card, 'm_sarc_strawberry') and not context.end_of_round then
		if context.cardarea == G.play then
			return {
				mult = card.ability.extra.mult_scored,
				card = context.other_card
			}
		elseif context.cardarea == G.hand then
			return {
				mult = card.ability.extra.mult_in_hand,
				card = context.other_card
			}
		end
	end
	--[[if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
		if not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.winged_poker_hand and k ~= 'High Card' then
					_poker_hands[#_poker_hands + 1] = k
				end
			end
			card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('winged'))
		end
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Reset", colour = G.C.FILTER })
	end
	if context.cardarea == G.jokers then
		if context.before and not context.end_of_round then
			if not next(context.poker_hands[card.ability.extra.winged_poker_hand]) then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
				G.E_MANAGER:add_event(Event({ func = (function()
					G.GAME.dollar_buffer = 0; return true
				end) }))
				return {
					dollars = card.ability.extra.money,
					colour = G.C.MONEY
				}
			else
				G.E_MANAGER:add_event(Event({
				func = function()
				play_sound('tarot1')
				card.T.r = -0.2
				card:juice_up(0.3, 0.4)
				card.states.drag.is = true
				card.children.center.pinch.x = true
				G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
				func = function()
				G.jokers:remove_card(card)
					card:remove()
					card = nil
					return true
				end
					}))
					return true
				end
				}))
				return {
					message = localize('k_eaten_ex'),
					colour = G.C.RED,
				}
			end
		end
	end]]
end



function wingedstrawberry.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = G.P_CENTERS.m_sarc_strawberry
	return { vars = { card.ability.extra.mult_scored, card.ability.extra.mult_in_hand } }
end

return wingedstrawberry
-- endregion Winged Strawberry