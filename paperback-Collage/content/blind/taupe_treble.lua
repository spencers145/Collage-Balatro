SMODS.Blind {
  key = 'taupe_treble',
  boss = {
    showdown = true, min = 1
  },
  discovered = false,
  in_pool = function(self)
    if G.playing_cards then
      local count = 0
      for _, v in ipairs(G.playing_cards) do
        if next(SMODS.get_enhancements(v)) then
          count = count + 1
        end
      end
      return count >= 10
    end
  end,
  mult = 2,
  boss_colour = HEX("AB9C84"),
  atlas = 'music_blinds_atlas',
  pos = { y = 13 },

  debuff_hand = function(self, cards, hand, handname, check)
    if cards then
      for _, v in ipairs(cards) do
        if next(SMODS.get_enhancements(v)) then
          return false
        end
      end
      return true
    end
  end
}
