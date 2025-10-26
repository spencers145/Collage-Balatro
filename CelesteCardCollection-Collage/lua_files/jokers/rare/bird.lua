
--region Bird

local bird = {
	name = "ccc_Bird",
	key = "bird",
	config = { extra = { draw = 4, active = false } },
	pos = { x = 2, y = 0 },
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
    description = "Whenever a Planet card is used, draw 4 cards"
}

bird.calculate = function(self, card, context)
	if context.using_consumeable then
		if context.consumeable.ability.set == 'Planet' then
			if (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) or (G.GAME and G.GAME.blind and G.GAME.blind.in_blind) then
				G.E_MANAGER:add_event(Event({
					func = function()
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = "+" .. card.ability.extra.draw .. " Cards", colour = G.C.FILTER })
						G.FUNCS.draw_from_deck_to_hand(card.ability.extra.draw)
						return true
					end
				}))
				return nil, true
			end
		end
	end
end

function bird.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.draw } }
end

return bird
-- endregion Bird