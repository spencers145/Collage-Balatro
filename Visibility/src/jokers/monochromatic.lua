-- Monochromatic Joker
SMODS.Joker {
	key = 'monochromatic_joker',
	config = { extra = { odds = 3 } },
	rarity = 2,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = false,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 1, y = 0 },
	credits = {
        developer = true
    },
	cost = 7,
	loc_vars = function(self, info_queue, card)
	    info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'monochromatic_joker')
        return { vars = { n, d } }
	end,
	calculate = function(self, card, context)
	    if context.end_of_round and G.GAME.blind.boss and context.game_over == false then
			local eligable_editionless_jokers = {}
			for k, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and v.edition == nil and v ~= card then
                    table.insert(eligable_editionless_jokers, v)
                end
            end
	        if SMODS.pseudorandom_probability(card, pseudoseed('monochromatic_joker'), 1, card.ability.extra.odds, 'monochromatic_joker') then
				if #eligable_editionless_jokers == 0 then
					return { message = 'No target...' }
				end
	            local joker = pseudorandom_element(eligable_editionless_jokers, pseudoseed('monochromatic_joker'))
	            joker:set_edition('e_negative', true)
				G.E_MANAGER:add_event(Event({
					delay = 0.2,
					trigger = 'before',
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(self)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
	            return { message = localize('k_edition_negative') }
	        else
	            return { message = 'Nope!' }
	        end
	    end
	end,
	joker_display_def = function (JokerDisplay)
		--- @type JDJokerDefinition
		return {
			extra = {
                {
                    { text = "("},
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")"},
                }
            },
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
		}
	end
}