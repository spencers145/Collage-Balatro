SMODS.Consumable {
    key = 'future',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 3, mod_conv = 'm_vis_plastic' },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end,
}