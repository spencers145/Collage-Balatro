SMODS.Joker {
	key = 'teto',
	config = { extra = { triggered = false } },
	rarity = 2,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 8, y = 0 },
	cost = -7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.triggered and "{s:0}" or "Active!" } }
    end,
    calculate = function (self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return not card.ability.extra.triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and not card.ability.extra.triggered then
            local poker_hands = evaluate_poker_hand(context.full_hand)
            if next(poker_hands["Two Pair"]) then
                card.ability.extra.triggered = true
                -- Create an uncommon tag
                local tag = Tag("tag_uncommon")
                add_tag(tag)
                return {
                    message = "Teto Territory!"
                }
            end
        end
        if context.end_of_round and not context.game_over then
            card.ability.extra.triggered = false
        end
    end,
    joker_display_def = function(JokerDisplay)
		--- @type JDJokerDefinition
		return {
			reminder_text = {
				{ ref_table = "card.joker_display_values", ref_value = "active_text" },
			},
			calc_function = function(card)
				local active = not card.ability.extra.triggered
				card.joker_display_values.active = active
				card.joker_display_values.active_text = active and localize('k_active') or "inactive"
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