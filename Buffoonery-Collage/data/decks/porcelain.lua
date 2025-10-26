SMODS.Back {
    key = 'porcelain',
    unlocked = false,
    atlas = 'buf_decks',
    pos = {
        x = 2,
        y = 0,
    },
    config = {
		consumables = { 'c_buf_nobility' },
		--vouchers = { 'v_bunc_hedge_trimmer' }
	},
	loc_vars = function(self, info_queue, card)
		return {vars = {localize{type = 'name_text', key = 'c_buf_nobility', set = 'Tarot'}, localize{type = 'name_text', key = 'v_bunc_hedge_trimmer', set = 'Voucher'}}}
	end,

    apply = function(self)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.8, func = function()
            --[[local card = nil
			if not buf.compat.sleeves or G.GAME.selected_sleeve ~= 'sleeve_buf_porcelain' then
				play_sound('timpani')
				card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_buf_dorkshire', 'por')
				card:add_to_deck()
				G.jokers:emplace(card)
				card:start_materialize()
				card:set_edition()
				G.GAME.joker_buffer = 0
			end]]
			local rmvd_suit = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
			local random = rmvd_suit[math.random(1, 4)]
			local target_suit = random
			local keys_to_remove = {}
			for k, v in pairs(G.playing_cards) do
				if v.base.suit == target_suit then
					table.insert(keys_to_remove, v)
				end
			end
			for i = 1, #keys_to_remove do
				keys_to_remove[i]:remove()
			end
			G.GAME.starting_deck_size = #G.playing_cards
        return true end }))

		G.E_MANAGER:add_event(Event({
			func = function ()
				G.E_MANAGER:add_event(Event({
					func = function ()
						G.E_MANAGER:add_event(Event({
							func = function ()
								add_tag(Tag('tag_vis_divine'))
								play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                				play_sound('holo1', 1.2 + math.random()*0.1, 0.4)

								return true
							end
						}))
						return true
					end
				}))
				return true
			end
		}))
    end,

	calculate = function (self, back, context)
		--[[if context.end_of_round and context.main_eval and context.beat_boss and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({key = 'c_buf_nobility'})
					G.GAME.consumeable_buffer = 0
                return true
            end}))
		end]]
	end
}