SMODS.Consumable {
    key = "gum",
    set = "BlackMarket",
	cost = 5,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 6, y = 0 },
    display_size = { w = 39, h = 95 },
    pixel_size = { w = 39, h = 95 },
    config = { extra = { seal = 'vis_mitosis' }, max_highlighted = 1 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { colours = { HEX("DC6094") } } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
    can_use = function (self, card)
        return #G.hand.highlighted == 1
    end
}