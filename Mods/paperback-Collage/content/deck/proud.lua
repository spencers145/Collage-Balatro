SMODS.Back {
  key = 'proud',
  atlas = 'decks_atlas',
  pos = { x = 1, y = 0 },
  --[[paperback = {
    create_crowns = true,
    create_stars = true
  },]]
  unlocked = false,
  check_for_unlock = function(self, args)
    return PB_UTIL.spectrum_played()
  end,
  apply = function ()
    G.E_MANAGER:add_event(Event({
      func = function ()
        for i = 1, 1 do
          SMODS.add_card({key = 'c_lovers'})
        end

        SMODS.add_card({key = 'j_paperback_pride_flag'})
        return true
      end
    }))
  end
}