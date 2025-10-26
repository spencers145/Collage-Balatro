-- region Core Switch

local coreswitch = {
	name = "ccc_Core Switch",
	key = "coreswitch",
	config = { extra = { pos_override = { x = 6, y = 0 }, discards = 2 } },
	pos = { x = 6, y = 0 },
	rarity = 2,
	cost = 5,
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie & Aurora Aquir",
		code = "toneblock",
		concept = "Aurora Aquir"
	},
    description = "Swap hands and discards on blind select. +1 discard after swap",
	afterload = function(self, card, card_table, other_card)
		card.children.center:set_sprite_pos(card_table.ability.extra.pos_override)
	end
}

coreswitch.set_ability = function(self, card, initial, delay_sprites)
	card.ability.extra.pos_override.x = pseudorandom_element({ 6, 7 }, pseudoseed('coreswitch'))
	card.children.center:set_sprite_pos(card.ability.extra.pos_override)
end

coreswitch.calculate = function(self, card, context)
	card.children.center:set_sprite_pos(card.ability.extra.pos_override)
	if context.first_hand_drawn and not card.getting_sliced and not context.blueprint and not context.individual then
		G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = immediate,
			func = function()
				local coreswitch_hand_juggle = G.GAME.current_round.discards_left
				ease_discard(
				card.ability.extra.discards + (G.GAME.current_round.hands_left - G.GAME.current_round.discards_left), nil,
					true)
				ease_hands_played(coreswitch_hand_juggle - G.GAME.current_round.hands_left, nil, true)
				card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Swapped", colour = G.C.FILTER })
				if card.ability.extra.pos_override.x == 6 then
					card.ability.extra.pos_override.x = 7
					SMODS.calculate_context({ ccc_switch = { ice = true } })
				else
					card.ability.extra.pos_override.x = 6
					SMODS.calculate_context({ ccc_switch = { fire = true } })
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = function()
						save_run()
						return true
					end
				}))
				--[[
				if coreswitch_hand_juggle == 0 then -- you're a dumbass lol
					end_round()
				end
				]]
				return true
			end
		}))
		return nil, true
	end
	if context.pre_discard and G.GAME.current_round.hands_left == 0 and not context.hook then
		end_round()
	end
end

local gfcpref = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
	if G.GAME.current_round.hands_left == 0 then
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	else
		gfcpref(e)
	end
end

function coreswitch.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.discards } }
end

return coreswitch
-- endregion Core Switch
