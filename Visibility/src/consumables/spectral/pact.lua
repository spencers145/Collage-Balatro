SMODS.Consumable {
    key = "pact",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 5, y = 2 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
    loc_vars = function(self, info_queue, card)
        -- This vanilla variable only checks for vanilla Tarots and Planets, you would have to keep track on your own for any custom consumables
        local pact_c = G.GAME.last_spectral and G.P_CENTERS[G.GAME.last_spectral] or nil
        local last_spectral = pact_c and localize { type = 'name_text', key = pact_c.key, set = pact_c.set } or
            localize('k_none')
        local colour = (not pact_c or pact_c.name == 'The Soul' or pact_c.name == 'c_vis_pact') and G.C.RED or G.C.GREEN

        if pact_c and not (pact_c.name == 'The Soul' or pact_c.name == 'c_vis_pact') then
            info_queue[#info_queue + 1] = pact_c
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
                            { n = G.UIT.T, config = { text = ' ' .. last_spectral .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_spectral }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.last_spectral })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return G.GAME.last_spectral and G.GAME.last_spectral ~= 'c_vis_pact'
    end
}