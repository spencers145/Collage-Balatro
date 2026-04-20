if PB_UTIL.config.suits_enabled then
  SMODS.Back {
    key = 'proud',
    atlas = 'decks_atlas',
    pos = { x = 1, y = 0 },
    paperback = {
      create_crowns = true,
      create_stars = true
    },
    unlocked = false,
    check_for_unlock = function(self, args)
      return PB_UTIL.spectrum_played()
    end,
  }
end
