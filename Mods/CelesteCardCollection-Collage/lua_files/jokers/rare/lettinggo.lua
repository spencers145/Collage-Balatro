-- region Letting Go

local lettinggo = {
	name = "ccc_Letting Go",
	key = "lettinggo",
	config = { extra = { xmult = 1, prob_success = 2, xmult_scale = 0.2 } },
	pos = { x = 2, y = 2 },
	rarity = 3,
	cost = 8,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "bein",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "When a card is destroyed, 1 in 2 chance to create a Death. Gains +0.15 XMult for each Death used"
}

lettinggo.calculate = function(self, card, context)
	if context.cards_destroyed then
		local death_chances = 0
		for k, v in ipairs(context.glass_shattered) do
			death_chances = death_chances + 1
		end
		for i = 1, death_chances do
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				if SMODS.get_probability_vars(card, pseudoseed('lettinggo'), 1, card.ability.extra.prob_success, 'lettinggo') then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
							G.E_MANAGER:add_event(Event({
								func = function()
									local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_death',
										'lgo')
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
				end
			end
		end
		return nil, true
	end

	if context.remove_playing_cards and context.removed ~= nil then -- it's just the same thing as before, folks
		local death_chances = 0
		for k, val in ipairs(context.removed) do
			death_chances = death_chances + 1
		end
		for i = 1, death_chances do
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				if SMODS.get_probability_vars(card, pseudoseed('lettinggo'), 1, card.ability.extra.prob_success, 'lettinggo') then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = (function()
							G.E_MANAGER:add_event(Event({
								func = function()
									local card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_death',
										'lgo')
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
				end
			end
		end
		return nil, true
	end

	if context.using_consumeable then
		if context.consumeable.ability.name == 'Death' then
			if not context.blueprint then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_scale
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
					{ message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } })
			end
		end
	end

	if context.joker_main then
		if card.ability.extra.xmult > 1 then
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

function lettinggo.loc_vars(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_CENTERS.c_death
	local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.prob_success, 'lettinggo')
	return { vars = { '' .. n, card.ability.extra.xmult, d, card.ability.extra.xmult_scale } }
end

return lettinggo
-- endregion Letting Go