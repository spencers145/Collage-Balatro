local voucherInfo = {
    key = "staple_gun",
    pos = LOSTEDMOD.funcs.coordinate(11), 
    atlas = 'losted_vouchers',
    config = {},
    unlocked = false,
    discovered = false,
    requires = { 'v_losted_stapler' },
    redeem = function(self, card)
        G.GAME.losted_staple_gun_active = true
        unlock_card(G.P_CENTERS.b_vis_poptart)
    end,
    load = function(self, card, card_table, other_card)
        G.GAME.losted_staple_gun_active = true
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 50, G.PROFILES[G.SETTINGS.profile].career_stats.c_jokers_bought } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'buy_joker' and args.jokers_total >= 50 then
            unlock_card(self)
        end
    end
}

return voucherInfo