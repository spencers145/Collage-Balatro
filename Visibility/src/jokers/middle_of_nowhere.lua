SMODS.Joker {
	key = 'middle_of_nowhere',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { retriggers = 1, cond_discards = 3 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 7, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
        return { 
			vars = { 
				card.ability.extra.retriggers, 
				card.ability.extra.cond_discards, 
				G.GAME.current_round.discards_used == card.ability.extra.cond_discards 
				and "Active!" 
				or G.GAME.current_round.discards_used.."/"..card.ability.extra.cond_discards
			}
		}
	end,
	calculate = function(self, card, context)
		if context.discard then
			local eval = function() return G.GAME.current_round.discards_used == card.ability.extra.cond_discards and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
		end
		if context.repetition and context.cardarea == G.play then
            if G.GAME.current_round.discards_used == card.ability.extra.cond_discards then
                return {
                    repetitions = card.ability.extra.retriggers
                }
            end
        end
    end,
	joker_display_def = function(JokerDisplay)
		--- @type JDJokerDefinition
		return {
			reminder_text = {
				{ ref_table = "card.joker_display_values", ref_value = "active_text" },
			},
			calc_function = function(card)
				local active = G.GAME.current_round.discards_used == card.ability.extra.cond_discards
				card.joker_display_values.active = active
				card.joker_display_values.active_text = active and localize('k_active') or G.GAME.current_round.discards_used .. "/" .. card.ability.extra.cond_discards
			end,
			style_function = function(card, text, reminder_text, extra)
				if reminder_text and reminder_text.children[1] then
					reminder_text.children[1].config.colour = card.joker_display_values.active and G.C.GREEN or G.C.RED
					reminder_text.children[1].config.scale = card.joker_display_values.active and 0.35 or 0.3
					return true
				end
				return false
			end
		}
	end
}