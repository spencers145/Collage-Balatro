SMODS.Consumable {
  key = 'capricorn',
  name = 'Capricorn',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('capricorn'),
  unlocked = true, 
  discovered = true,
  config = {
    money_bonus = 1,
    maximum = 15
  },
  
  loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        card.ability.money_bonus,
        card.ability.maximum,
        math.min(G.GAME and G.GAME.hands[highest_level_poker_hand()].level * card.ability.money_bonus or card.ability.money_bonus, card.ability.maximum)
      } 
    }
  end,
  
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(math.min(card.ability.money_bonus * G.GAME.hands[highest_level_poker_hand()].level, card.ability.maximum), true)
        return true
      end
    }))

    delay(0.6)
  end,
  
  can_use = function(self, card)
      return true
  end
}