SMODS.Consumable({
	object_type = "Consumable",
	atlas = 'arts_atlas',
	key = 'art_scissors',
	set = 'art',
	name = 'Scissors',
	config = {
		max_highlighted = 1
	},
	pos = { x = 1, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = false,

	use = function(self, card, area)
		local selected = G.hand.highlighted[1]
		local slots = G.consumeables.config.card_limit - #G.consumeables.cards

		if selected.edition and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

			G.E_MANAGER:add_event(Event({
				func = function()
					ArtBox.create_collectable(selected.edition.key)
					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
		end

		if selected.seal and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

			G.E_MANAGER:add_event(Event({
				func = function()
					ArtBox.create_collectable(selected.seal)
					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
		end

		if selected.config.center.key ~= 'c_base' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1

			G.E_MANAGER:add_event(Event({
				func = function()
					ArtBox.create_collectable(selected.config.center.key)
					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
		end

		SMODS.destroy_cards(selected)
	end,

	can_use = function(self, card, area)
		return next(G.hand.highlighted) and #G.hand.highlighted <= card.ability.consumeable.max_highlighted
	end
})
