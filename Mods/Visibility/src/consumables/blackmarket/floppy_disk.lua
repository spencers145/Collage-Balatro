SMODS.Consumable {
    key = "floppy_disk",
    set = "BlackMarket",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 9, y = 0 },
    display_size = { w = 53, h = 61 },
    pixel_size = { w = 53, h = 61 },
    config = { extra = { consumables = 5 } },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.consumables } }
    end,
    use = function(self, card, area, copier)
        for i = 1, math.min(card.ability.extra.consumables, G.consumeables.config.card_limit - #G.consumeables.cards) do
            local _types = {}
            for k, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
                _types[#_types + 1] = v
            end
            local type = pseudorandom_element(_types, pseudoseed('floppy'))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        SMODS.add_card({ set = type })
                        card:juice_up(0.3, 0.5)
                    end
                    return true
                end
            }))
        end
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}