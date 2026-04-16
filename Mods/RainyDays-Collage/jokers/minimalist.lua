SMODS.Joker {
  key = 'minimalist',
  atlas = 'Jokers',
  rarity = 1,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('minimalist'),
  
  config = {
    extra = {
      mult = 15
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main and G.jokers and G.jokers.config.card_limit > #G.jokers.cards then
      return {
        mult = card.ability.extra.mult
      }
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        3
      }
    }
  end,  
  
  check_for_unlock = function(self, args)
    return args.type == 'ante_up' and args.ante == 3 and G.GAME.max_jokers <= 0
  end
}