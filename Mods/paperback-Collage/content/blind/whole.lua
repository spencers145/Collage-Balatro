SMODS.Blind {
  key = 'whole',
  boss = {
    min = 3
  },
  discovered = false,
  mult = 1,
  boss_colour = HEX('B7C977'),
  atlas = 'music_blinds_atlas',
  pos = { y = 7 },

  recalc_debuff = function(self, card, from_blind)
    if card.area ~= G.jokers then
      if not SMODS.has_no_rank(card) then
        if G.GAME.paperback.ranks_scored_this_ante[card:get_id()] then
          return true
        end
      end
    end
    return false
  end
}
