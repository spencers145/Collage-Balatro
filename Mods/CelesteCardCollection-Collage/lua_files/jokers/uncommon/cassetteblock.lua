-- region Cassette Block

local cassetteblock = {
	name = "ccc_Cassette Block",
	key = "cassetteblock",
	config = { extra = { chips = 1, mult = 1, chips_scale = 0.2, mult_scale = 0.2, pink = false, pos_override = { x = 6, y = 2 } } },
	pos = { x = 6, y = 2 },
	rarity = 2,
	cost = 6,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
	description = "Blue: Gains +12 Chips for each unused hand at the end of round. Pink: Gains +3 Mult for each unused discard at the end of round. Swaps at start of round",
	afterload = function(self, card, card_table, other_card)
		card.children.center:set_sprite_pos(card_table.ability.extra.pos_override)
	end
}

cassetteblock.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		if card.ability.extra.pink == false then
			return {
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card.ability.extra.pink = true
								card.ability.extra.pos_override.x = 7
								card.children.center:set_sprite_pos(card.ability.extra.pos_override)

								return true
							end
						}))
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = "Swap", colour = G.C.RED })
						return true
					end
				}))
			}
		else
			return {
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								card.ability.extra.pink = false
								card.ability.extra.pos_override.x = 6
								card.children.center:set_sprite_pos(card.ability.extra.pos_override)

								return true
							end
						}))
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = "Swap", colour = G.C.BLUE })
						return true
					end
				}))
			}
		end
	end

	if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
		if card.ability.extra.pink == false then
			if G.GAME.current_round.hands_left > 0 then
				card.ability.extra.chips = card.ability.extra.chips +
				card.ability.extra.chips_scale * G.GAME.current_round.hands_left

				G.E_MANAGER:add_event(Event({
					func = function()
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = "Upgrade!", colour = G.C.FILTER })
						return true
					end
				}))
			end
		else
			if G.GAME.current_round.discards_left > 0 then
				card.ability.extra.mult = card.ability.extra.mult +
				card.ability.extra.mult_scale * G.GAME.current_round.discards_left

				G.E_MANAGER:add_event(Event({
					func = function()
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = "Upgrade!", colour = G.C.FILTER })
						return true
					end
				}))
			end
		end
	end

	if context.joker_main then
		if card.ability.extra.pink == false then
			if card.ability.extra.chips ~= 1 then
				return {
					message = localize {
						type = 'variable',
						key = 'a_xchips',
						vars = { card.ability.extra.chips }
					},
					x_chips_mod = card.ability.extra.chips
				}
			end
		else
			if card.ability.extra.mult ~= 1 then
				return {
					message = localize {
						type = 'variable',
						key = 'a_xmult',
						vars = { card.ability.extra.mult }
					},
					x_mult_mod = card.ability.extra.mult
				}
			end
		end
	end
end

function cassetteblock.loc_vars(self, info_queue, card)
	return { key = (card.ability.extra.pink and "j_ccc_cassette_block_pink" or card.config.center.key), vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.chips_scale, card.ability.extra.mult_scale, card.ability.extra.pink } }
end

return cassetteblock
-- endregion Cassete Block