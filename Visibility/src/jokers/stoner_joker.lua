-- Stoner Joker
SMODS.Joker {
	key = "stoner",
	config = { extra = { Xmult = 1.3 } },
	rarity = 2,
	discovered = false,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 0, y = 1 },
	cost = 5,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, 'm_stone') or SMODS.has_enhancement(context.other_card, 'm_sarc_luminice') or SMODS.has_enhancement(context.other_card, 'm_vis_brick'))  then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') or SMODS.has_enhancement(playing_card, 'm_vis_brick') or SMODS.has_enhancement(playing_card, 'm_sarc_luminice') then
				return true
            end
        end
        return false
    end,
	joker_display_def = function (JokerDisplay)
		--- @type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
					}
				}
			},
			reminder_text = {
				{ text = "(" },
				{ text = "stone and brick" },
				{ text = ")" },
			},
			calc_function = function(card)
				local count = 0
				local text, _, scoring_hand = JokerDisplay.evaluate_hand()
				if text ~= 'Unknown' then
					for _, scoring_card in pairs(scoring_hand) do
						if SMODS.has_enhancement(scoring_card, 'm_stone') or SMODS.has_enhancement(scoring_card, 'm_vis_brick') then
							count = count +
								JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
						end
					end
				end
				card.joker_display_values.Xmult = math.max(card.ability.extra.Xmult * count, 1)
			end
		}
	end
}