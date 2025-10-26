-- Blood Pact
SMODS.Joker {
	key = 'blood_pact',
	config = { extra = { } },
	rarity = 2,
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 2, y = 0 },
	cost = 8,
	loc_vars = function (self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS.Red
	end,
	calculate = function(self, card, context)
	    if context.destroy_card and context.cardarea == G.play then
			if context.destroy_card:get_id() == 6 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local _eligable_cards = {}
						for k, v in pairs(G.hand.cards) do
							if not v:get_seal(true) then
								_eligable_cards[#_eligable_cards+1] = v
							end
						end
						if #_eligable_cards == 0 then return true end
						local changed_card, card_key = pseudorandom_element(_eligable_cards, pseudoseed('blood_pact'))
						changed_card:set_seal('Red', true)
						changed_card:juice_up(0.3, 0.4)
						table.remove(_eligable_cards, card_key)
						play_sound('gold_seal')
						return true
					end
				}))
				return { remove = true, message = 'It\'s a deal.' }
			end
	    end
	end,
	joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "seal_count" },
				{ text = " Seals"}
            },
            text_config = { colour = G.C.RED },
            reminder_text_config = { scale = 0.3, colour = G.C.GREY },
            calc_function = function (card)
                card.joker_display_values.seal_count = 0
                for k, v in pairs(G.hand.highlighted) do
                    if v:get_id() == 6 then
                        card.joker_display_values.seal_count = card.joker_display_values.seal_count + 1
                    end
                end
            end
        }
    end
}