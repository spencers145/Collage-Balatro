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
        info_queue[#info_queue+1] = G.P_TAGS.tag_aij_overstuffed
        return { vars = { card.ability.extra.consumables } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
			func = function ()
                add_tag(Tag('tag_aij_overstuffed'))
                add_tag(Tag('tag_aij_overstuffed'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
			end
		}))
    end,
    can_use = function(self, card)
        return true --G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit
    end
}