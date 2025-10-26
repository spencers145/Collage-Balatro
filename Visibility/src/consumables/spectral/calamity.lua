SMODS.Consumable {
    key = "calamity",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 8, y = 2 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
    config = { extra = { max = 1 } },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_bunc_glitter
        info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
        return { vars = { card.ability.extra.max } }
    end,
    use = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = (function()
                local target_joker = G.jokers.highlighted[1]
                target_joker.pinned = true
                local edition = poll_edition('calamity', nil, true, true,
                    { 'e_polychrome', 'e_holo', 'e_bunc_glitter' })
                target_joker:set_edition(edition, true)
                target_joker:juice_up(0.3, 0.5)
                play_sound('tarot2')
                check_for_unlock({ type = 'have_edition' })

                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == card.ability.extra.max and not G.jokers.highlighted[1].edition
    end,
}