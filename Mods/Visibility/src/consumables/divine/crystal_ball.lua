SMODS.Consumable {
    key = "crystal_ball",
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 0 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['bunc_consumable_edition_polychrome']
        info_queue[#info_queue+1] = G.P_CENTERS['collage_perishable_consumable']
    end,
    use = function(self, card, area, copier)
        --if G.consumeables.config.card_limit <= #G.consumeables.cards then return end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if G.consumeables and G.consumeables.cards then
                    for key, value in pairs(G.consumeables.cards) do
                        value:start_dissolve()
                    end
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local added_card = SMODS.add_card({ set = 'Spectral' })
                    added_card:set_edition({polychrome = true}, true)
                    added_card:add_sticker('perishable', true)
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true --G.consumeables and G.consumeables.config.card_limit
    end
}