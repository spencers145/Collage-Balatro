SMODS.Consumable {
    key = "vault",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 0, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = (function()
                if G.jokers.highlighted[1].ability.perishable then
                    unlock_card(G.P_CENTERS.b_znm_firewalk)
                end
                G.jokers.highlighted[1]:remove_sticker("perishable")
                G.jokers.highlighted[1]:set_eternal(true)
                G.jokers.highlighted[1]:juice_up(0.3, 0.5)
                play_sound('tarot2')
                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return #G.jokers.highlighted == 1 and
            (not G.jokers.highlighted[1].ability.perishable or G.jokers.highlighted[1].ability.perish_tally > 0)
            and G.jokers.highlighted[1].config.center.eternal_compat
            and not G.jokers.highlighted[1].ability.eternal
    end,
    loc_vars = function (self, info_queue, card)
        if not G.P_CENTERS.b_znm_firewalk.unlocked and G.GAME.modifiers.enable_perishables_in_shop then
            return {
                key = "c_vault_unlock_helper"
            }
        end
    end
}