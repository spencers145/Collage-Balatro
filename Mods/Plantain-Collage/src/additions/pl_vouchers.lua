SMODS.Voucher {
  key = 'ad_break',
  atlas = 'pl_atlas_vouchers',
  config = {
    extra = {reroll = 1}
  },
  pos = { x = 0, y = 0 },
  discovered = false,
  --unlocked = false,
  --check_for_unlock = function (self, args)
  --  return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 5
  --end,

  loc_vars = function (self, info_queue, card)
    return {vars = {card.ability.extra.reroll}}
  end,

  redeem = function (self, voucher)
    G.E_MANAGER:add_event(Event({func = function()
      G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - self.config.extra.reroll
      G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - self.config.extra.reroll)
    return true end }))
  end,

  calculate = function(self, card, context)
    if G.GAME.used_vouchers.v_reroll_surplus and G.GAME.used_vouchers.v_reroll_glut and G.GAME.used_vouchers.v_pl_ad_break then
      unlock_card(G.P_CENTERS.b_pl_sponsored)
    end

    if context.reroll_shop then
      PL_UTIL.reroll_booster_packs(1)
    end
  end,
}

SMODS.Voucher {
  key = 'product_placement',
  atlas = 'pl_atlas_vouchers',
  pos = { x = 1, y = 0 },
  discovered = false,
  requires = {
    'v_pl_ad_break'
  },

  calculate = function(self, card, context)
    if context.reroll_shop then
      PL_UTIL.reroll_booster_packs()
    end
  end,
}