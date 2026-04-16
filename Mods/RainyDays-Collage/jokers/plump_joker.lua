SMODS.Joker {
  key = 'plump_joker',
  atlas = 'Plump_joker',
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = { x = 0, y = 0 },
  display_size = { w = 80, h = 95 },
  
  config = {
    extra = {
      per_mult = 6
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.per_mult,
        (G.GAME.blind and G.GAME.rd_consumeable_usage_ante or 0) * card.ability.extra.per_mult,
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = (G.GAME.rd_consumeable_usage_ante or 0) * card.ability.extra.per_mult
      }
    end
    
    if context.using_consumeable and not context.blueprint then
      return {
        message_card = card,
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT
      }
    end
    
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
      if G.GAME.rd_consumeable_usage_ante then
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    return { 
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(G.GAME and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.all or 0) or nil,
      vars = { 
        100
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    return args.type == 'rd_used_consumeable' and G.GAME and G.GAME.consumeable_usage_total.all >= 100
  end
}