SMODS.Voucher {
    key = 'mispack',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Mispack',
        text = {
        'Increase the cards',
        'included inside',
        '{C:attention}Booster Packs{} by {C:attention}+1{}'
    }
    },
    atlas = 'CustomVouchers',
     redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + 1
                return true
            end
        }))
    end
}