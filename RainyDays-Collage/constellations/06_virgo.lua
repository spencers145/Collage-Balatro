SMODS.Consumable {
  key = 'virgo',
  name = 'Virgo',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('virgo'),
  unlocked = true,
  discovered = true,
  config = {
    level_amount = 3
  },
  
  loc_vars = function(self, info_queue, card)
    local hand_lowest_level = lowest_level_poker_hand() 
    local hand_lowest_level_text = hand_lowest_level and localize(hand_lowest_level, 'poker_hands') or localize('k_none')
    local colour = hand_lowest_level and G.C.GREEN or G.C.RED
  
    return {
      vars = { card.ability.level_amount },
      main_end = generate_main_end(hand_lowest_level_text, colour)
    }
  end,
  
  use = function(self, card, area, copier)    
    level_up_table_tailends(card, { lowest_level_poker_hand() }, nil, false, card.ability.level_amount)
  end,

  can_use = function(self, card)
    return lowest_level_poker_hand()
  end
}