SMODS.Joker({
	key = "dropout",
	atlas = "jokers",
	pos = {x=0,y=2},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {rank = "Ace", odds = 3}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ortalab_graduate')
		return {vars = {localize(card.ability.extra.rank, 'ranks'), n, d}}
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and not SMODS.has_no_rank(context.other_card) then
			if SMODS.pseudorandom_probability(card, pseudoseed('ortalab_graduate'), 1, card.ability.extra.odds, 'ortalab_graduate') then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
					return {
						card = card,
						func = function()
							G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                    local cardd = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'chol')
                                    cardd:add_to_deck()
                                    G.consumeables:emplace(cardd)
									cardd:start_materialize()
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end)
                            }))
						end
					}
				end
			end
        end
    end
})