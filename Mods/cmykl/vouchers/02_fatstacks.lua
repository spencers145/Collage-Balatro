SMODS.Voucher {
    key = 'fatstacks',
    pos = { x = 1, y = 0 },
    requires = { 'v_cmykl_mispack' },
    loc_txt = {
        name = 'Fat Stacks',
        text = {
        'Gain an additional',
        '{C:attention}+1{} card to pick on',
        'all {C:attention}Booster Packs{}'
    }
    },
    atlas = 'CustomVouchers',
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()          
                G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + 1
                return true
            end
        }))
    end
}