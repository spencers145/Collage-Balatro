SMODS.Consumable({
	object_type = "Consumable",
	atlas = 'arts_atlas',
	key = 'art_mystery_box',
	set = 'art',
	name = 'Mystery Box',
	pos = { x = 2, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = false,

	loc_vars = function (self, info_queue, card)
		info_queue[#info_queue + 1] = {key = 'artb_mod_collectable_explain', set = 'Other'}
	end,

	use = function(self, card, area)

		while #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit do
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			local random_roll = pseudorandom("box")

			local player_has_paperclips = false
			for key, value in pairs(G.playing_cards) do
				if PB_UTIL.has_paperclip(value) then
				player_has_paperclips = true
				end
			end

			if random_roll<0.05 then
				G.E_MANAGER:add_event(Event({
				  func = function()
					ArtBox.create_collectable(poll_edition('mystery', nil, true, true))
					G.GAME.consumeable_buffer = 0
					return true
				  end
			    }))
			elseif random_roll<0.3 then
				G.E_MANAGER:add_event(Event({
				  func = function()
		            ArtBox.create_collectable(pseudorandom_element({'Red', 'Blue', 'Purple', 'Gold'}, pseudoseed("mystery")))
					G.GAME.consumeable_buffer = 0
					return true
				  end
			    }))
			else
				if player_has_paperclips and pseudorandom(pseudoseed("mystery_box_clip" .. G.GAME.round_resets.ante)) > 0.5 then
					G.E_MANAGER:add_event(Event({
					func = function()
						ArtBox.create_collectable(PB_UTIL.poll_paperclip('mystery'))
						G.GAME.consumeable_buffer = 0
						return true
					end
					}))
				else
					G.E_MANAGER:add_event(Event({
					func = function()
						ArtBox.create_collectable(SMODS.poll_enhancement({guaranteed = true, key = 'mystery'}))
						G.GAME.consumeable_buffer = 0
						return true
					end
					}))
				end
			end
        end
	end,

	can_use = function(self, card, area)
		return true
	end
})
