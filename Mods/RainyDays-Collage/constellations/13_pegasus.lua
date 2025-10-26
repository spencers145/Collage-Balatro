SMODS.Consumable {
  key = 'pegasus',
  name = 'Pegasus',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('pegasus'),
  unlocked = true, 
  discovered = true,
  config = {
    money_bonus = 12,
    level_subtract = 1
  },
  
  loc_vars = function(self, info_queue, card)
    local highest_level_poker_hand = highest_level_poker_hand()
    local highest_level_poker_hand_text = localize('k_none')
    local colour = G.C.RED
    if highest_level_poker_hand and to_big(G.GAME.hands[highest_level_poker_hand].level) > to_big(1) then
      highest_level_poker_hand_text = localize(highest_level_poker_hand, 'poker_hands')
      colour = G.C.GREEN
    end
  
    return {  
      vars = { 
        card.ability.money_bonus, 
        card.ability.level_subtract 
      },
      main_end = generate_main_end(highest_level_poker_hand_text, colour) 
    }
  end,
  
  use = function(self, card, area, copier)
    --give money
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        card:juice_up(0.3, 0.5)
        ease_dollars(card.ability.money_bonus, true)
        return true
      end
    }))

    delay(0.6)
    
    level_up_table_tailends(card, { highest_level_poker_hand() }, nil, false, -1)
  end,
  
  can_use = function(self, card)
    local highest_level_poker_hand = highest_level_poker_hand()
    return to_big(G.GAME.hands[highest_level_poker_hand].level) > to_big(1)
  end
}