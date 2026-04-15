-- Adds logo omg
SMODS.Atlas({
    key = "balatro", 
    path = "balatrocmykl.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})



-- Adds comykel's Joker
local XmainMenuHook = Game.main_menu
function Game:main_menu(ctx)
    local r = XmainMenuHook(self,ctx)
    if self.title_top then
        local tg = self.title_top
        local card = Card(tg.T.x,tg.T.y,G.CARD_W,G.CARD_H,nil,G.P_CENTERS['j_cmykl_comykel'])
        card.bypass_discovery_center = true
        card.T.w = card.T.w * 1.35
        card.T.h = card.T.h * 1.35
        
        G.title_top.T.w = G.title_top.T.w + 1.35
        G.title_top.T.x = G.title_top.T.x - 0.7
        card:set_sprites(card.config.center)
        card.no_ui = true
        card.states.visible = false
        self.title_top:emplace(card)
        self.title_top:align_cards()
        G.E_MANAGER:add_event(
            Event{
                delay = 0.5,
                func = function ()
                    if ctx == "splash" then
                        card.states.visible = true
                        card:start_materialize({ G.C.WHITE, G.C.WHITE }, true, 1)
                    else
                        card.states.visible = true
                        card:start_materialize({ G.C.WHITE, G.C.WHITE }, nil, 1)
                    end
                    return true
                end
            }
        )
    end

    return r
end

