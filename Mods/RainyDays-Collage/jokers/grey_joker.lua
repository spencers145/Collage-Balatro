SMODS.Joker {
  key = 'grey_joker',
  atlas = 'Jokers',
  rarity = 2,
  cost = 8,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('grey_joker'),
  
  config = {
    extra = {
      hand = 'Flush',
      xmult = 1,
      xmult_gain = 0.2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.extra.hand, 'poker_hands'),
        card.ability.extra.xmult_gain,
        card.ability.extra.xmult
      }
    }
  end,
  
  calculate = function(self, card, context)    
    if context.joker_main then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    if context.pre_discard and not context.blueprint then
      local _, _, hands_discarded = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if next(hands_discarded[card.ability.extra.hand]) then
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.RED
        }
      end
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_stone') then
          count = count + 1
        end
      end
    end
    
    return {
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        5
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' and G.playing_cards then
      local count = 0
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_stone') then
          count = count + 1 
          if count >= 5 then
            return true
          end
        end
      end
    return false
    end
  end
}