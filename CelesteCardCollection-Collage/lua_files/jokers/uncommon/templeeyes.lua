--region Temple Eyes

local templeeyes = {
	name = "ccc_Temple Eyes",
	key = "templeeyes",
	config = { extra = { max_money = 9 } },
	pos = { x = 1, y = 0 },
	rarity = 2,
	cost = 6,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "toneblock",
		code = "toneblock",
		concept = "toneblock"
	},
    description = "If Blind is selected with $9 or less, create a Hanged Man"
}

templeeyes.calculate = function(self, card, context)
	if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
		if to_big(G.GAME.dollars) <= to_big(card.ability.extra.max_money) then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			return {
				G.E_MANAGER:add_event(Event({
					func = (function()
						G.E_MANAGER:add_event(Event({
							func = function()
								local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_hanged_man',
									'see')
								card:add_to_deck()
								G.consumeables:emplace(card)
								G.GAME.consumeable_buffer = 0
								return true
							end
						}))
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = localize('k_plus_tarot'), colour = G.C.PURPLE })
						return true
					end)
				}))
			}
		end
	end
end

function templeeyes.loc_vars(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_CENTERS.c_hanged_man
	return { vars = { card.ability.extra.max_money } }
end

return templeeyes
-- endregion Temple Eyes