SMODS.Joker {
  key = 'dealer',
  atlas = 'Jokers',
  rarity = 2,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('dealer'),
  
  config = {
    extra = {
      hand_bonus = 2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.hand_bonus
      }
    }
  end,
  
  calculate = function(self, card, context)
    if G.GAME.blind and G.GAME.blind.in_blind then
      if context.selling_self or (context.selling_card and context.card ~= card and context.card.ability.set == 'Joker') then
        return {
          message_card = context.blueprint_card or card,
          message = localize('rainydays_plus') .. card.ability.extra.hand_bonus .. ' ' .. localize('rainydays_hand_cap'),
          func = function()
            ease_hands_played(card.ability.extra.hand_bonus)
            return true
          end,
          colour = G.C.BLUE
        }
      end
    end
  end,
    
  locked_loc_vars = function(self, info_queue, card)
    local bool = (G.GAME.blind and G.GAME.blind.in_blind and G.GAME.current_round) or nil
    return { 
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(bool and G.GAME.current_round.hands_played or 0) or nil,
      vars = { 
        6
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    return args.type == 'round_win' and G.GAME.current_round.hands_played >= 6
  end
}