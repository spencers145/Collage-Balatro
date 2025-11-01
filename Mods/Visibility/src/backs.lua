SMODS.Back({
    key = "poptart",
    atlas = "TextureAtlasDecks",
    pos = { x = 0, y = 0 },
    unlocked = false,
    config = { vouchers = { "v_losted_stapler" } },
    apply = function (self, back)
        G.E_MANAGER:add_event(Event({
            func = function ()
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        G.E_MANAGER:add_event(Event({
                            func = function ()
                                add_tag(Tag('tag_buffoon'))
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
    end
})

--[[SMODS.Back {
    key = "rolling",
    atlas = "TextureAtlasDecks",
    pos = { x = 4, y = 0 },
    config = { vouchers = { 'v_reroll_surplus', "v_ortalab_window_shopping" } },
    loc_vars = function (self, info_queue, card)
        return { vars = { "Reroll Surplus", "Window Shopping" } }
    end,
    unlocked = true,
    discovered = true,
    --[[apply = function(self,back)
        change_shop_size(-1)
    end]]
--}

SMODS.Back {
    key = "gardening",
    atlas = "TextureAtlasDecks",
    pos = { x = 1, y = 0 },
    unlocked = false,
    config = {},
    --unlock_condition = {type = 'discover_amount', amount = 500},
    apply = function(self, back)
        --[[G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.playing_cards) do
                    if v.base.suit == 'Spades' or v.base.suit == 'Hearts' then
                        v:remove()
                    end
                end
                return true
            end
        }))]]
    end,
    after_round = function(self, args)
        if args.context == 'eval' and #G.deck.cards > 0 then
            --[[local _card2 = copy_card(val2, nil, nil, G.playing_card)
            _card2.states.visible = false
            
            G.E_MANAGER:add_event(Event({
            func = function()
                _card2:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                G.deck:emplace(_card2)
                table.insert(G.playing_cards, _card2)
                playing_card_joker_effects({true})
                _card2:start_materialize()
                return true
            end}))]]

             G.E_MANAGER:add_event(Event({
                func = function()
                    local new_card = create_playing_card(nil, G.deck)
                    new_card:add_to_deck()
                    SMODS.change_base(new_card, nil, pseudorandom_element(SMODS.Ranks, pseudoseed('gardening_weed')), nil)
                    SMODS.debuff_card(new_card, true, 'b_vis_gardening')
                    playing_card_joker_effects({new_card})
                    forced_message("Weeds...", new_card)
                return true
            end}))
        end
    end,
    calculate = function (self, back, context)
        if context.end_of_round and context.main_eval then
            local val = G.hand.cards[1]
            if not val then return end
            local _card = copy_card(val, nil, nil, G.playing_card)
            _card.states.visible = false
            
            forced_message("Sprouted!", val)

            G.E_MANAGER:add_event(Event({
            func = function()
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                G.deck:emplace(_card)
                table.insert(G.playing_cards, _card)
                playing_card_joker_effects({true})
                _card:start_materialize()
                return true
            end}))
            delay(0.8)
        end
    end
}

SMODS.Back {
    key = "heavenly",
    atlas = "TextureAtlasDecks",
    pos = { x = 2, y = 0 },
    --config = { consumables = { 'c_vis_mind' } },
    unlocked = false,
    discovered = false,
    apply = function (self, back)
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
    end
}

--[[SMODS.Back {
    key = "burnt",
    atlas = "TextureAtlasDecks",
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    calculate = function (self, back, context)
        if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            return {
                level_up = true,
                level_up_hand = text
            }
        end
    end
}]]