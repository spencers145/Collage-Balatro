SMODS.Joker {
    key = "building_bricks",
    discovered = false,
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 6, y = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_vis_plastic
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local plastic_card = create_playing_card({ center = G.P_CENTERS.m_vis_plastic }, G.discard, false, false, nil, true)
            G.E_MANAGER:add_event(Event({
                func = function()
                    plastic_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                    G.play:emplace(plastic_card)
                    return true
                end
            }))
            return {
                message = localize('k_plus_plastic'),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function() -- This is for timing purposes, everything here runs after the message
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            return true
                        end
                    }))
                    draw_card(G.play, G.deck, 90, 'up')
                    SMODS.calculate_context({ playing_card_added = true, cards = { plastic_card } })
                end
            }
        end
    end
}