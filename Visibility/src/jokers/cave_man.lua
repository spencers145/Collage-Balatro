-- Cave Man
SMODS.Joker {
	key = 'cave_man',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { odds = 3 } },
	rarity = 1,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 0, y = 2 },
	cost = 3,
	loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_stone') then
			if #G.consumeables.cards >= G.consumeables.config.card_limit then
				return
			end
			if pseudorandom(pseudoseed('caveman')) < G.GAME.probabilities.normal / card.ability.extra.odds then
				local tarot_card = create_card('Tarot', G.consumeables)
				tarot_card:add_to_deck()
				G.consumeables:emplace(tarot_card)
				return { message = 'Ooga Booga.'}
			else
				return { message = 'Rock.' }
			end
		end
    end,
	in_pool = function(self, card)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
	end,
	joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "count" },
            },
            text_config = { colour = G.C.PURPLE },
			extra = {
                {
                    { text = "("},
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")"},
                }
            },
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if SMODS.has_enhancement(scoring_card, 'm_stone') then
                            count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.count = count
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
        }
    end
}