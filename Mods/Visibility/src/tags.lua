--[[SMODS.Tag {
    key = "foresight",
    atlas = "TextureAtlasTags",
    pos = { x = 0, y = 0 },
    credits = {
        idea = "GunnableScum",
    },
    discovered = false,
    config = { extra = { shop_started = false } },
    apply = function(self, tag, context)
        if context.type == 'shop_start' then
            tag.shop_started = true
        elseif context.type == 'store_joker_create' and tag.shop_started then
            local card = create_card('Spectral', context.area, nil, 1, nil, nil, nil, 'sta')
            create_shop_card_ui(card, 'Spectral', context.area)
            return card
        elseif context.type == 'shop_final_pass' and tag.shop_started then
            tag.shop_started = false
            tag:yep('+', G.C.DARK_EDITION)
            return true
        end
    end,
    in_pool = function (self, args)
        return false -- Cannot appear in skip pool
    end
}]]

SMODS.Tag {
    key = "divine",
    atlas = "TextureAtlasTags",
    pos = { x = 2, y = 0 },
    discovered = false,
    loc_vars = function (self, info_queue, tag)
        return { vars = { colours = { G.C.SET.Divine } } }
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            tag:yep('+', G.C.CHIPS, function() 
                local key = 'p_vis_divine_mega_1'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

SMODS.Tag {
    key = "black_market",
    atlas = "TextureAtlasTags",
    pos = { x = 1, y = 0 },
    discovered = false,
    in_pool = function (self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 5
    end,
    loc_vars = function (self, info_queue, tag)
        return { }
    end,
    apply = function(self, tag, context)
        if context.type == "new_blind_choice" then
            tag:yep('+', G.C.CHIPS, function() 
                local key = 'p_vis_black_market_jumbo_1'
                local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                card.cost = 0
                card.from_tag = true
                G.FUNCS.use_card({config = {ref_table = card}})
                card:start_materialize()
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}