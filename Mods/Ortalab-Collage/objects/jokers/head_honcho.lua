SMODS.Joker({
	key = "head_honcho",
	atlas = "jokers",
	pos = {x=0,y=10},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {cards = 1, money_loss = 2}},
	artist_credits = {'crimson'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.money_loss}}
	end,
	calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = '-'..localize('$')..card.ability.extra.money_loss, colour = G.C.RED})
            ease_dollars(-card.ability.extra.money_loss)
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({func = function()
                local card = SMODS.create_card({set = 'ortalab_loteria', key_append = 'loteria_joker'})
                card:add_to_deck()
                G.consumeables:emplace(card)
				G.GAME.consumeable_buffer = math.max(0, G.GAME.consumeable_buffer - 1)
                card:juice_up(0.3, 0.5)
                return true
            end}))
        end
    end
})