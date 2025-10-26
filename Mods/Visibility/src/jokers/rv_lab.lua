SMODS.Joker {
	key = "rv_lab",
	atlas = "TextureAtlasJokers",
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	rarity = 3,
	pools = { ["Visibility"] = true },
	cost = 10,
	pos = { x = 6, y = 0 },
	config = { extra = { xchips = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and (context.other_card:get_id() == 11 or (context.other_card:get_id() == 14 and next(SMODS.find_card("j_vis_living_card")))) then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    xchips = card.ability.extra.xchips
                }
            end
        end
    end,
	joker_display_def = function (JokerDisplay)
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "xchips", retrigger_type = "exp" }
					},
					border_colour = G.C.CHIPS
				}	
			},
			calc_function = function(card)
				local playing_hand = next(G.play.cards)
				local count = 0
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_hand or not playing_card.highlighted then
						if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:get_id() == 11 then
							count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
						end
					end
				end
				card.joker_display_values.xchips = card.ability.extra.xchips ^ count
			end
		}
	end
}
