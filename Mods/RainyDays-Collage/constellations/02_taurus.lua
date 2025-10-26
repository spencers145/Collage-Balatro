SMODS.Consumable {
  key = 'taurus',
  name = 'Taurus',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('taurus'),
  unlocked = true, 
  discovered = true,
  config = {
    mult_bonus = 2
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.mult_bonus
      }
    }
  end,
  
  use = function(self, card, area, copier)local table = {}
    for key, value in ipairs(G.handlist) do
      table[#table + 1] = value
    end
    level_up_table_tailends(card, table, localize('k_all_hands'), false, 0, nil, card.ability.mult_bonus)
  end,
  
  can_use = function(self, card)
    return true
  end
}