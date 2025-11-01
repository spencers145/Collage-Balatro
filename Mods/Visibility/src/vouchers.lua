SMODS.Voucher {
    key = 'warhead',
    atlas = "TextureAtlasVouchers",
    pos = { x = 0, y = 0 },
    config = { extra = { increment = 1, size = 2} },
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.increment, card.ability.extra.size } }
    end,
    redeem = function(self, card)
        -- Apply ante change
        ease_ante(card.ability.extra.increment)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + card.ability.extra.increment
        G.hand:change_size(card.ability.extra.size)
    end,
}

SMODS.Voucher {
    key = 'fallout',
    pos = { x = 1, y = 0 },
    config = { extra = { joker_slots = 1, size = -1 } },
    unlocked = false,
    discovered = false,
    requires = { 'v_vis_warhead' },
    atlas = "TextureAtlasVouchers",
    check_for_unlock = function(self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 3
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.joker_slots, -card.ability.extra.size } }
    end,
    redeem = function(self, card)
        G.hand:change_size(card.ability.extra.size)
        G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
            end
        return true end }))
    end
}

--[[
SMODS.Voucher {
    key = 'divine_merchant',
    atlas = "TextureAtlasVouchers",
    pos = { x = 2, y = 0 },
    discovered = true,
    unlocked = true,
    config = { extra = { display = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, colours = { G.C.SET.Divine } } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.divine_rate = 1.25
                G.GAME.blackmarket_rate = (G.GAME.blackmarket_rate or 0.05) * 4
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'divine_tycoon',
    atlas = "TextureAtlasVouchers",
    pos = { x = 3, y = 0 },
    config = { extra = { display = 3 } },
    discovered = true,
    unlocked = true,
    requires = { 'v_vis_divine_merchant' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.display, colours = { G.C.SET.Divine } } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.divine_rate = (G.GAME.divine_rate or 1.25) * math.floor(card.ability.extra.display)
                G.GAME.blackmarket_rate = (G.GAME.blackmarket_rate or 0.2) * math.floor(card.ability.extra.display)
                return true
            end
        }))
    end
}]]

--[[SMODS.Voucher {
    key = 'deadbeat',
    atlas = "TextureAtlasVouchers",
    pos = { x = 3, y = 5 },
    config = { },
    discovered = true,
    unlocked = true,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.bankrupt_at = G.GAME.bankrupt_at - 20
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'proficient_scammer',
    atlas = "TextureAtlasVouchers",
    pos = { x = 3, y = 5 },
    config = { },
    discovered = true,
    unlocked = true,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.bankrupt_at = -2000000000
                return true
            end
        }))
    end
}

local ed = ease_dollars
function ease_dollars(mod, instant)
    ed(mod, instant)
    if G.GAME.used_vouchers["v_vis_proficient_scammer"] then
        -- Blind size is increased by 5% for every 10 dollars in debt
        local debt = G.GAME.dollars < 0 and G.GAME.dollars or 0
        if debt == 0 then return end
        if G.GAME.blind then
        end
    end
end]]