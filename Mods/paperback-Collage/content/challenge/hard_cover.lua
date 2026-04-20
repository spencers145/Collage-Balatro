SMODS.Challenge {
  key = 'hard_cover',
  rules = {
    custom = {
      { id = "paperback_banned_vanilla_jokers" }
    }
  },

  apply = function(self)
    -- Without the event this happens before `banned_run_keys` is set to an empty table
    G.E_MANAGER:add_event(Event {
      func = function()
        for k, v in pairs(G.P_CENTERS) do
          if v.set == "Joker" and not v.original_mod then
            G.GAME.paperback.banned_run_keys[k] = true
          end
        end
        return true
      end
    })
  end
}
