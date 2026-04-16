SMODS.Joker {
  key = 'truffle',
  atlas = 'Jokers',
  pools = { Food = true },
  rarity = 3,
  cost = 9,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('truffle'),
  config = {
    extra = {
      xmult_amount = 4,
      xmult_decrease = 0.01
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.xmult_amount,
        card.ability.extra.xmult_decrease
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        xmult = card.ability.extra.xmult_amount
      }
    end
    
    if context.end_of_round and context.game_over == false and not context.repetition and not context.individual and not context.blueprint then
      local decrease = card.ability.extra.xmult_decrease * #G.deck.cards
      if decrease > 0 then
        card.ability.extra.xmult_amount = card.ability.extra.xmult_amount - decrease
        if card.ability.extra.xmult_amount <= 1 then
          SMODS.destroy_cards(card, nil, nil, true)
          return {
            message = localize('k_eaten_ex'),
            colour = G.C.RED
          }
        else 
          return {
            message = localize { type = 'variable', key = 'a_xmult_minus', vars = { decrease }},
            colour = G.C.MULT
          }
        end
      end
    end
  end
}