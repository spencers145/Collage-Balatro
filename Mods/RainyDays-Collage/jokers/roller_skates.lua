SMODS.Joker {
  key = 'roller_skates',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('roller_skates'),
  
  config = {
    extra = {
      xmult = 3,
      hand1 = 'Three of a Kind',
      hand2 = 'Full House'
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local active = RainyDays.skates_check_active(card)
    return {
      vars = {
        colours = {
          active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
        },
        card.ability.extra.xmult,
        localize(card.ability.extra.hand1, 'poker_hands'),
        localize(card.ability.extra.hand2, 'poker_hands'),
        active and localize('rainydays_active') or localize('rainydays_inactive')
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main and RainyDays.skates_check_active(card) then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    if context.pre_discard and not context.blueprint then
      local discard_hand = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
      if card.ability.extra.hand1 == discard_hand or card.ability.extra.hand2 == discard_hand then
        if (G.GAME.hands[card.ability.extra.hand1].rd_discarded_this_round == 1 and not G.GAME.hands[card.ability.extra.hand2].rd_discarded_this_round)
        or (G.GAME.hands[card.ability.extra.hand2].rd_discarded_this_round == 1 and not G.GAME.hands[card.ability.extra.hand1].rd_discarded_this_round) then
          return {
            message = localize('rainydays_activated'),
            colour = G.C.RED
          }
        end
      end
    end
    
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.GAME then
      for _, value in ipairs(G.handlist) do
        if G.GAME.hands[value].rd_discarded > 0 then
          count = count + 1
        end
      end
    end
    
    return {
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        6
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'discard_custom' then
      local count = 0
      for _, value in ipairs(G.handlist) do
        if G.GAME.hands[value].rd_discarded > 0 then
          count = count + 1
          if count >= 6 then
            return true
          end
        end
      end
    return false
    end
  end
}

function RainyDays.skates_check_active(card)
  if G.GAME.blind and G.GAME.blind.in_blind then
    if G.GAME.hands[card.ability.extra.hand1].rd_discarded_this_round and G.GAME.hands[card.ability.extra.hand1].rd_discarded_this_round > 0 then
      return true
    elseif G.GAME.hands[card.ability.extra.hand2].rd_discarded_this_round and G.GAME.hands[card.ability.extra.hand2].rd_discarded_this_round > 0 then
      return true
    end
  end
  return false
end