SMODS.Consumable {
  key = 'vulpecula',
  name = 'Vulpecula',
  set = 'Constellation',
  atlas = "Constellations",
  pos = GetConstellationAtlasTable('vulpecula'),
  unlocked = true, 
  discovered = true,
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = 'tag_RainyDays_nebula', set = 'Tag' }
  end,
  
  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      func = (function()
        add_tag(Tag('tag_RainyDays_nebula'))
        play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
        return true
      end)
    }))
  end,

  can_use = function(self, card)
    return true
  end
}