SMODS.Joker {
	key = "insomnia",
	config = { extra = { x_mult = 2 } },
	rarity = 2,
	cost = 5,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = "TextureAtlasJokers",
	pos = { x = 5, y = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
	calculate = function(self, card, context)
		if context.before then
            local first_card = context.scoring_hand[1]
            first_card:juice_up(0.3, 0.5)
            first_card:set_debuff(true)
        end
        if context.joker_main then
            return {
                x_mult = card.ability.extra.x_mult,
            }
        end
	end,
	joker_display_def = function (JokerDisplay)
		return {
			text = {
				{
					border_nodes = {
						{ text = "X" },
						{ ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
					}
				}
			},
			reminder_text = {
				{ text = "(" },
				{ text = "first is debuffed" },
				{ text = ")" }
			},
		}
	end
}