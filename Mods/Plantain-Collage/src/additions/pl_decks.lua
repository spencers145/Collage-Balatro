if PL_UTIL.config.vouchers_enabled then
  SMODS.Back {
    key = 'sponsored',
    atlas = 'pl_atlas_decks',
    pos = { x = 0, y = 0 },
    unlocked = false,
    config = {
        vouchers = {
          'v_pl_ad_break'
        },
        consumables = {
          'c_vis_coupon'
        }
      },

    apply = function(self, back)
      SMODS.change_voucher_limit(-1)
    end
  }
end