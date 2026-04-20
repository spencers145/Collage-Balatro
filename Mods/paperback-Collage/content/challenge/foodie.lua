SMODS.Challenge {
  key = 'foodie',
  rules = {
    custom = {
      { id = "paperback_only_food_jokers" }
    }
  },

  apply = function(self)
    G.E_MANAGER:add_event(Event {
      func = function()
        for k, v in pairs(G.P_CENTERS) do
          if v.set == "Joker" and ((v.pools and not v.pools.Food) or (not v.pools)) then
            G.GAME.paperback.banned_run_keys[k] = true
          end
        end
        return true
      end
    })
  end
}
