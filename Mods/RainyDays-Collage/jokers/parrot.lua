SMODS.Joker {
  key = 'parrot',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('parrot'),
  
  config = {
    extra = {
      jokers_copied_this_ante = {},
      jokers_copied_this_round = {}
    }
  },
  
  loc_vars = function(self, info_queue, card)
    if card.area and card.area == G.jokers then
      local other_joker
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then 
          other_joker = G.jokers.cards[i + 1]
        end
      end
      local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
      local string = 'k_' .. (compatible and 'compatible' or 'incompatible')
      if compatible and card.ability.extra.jokers_copied_this_ante[other_joker.ID] then
        string = 'rainydays_copied_before'
        compatible = false
      end
      local main_end = {{
        n = G.UIT.C,
        config = { align = 'bm', minh = 0.4 },
        nodes = {{
          n = G.UIT.C,
          config = { 
            ref_table = card, 
            align = 'm', 
            colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), 
            r = 0.05, 
            padding = 0.06 
          },
          nodes = {{ 
            n = G.UIT.T, 
            config = { text = ' ' .. localize(string) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } 
          }}
        }}
      }}
      return { main_end = main_end }
    end
  end,
    
  calculate = function(self, card, context)
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
      if G.GAME.blind.boss then
        for key in pairs(card.ability.extra.jokers_copied_this_ante) do
          card.ability.extra.jokers_copied_this_ante[key] = nil
        end
        for key in pairs(card.ability.extra.jokers_copied_this_round) do
          card.ability.extra.jokers_copied_this_round[key] = nil
        end
        
        return {
          message_card = card,
          message = localize('k_reset'),
          colour = G.C.FILTER
        }
      else        
        for key in pairs(card.ability.extra.jokers_copied_this_round) do
          card.ability.extra.jokers_copied_this_ante[key] = true
          card.ability.extra.jokers_copied_this_round[key] = nil
        end
      end
    end
    
    local other_joker
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == card then 
        other_joker = G.jokers.cards[i + 1] 
      end
    end
    
    if other_joker and not card.ability.extra.jokers_copied_this_ante[other_joker.ID] then
      local ret = SMODS.blueprint_effect(card, other_joker, context)
      if ret then
        card.ability.extra.jokers_copied_this_round[other_joker.ID] = true
      end
      return ret
    end
  end
}