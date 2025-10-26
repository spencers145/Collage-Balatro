SMODS.Consumable {
  key = 'leo',
  name = 'Leo',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('leo'),
  unlocked = true,
  discovered = true,
  
  loc_vars = function(self, info_queue, card)
    local last_hand_text = G.GAME.last_hand_played and localize(G.GAME.last_hand_played, 'poker_hands') or localize('k_none')
    local colour = G.GAME.last_hand_played and G.C.GREEN or G.C.RED
    
    return {
      main_end = generate_main_end(last_hand_text, colour)
    }
  end,

  use = function(self, card, area, copier)    
    level_up_table_tailends(card, { G.GAME.last_hand_played }, nil, false, 1)
    
    local destructable_jokers = {}
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
        destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
      end
    end
    
    local joker_to_destroy = pseudorandom_element(destructable_jokers, 'cetus')
    if joker_to_destroy then
      joker_to_destroy.getting_sliced = true
      G.E_MANAGER:add_event(Event({
        func = function()
          card:juice_up(0.3, 0.5)
          joker_to_destroy:start_dissolve(nil, _first_dissolve)
          return true
        end
      }))
    end
  end,

  can_use = function(self, card)
    return G.GAME.last_hand_played
  end
}