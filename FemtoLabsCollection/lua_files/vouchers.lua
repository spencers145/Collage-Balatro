local duskshopper = SMODS.Voucher({
    key = "duskshopper",
    loc_txt = {
        name = "Homecoming",
        text = {
            "{C:femtolabscollection_twilight}Twilight{} cards may",
            "appear in the {C:attention}Shop"
        }
    },
    atlas = 'v_flc_vouchers', 
    pos = { x = 0, y = 0 },
    discovered = true
})

duskshopper.redeem = function(self, card)
    G.GAME['m_femtolabscollection_twilight_rate'] = 2
end

local duskbooster = SMODS.Voucher({
    key = "duskbooster",
    loc_txt = {
        name = "Derealization",
        text = {
            "All {C:femtolabscollection_twilight}Twilight{} cards may",
            "be {C:dark_edition}Negative"
        }
    },
    atlas = 'v_flc_vouchers', 
    requires = {'v_femtoLabsCollection_duskshopper'},
    pos = { x = 1, y = 0 },
    discovered = true
})

duskbooster.redeem = function(self, card)
    G.GAME['m_femtolabscollection_twilight_negatives'] = true
end