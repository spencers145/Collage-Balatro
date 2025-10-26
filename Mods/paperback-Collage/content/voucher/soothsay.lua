SMODS.Voucher {
  key = 'soothsay',
  atlas = 'vouchers_atlas',
  pos = { x = 0, y = 1 },
  discovered = false,
  requires = {
    'v_paperback_celtic_cross'
  },
  paperback = {
    requires_minor_arcana = true,
  },

  redeem = function(self, card)
    -- 3 is the default rate for Tarots with no vouchers
    G.GAME.paperback_minor_arcana_rate = 3
  end,
}
