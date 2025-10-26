SMODS.Consumable {
  key = 'aquarius',
  name = 'Aquarius',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('aquarius'),
  unlocked = true, 
  discovered = true,
  config = {
    border_hand = 'Three of a Kind',
    chip_bonus = 25
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.border_hand, 'poker_hands'),
        card.ability.chip_bonus
      }
    }
  end,
  
  use = function(self, card, area, copier)
    local table = {}
    for key, value in ipairs(G.handlist) do
      table[#table + 1] = value
      if value == card.ability.border_hand then
        break
      end
    end
    level_up_table_tailends(card, table, localize(card.ability.border_hand, 'poker_hands') .. '+', false, 0, card.ability.chip_bonus)
  end,
  
  can_use = function(self, card)
    return true
  end
}