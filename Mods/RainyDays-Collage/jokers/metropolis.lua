SMODS.Joker {
  key = 'metropolis',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true, 
  pos = RainyDays.GetJokersAtlasTable('metropolis'),
  config = {
    extra = {
      poker_hand = 'Full House',
      xmult = 3,
      amount_hands = 2,
      activations = 0
    }
  },
    
  loc_vars = function(self, info_queue, card)
    local active = card.ability.extra.activations > 0
    return {
      vars = {
        colours = {
          active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
        },
        localize(card.ability.extra.poker_hand, 'poker_hands'),
        card.ability.extra.xmult,
        card.ability.extra.amount_hands,
        active and localize('rainydays_active_cap') or localize('rainydays_currently'),
        active and (localize('rainydays_for_next') .. ' ') or localize('rainydays_inactive'),
        card.ability.extra.activations > 1 and (card.ability.extra.activations .. ' ') or '',
        active and (card.ability.extra.activations == 1 and localize('rainydays_hand') or localize('rainydays_hands')) or ''
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      if next(context.poker_hands[card.ability.extra.poker_hand]) then
        card.ability.extra.hand_played = true
      end
      
      if card.ability.extra.activations > 0 then
        return {
          xmult = card.ability.extra.xmult
        }
      end
    end
    
    if context.after and not context.blueprint then
      if card.ability.extra.hand_played then
        card.ability.extra.hand_played = nil
        card.ability.extra.activations = card.ability.extra.amount_hands
        return {
          message = localize('rainydays_activated'),
          colour = G.C.RED
        }
      elseif card.ability.extra.activations > 0 then 
        card.ability.extra.activations = card.ability.extra.activations - 1
        if card.ability.extra.activations == 0 then
          return {
            message = localize('k_reset'),
            colour = G.C.RED
          }
        end
      end
    end
  end
}