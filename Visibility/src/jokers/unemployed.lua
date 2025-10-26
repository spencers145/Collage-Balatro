-- Unemployed Joker
SMODS.Joker {
    key = "unemployed",
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
	brainstorm_compat = false,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
    config = { extra = { generated_card = nil }},
    rarity = 2,
    atlas = "TextureAtlasJokers",
    pos = { x = 4, y = 0},
    cost = 6,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards = create_card("Food", G.jokers, nil, nil, nil, nil, nil)
			cards:add_to_deck()
			cards:set_edition('e_negative', false)
			G.jokers:emplace(cards)
			card.ability.extra.generated_card = cards
			cards.sell_cost = -5
		end
		if not context.other_card and context.end_of_round and not context.game_over and card.ability.extra.generated_card then
			G.E_MANAGER:add_event(Event({
				delay = 0.01,
				trigger = "after",
				func = function ()
					local cards = card.ability.extra.generated_card
					if not cards or not cards.remove_from_deck then return true end
					
					cards:remove_from_deck()
					cards:start_dissolve(nil)
					card.ability.extra.generated_card = nil
					return true
				end
			}))
			
		end
	end,
}