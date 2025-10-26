SMODS.Consumable {
  key = 'chamaeleon',
  name = 'Chamaeleon',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('chamaeleon'),
  unlocked = true, 
  discovered = true,
  
  loc_vars = function(self, info_queue, card)
    if G.GAME.last_constellation and G.GAME.last_constellation ~= 'c_RainyDays_chamaeleon' then
      info_queue[#info_queue + 1] = G.P_CENTERS[G.GAME.last_constellation]
    end

    local last_constellation = G.GAME.last_constellation and localize{ type = 'name_text', key = G.GAME.last_constellation, set = 'Constellation' } or localize('k_none')
    local colour = (G.GAME.last_constellation and G.GAME.last_constellation ~= 'c_RainyDays_chamaeleon') and G.C.GREEN or G.C.RED
    
    return { main_end = generate_main_end(last_constellation, colour) }
  end,
  
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        if G.consumeables.config.card_limit > #G.consumeables.cards then
          play_sound('timpani')
          SMODS.add_card({ key = G.GAME.last_constellation })
          G.GAME.last_constellation = 'c_RainyDays_chamaeleon'
          card:juice_up(0.3, 0.5)
        end
        return true
      end
    }))

    delay(0.6)
  end,
    
  can_use = function(self, card)
    if not G.GAME.last_constellation or  G.GAME.last_constellation == 'c_RainyDays_chamaeleon' then 
      return false
    end
    
    for i = 1, #G.consumeables.cards do
      if G.consumeables.cards[i] == card then
        return true
      end
    end
    return G.consumeables.config.card_limit > #G.consumeables.cards
  end
}

local old_set_consumeable_usage = set_consumeable_usage
function set_consumeable_usage(card)
  local ret = old_set_consumeable_usage(card)
  if card.config.center.set == 'Constellation' and card.config.center_key ~= 'c_RainyDays_chamaeleon'then
    G.GAME.last_constellation = card.config.center_key
  end
  return ret
end