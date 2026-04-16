--see all lua injects

local game_update_shop_ref = Game.update_shop
function Game:update_shop(dt)
  if not G.STATE_COMPLETE then
    G.GAME.rd_money_spent_shop = nil
  end
  return game_update_shop_ref(self, dt)
end

local toggle_shop_ref = G.FUNCS.toggle_shop
function G.FUNCS.toggle_shop(e)
  local ret = toggle_shop_ref(e)
  if not G.GAME.rd_money_spent_shop or G.GAME.rd_money_spent_shop <= 0 then
    G.GAME.rd_no_spend_shop = (G.GAME.rd_no_spend_shop or 0) + 1
  end
  G.GAME.rd_money_spent_shop = nil
  return ret
end

local inc_career_stat_ref = inc_career_stat
function inc_career_stat(stat, mod)
  if stat == 'c_shop_dollars_spent' and G.shop and mod > 0 then
    G.GAME.rd_money_spent_shop = (G.GAME.rd_money_spent_shop or 0) + mod
  end
  return inc_career_stat_ref(stat, mod)
end