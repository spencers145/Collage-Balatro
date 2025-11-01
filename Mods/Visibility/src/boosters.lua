SMODS.Sound({
	key = "music_divine",
	path = "music_divine.ogg",
	select_music_track = function()
        if not G.pack_cards or not G.pack_cards.cards then return false end
        if #G.pack_cards.cards == 0 then return false end
        local divine = true
        for _, v in ipairs(G.pack_cards.cards) do
            if v.ability.set ~= "Divine" then
                divine = false
            end
        end
        return divine
	end,
})

SMODS.Booster{
    key = 'black_market_normal_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 0, y = 3 },
    discovered = false,

    draw_hand = false,
    config = {
        extra = 5,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") }} }
    end,
    weight = 0.20,
    cost = 6,
    kind = "VisibilityPack",

    get_weight = function(self)
        return collage_ease_weight(80, 100, 0.2, 10, 5)
    end,

    create_card = function(self, card, i)
        local _types = get_all_unbanned_consumable_sets()
        if #_types == 0 then
            -- What are we supposed to do if there are no unbanned sets?
            -- Let's just let Jimbo shine
            return SMODS.create_card({
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                key = "j_joker"
            })
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = (G.pack_cards and G.pack_cards.cards and G.pack_cards.highlighted[1].set == "Joker") and "joker" or 'consumeables',

    in_pool = function()
        return #get_all_unbanned_consumable_sets() ~= 0
    end
}

SMODS.Booster{
    key = 'black_market_jumbo_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 1, y = 3 },
    discovered = false,

    draw_hand = false,
    config = {
        extra = 7,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") } } }
    end,
    weight = 0.10,
    cost = 8,
    kind = "VisibilityPack",

    get_weight = function(self)
        return collage_ease_weight(80, 100, 0.1, 10, 5)
    end,

    create_card = function(self, card, i)
        local _types = get_all_unbanned_consumable_sets()
        if #_types == 0 then
            -- What are we supposed to do if there are no unbanned sets?
            -- Let's just let Jimbo shine
            return SMODS.create_card({
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                key = "j_joker"
            })
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'consumeables',

    in_pool = function() 
        return #get_all_unbanned_consumable_sets() ~= 0
    end
}

SMODS.Booster{
    key = 'black_market_mega_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_visibility_pack",
    pos = { x = 2, y = 3 },
    discovered = false,

    draw_hand = false,
    config = {
        extra = 7,
        choose = 2,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("bdc3c7") } } }
    end,
    weight = 0.05,
    cost = 10,
    kind = "VisibilityPack",

    get_weight = function(self)
        return collage_ease_weight(80, 100, 0.05, 10, 5)
    end,

    create_card = function(self, card, i)
        local _types = get_all_unbanned_consumable_sets()
        if #_types == 0 then
            -- What are we supposed to do if there are no unbanned sets?
            -- Let's just let Jimbo shine
            return SMODS.create_card({
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                key = "j_joker"
            })
        end
        local type = pseudorandom_element(_types, pseudoseed('bmp'))
        return SMODS.create_card({
            set = type,
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,
    select_card = 'consumeables',

    in_pool = function() 
        return #get_all_unbanned_consumable_sets() ~= 0
    end
}

SMODS.Booster{
    key = 'divine_normal_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 3, y = 3 },
    discovered = false,

    draw_hand = true,
    config = {
        extra = 2,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.2,
    get_weight = function(self)
        return collage_ease_weight(48, 80, 0.2, 4, 2)
    end,
    cost = 6,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() 
        return not is_set_banned("Divine")
    end
}

SMODS.Booster{
    key = 'divine_normal_2',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 4, y = 3 },
    discovered = false,

    draw_hand = true,
    config = {
        extra = 2,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.2,
    get_weight = function(self)
        return collage_ease_weight(60, 80, 0.2, 4, 2)
    end,
    cost = 6,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() 
        return not is_set_banned("Divine")
    end
}

SMODS.Booster{
    key = 'divine_jumbo_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 5, y = 3 },
    discovered = false,

    draw_hand = true,
    config = {
        extra = 4,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.2,
    get_weight = function(self)
        return collage_ease_weight(60, 80, 0.2, 4, 2)
    end,
    cost = 8,
    kind = "Divine",

    create_card = function(self, card, i)
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() 
        return not is_set_banned("Divine")
    end
}

SMODS.Booster{
    key = 'divine_mega_1',
    atlas = 'TextureAtlasConsumables',
    group_key = "k_divine_pack",
    pos = { x = 6, y = 3 },
    discovered = false,

    draw_hand = true,
    config = {
        extra = 4,
        choose = 2,
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = { HEX("B4CEFF") } } }
    end,
    weight = 0.05,
    get_weight = function(self)
        return collage_ease_weight(60, 80, 0.05, 4, 2)
    end,
    cost = 10,
    kind = "Divine",

    create_card = function(self, card, i)
        ease_background_colour(HEX("B4CEFF"))
        return SMODS.create_card({
            set = "Divine",
            area = G.pack_cards,
            skip_materialize = true,
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Divine)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Divine, special_colour = G.C.CHIPS, contrast = 2 })
    end,
    --select_card = 'consumeables',

    in_pool = function() 
        return not is_set_banned("Divine")
    end
}