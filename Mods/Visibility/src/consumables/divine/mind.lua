SMODS.Consumable {
    key = 'mind',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 1 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset"
    },
    loc_vars = function(self, info_queue, card)
        -- This vanilla variable only checks for vanilla Tarots and Planets, you would have to keep track on your own for any custom consumables
        local mind_c = G.GAME.last_divine and G.P_CENTERS[G.GAME.last_divine] or nil
        local last_divine = mind_c and localize { type = 'name_text', key = mind_c.key, set = mind_c.set } or
            localize('k_none')
        local colour = (not mind_c or mind_c.name == 'c_vis_mind') and G.C.RED or G.C.GREEN

        if not (not mind_c or mind_c.name == 'c_vis_mind') then
            info_queue[#info_queue + 1] = mind_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_divine .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_divine, colours = { G.C.SET.Divine } }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.last_divine })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.GAME.last_divine and G.GAME.last_divine ~= 'c_vis_mind'
    end
}