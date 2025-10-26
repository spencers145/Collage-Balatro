SMODS.Joker {
	key = "job",
	config = { extra = { judgement_odds = 2, wraith_odds = 4} },
	rarity = 1,
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 2 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.judgement_odds)
		return { vars = { n, card.ability.extra.judgement_odds, card.ability.extra.wraith_odds } }
	end,
	calculate = function(self, card, context)
		if context.before and context.main_eval then
			local card_to_generate = nil

			if context.scoring_name == 'Full House' then
				if SMODS.pseudorandom_probability(card, pseudorandom('job_application'), 1, card.ability.extra.judgement_odds, 'job_application') then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					card_to_generate = 'c_judgement'
				end
			elseif context.scoring_name == 'Flush House' then
				if SMODS.pseudorandom_probability(card, pseudorandom('job_applicationw'), 1, card.ability.extra.wraith_odds, 'job_applicationw') then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					card_to_generate = 'c_wraith'
				end
			end

			if card_to_generate and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.2,
					func = function()
						local n_card = create_card(nil,G.consumeables, nil, nil, nil, nil, card_to_generate)
						n_card:add_to_deck()
						G.consumeables:emplace(n_card)
						G.GAME.consumeable_buffer = 0
						return true
					end
				}))
				return { message = 'You got the job!' }
			end
		end
	end
}