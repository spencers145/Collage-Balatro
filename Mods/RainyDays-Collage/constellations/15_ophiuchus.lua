SMODS.Consumable {
  key = 'ophiuchus',
  name = 'Ophiuchus',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('ophiuchus'),
  unlocked = true,
  discovered = true,
  
  in_pool = function(self, args) --only appears if player has revealed at least one secret hand.
    for key, value in ipairs(G.handlist) do
      if G.GAME.hands[value].visible and is_secret_pokerhand(value) then
        return true
      end
    end
    return false
  end,
  
  config = {
    chip_bonus = 30,
    mult_bonus = 4
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
    local table = {}
    for key, value in ipairs(G.handlist) do
      if not G.GAME.hands[value].visible or is_secret_pokerhand(value) then
        table[#table + 1] = value
      end
    end
    level_up_table_tailends(card, table, localize('rainydays_hands_secret'), false, 0, card.ability.chip_bonus, card.ability.mult_bonus)
  end,

  can_use = function(self, card)
    return true
  end
}