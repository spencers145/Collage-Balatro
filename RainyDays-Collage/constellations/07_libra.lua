SMODS.Consumable {
  key = 'libra',
  name = 'Libra',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('libra'),
  unlocked = true,
  discovered = true,
  config = {
    chip_bonus = 25,
    mult_bonus = 3
  },
  
  loc_vars = function(self, info_queue, card)
    return { 
      vars = {
        card.ability.chip_bonus,
        card.ability.mult_bonus
      } 
    }
  end,
  
  use = function(self, card, area, copier)
    --find random hand
    local hands = {}
    for key, value in ipairs(G.handlist) do
      if SMODS.is_poker_hand_visible(value) then
        hands[#hands + 1] = value
      end
    end
    
    local random_hand = pseudorandom_element(hands, pseudoseed('libra' .. G.GAME.round_resets.ante))
    level_up_table_tailends(card, { random_hand }, nil, false, 0, card.ability.chip_bonus, card.ability.mult_bonus)
  end,

  can_use = function(self, card)
    return true
  end
}