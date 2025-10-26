SMODS.Consumable {
  key = 'cetus',
  name = 'Cetus',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('cetus'),
  unlocked = true,
  discovered = true,
  
  in_pool = function(self, args) --does not reappear after use
    return not G.GAME.cetus_used
  end,
  
  config = {
    poker_hand = 'Full House',
    mult_bonus = 2,
    per_dollars = 3,
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.poker_hand, 'poker_hands'),
        card.ability.mult_bonus,
        card.ability.per_dollars,
        card.ability.mult_bonus * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.per_dollars)
      }
    }
  end,
  
  use = function(self, card, area, copier)
    local mult_total = math.max(0, card.ability.mult_bonus * math.floor(((G.GAME.dollars or 0) + (G.GAME.dollar_buffer or 0)) / card.ability.per_dollars))
    level_up_table_tailends(card, { card.ability.poker_hand }, nil, false, 0, nil, mult_total)
    G.GAME.cetus_used = true
  end,

  can_use = function(self, card)
    return true
  end
}