SMODS.Consumable {
    key = 'mandela',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { colours = { HEX("514CDB") } } }
    end,
    pos = { x = 3, y = 1 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
        remix = "Monachrome"
    },
    config = { max_highlighted = 3, extra = { seal = 'vis_indigo' } },
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        for index, value in ipairs(G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    value:set_seal(card.ability.extra.seal, nil, true)
                    return true
                end
            }))
        end
        

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}
