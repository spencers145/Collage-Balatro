SMODS.Joker {
  key = 'train_ticket',
  atlas = 'Jokers',
  rarity = 1,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('train_ticket'),
  
  config = {
    extra = {
      mult_gain = 1,
      card_count = 3,
      current_mult = 0
    }
  },
  
  loc_vars = function(self, info_queue, card)    
    return {
      vars = {
        card.ability.extra.mult_gain,
        card.ability.extra.card_count,
        card.ability.extra.current_mult
      }
    }
  end,
  
  calculate = function(self, card, context)    
    if context.joker_main then
      return {
        mult = card.ability.extra.current_mult
      }
    end
    
    if context.before and not context.blueprint then
      local function check_for_three_row()
        local IDs = {}
        for i = 1, #context.full_hand do
          local id = context.full_hand[i]:get_id()
          IDs[id] = true
          if id == 14 then
            IDs[1] = true
          end
        end
        
        for i = 1, 12 do
          if IDs[i] and IDs[i + 1] and IDs[i + 2] then
            return true
          end
        end
      end
      
      if check_for_three_row() then
        card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED
        }
      end
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)    
    return { 
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(G.GAME and G.GAME.hands['Straight'].played or 0) or nil,
      vars = { 
        30,
        localize('Straight', 'poker_hands')
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    return args.type == 'hand' and G.GAME.hands['Straight'].played >= 30
  end
}