SMODS.Joker {
    key = "roulette",
    name = "Russian Roulette",
    atlas = 'rouletteatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    config = {
        extra = {
			money = 15, odds = 6,
		    pos_override = { x = 0, y = 0 } -- default like normal pos
		} 
    },
    loc_txt = {set = 'Joker', key = 'j_buf_roulette'},
	loc_vars = function(self, info_queue, card)
		local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { 
			vars = { n, d, card.ability.extra.money}
		}
	end,
	-------- THANKS, FLOWIRE! --------
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				-- Is this neccessary? No!
				-- Did I do it anyways? Yeah...
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				return true
			end
		}))
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			should_jiggle = false
			if SMODS.pseudorandom_probability(card, pseudorandom('roulette'), 1, card.ability.extra.odds, 'roulette') then
				card:juice_up(0.8, 0.5)
				SMODS.calculate_effect({message = localize('buf_ydead'), colour = G.C.RED}, card)
				play_sound('buf_roul2', 0.96+math.random()*0.08, 0.7)
				card.ability.extra.pos_override.x = 1
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				card.ability.extra.odds = math.max(card.ability.extra.odds - 1, 1)
				G.E_MANAGER:add_event(  -- Thanks WilsontheWolf for the help! (and code!)
					Event({
						trigger = "after",
						delay = 0.2,
						func = function()
							card.ability.extra.pos_override.x = 0
							card.children.center:set_sprite_pos(card.ability.extra.pos_override)
							if G.STATE ~= G.STATES.SELECTING_HAND then
								return false
							end
							G.STATE = G.STATES.HAND_PLAYED
							G.STATE_COMPLETE = true
							end_round()
							return true
						end,
					}),
					"other"
				)
			else
				if card.ability.extra.odds == 2 then -- when chance is 1/2, create a Legendary Joker
					card.ability.extra.odds = math.max(card.ability.extra.odds - 1, 1)
					play_sound('buf_roul1', 0.96+math.random()*0.08)
					G.GAME.joker_buffer = G.GAME.joker_buffer + 1
					G.E_MANAGER:add_event(Event({
						func = function() 
							card:start_dissolve()
							_card = SMODS.add_card({set = 'Joker', rarity = 'Legendary'})
							SMODS.calculate_effect({message = localize('k_plus_joker'), colour = G.C.BLUE}, _card)
							return true
						end}))   
				else
					card:juice_up(0.8, 0.5)
					SMODS.calculate_effect({message = localize('buf_dry'), colour = G.C.GREEN}, card)
					play_sound('buf_roul1', 0.96+math.random()*0.08)
					delay(0.8)
					ease_dollars(card.ability.extra.money)
					card.ability.extra.odds = math.max(card.ability.extra.odds - 1, 1)
					if card.ability.extra.odds > 2 then card.ability.extra.money = card.ability.extra.money + 5 end
				end
			end
		end
	end
}