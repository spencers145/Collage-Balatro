SMODS.Consumable {
  key = 'orion',
  name = 'Orion',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('orion'),
  unlocked = true,
  discovered = true,
  
  in_pool = function(self, args) --does not reappear after use
    return not G.GAME.orion_used
  end,
  
  config = {
    poker_hand = 'Three of a Kind',
    chip_bonus = 2,
    per_tarot = 1
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.poker_hand, 'poker_hands'),
        card.ability.chip_bonus,
        math.floor(card.ability.chip_bonus * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) / card.ability.per_tarot)
      }
    }
  end,
  
  use = function(self, card, area, copier)
    local chip_total = math.floor(card.ability.chip_bonus * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot or 0) / card.ability.per_tarot)
    level_up_table_tailends(card, { card.ability.poker_hand }, nil, false, 0, chip_total)
    G.GAME.orion_used = true
  end,

  can_use = function(self, card)
    return true
  end
}