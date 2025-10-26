-- Talisman
SMODS.Consumable {
  key = 'witness',
  set = 'Spectral',
  atlas = 'Spectrals',
  pos = { x = 0, y = 0 },
  unlocked = true, 
  discovered = true,
  
  config = {
    max_highlighted = 1 
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'rainydays_ivory_seal', set = 'Other' }
    return { vars = { card.ability.max_highlighted } }
  end,
  
  use = function(self, card, area, copier)
    local conv_card = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        conv_card:set_seal('RainyDays_ivory', nil, true)
        return true
      end
    }))

    delay(0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all()
        return true
      end
    }))
  end,
  
  draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end
}