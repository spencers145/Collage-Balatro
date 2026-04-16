SMODS.Joker {
  key = 'beanstalk',
  atlas = 'Jokers',
  rarity = 2,
  cost = 8,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('beanstalk'),
  
  config = {
    extra = {
      xmult_start = 1,
      xmult = 1,
      xmult_gain = 0.25,
      card_amount = 1,
      cards_used_this_round = 0
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local amount = card.ability.extra.card_amount - card.ability.extra.cards_used_this_round
    local string
    if amount <= 0 then
      string = localize('rainydays_beanstalk_grown')
    else
      string = ' ' .. localize('rainydays_more')
      if card.ability.extra.xmult ~= card.ability.extra.xmult_start then
        string = string .. ' ' .. localize('rainydays_beanstalk_or_will_reset')
      end
    end
  
    return {
      vars = {
        card.ability.extra.xmult_gain,
        card.ability.extra.card_amount,
        card.ability.extra.xmult,
        amount > 0 and amount or '',
        string
      }
    }
  end,
  
  calculate = function(self, card, context)    
    if context.joker_main then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    if context.using_consumeable and card.ability.extra.cards_used_this_round < card.ability.extra.card_amount and not context.blueprint then
      card.ability.extra.cards_used_this_round = card.ability.extra.cards_used_this_round + 1
      if card.ability.extra.cards_used_this_round >= card.ability.extra.card_amount then
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
        return { 
          message_card = card,
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      else
        local amount = card.ability.extra.card_amount - card.ability.extra.cards_used_this_round
        return { 
          message_card = card,
          message = amount .. ' ' .. localize('rainydays_more_dots'),
          colour = G.C.FILTER
        }
      end
    end
    
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      if card.ability.extra.cards_used_this_round < card.ability.extra.card_amount and card.ability.extra.xmult ~= card.ability.extra.xmult_start then
        card.ability.extra.xmult = card.ability.extra.xmult_start
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
      card.ability.extra.cards_used_this_round = 0
    end
  end,
}