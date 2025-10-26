SMODS.Joker { --impos
  key = 'impos',
  config = { extra = { Xmult = 2.8 } },
  rarity = 2,
  atlas = 'T.Jokers',
  pos = { x = 3, y = 1 },
  cost = 8,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
  discovered = false,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      local contains_two = false
      local contains_eight = false
      
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:get_id() == 2 then
          contains_two = true;
        elseif context.scoring_hand[i]:get_id() == 8 then
          contains_eight = true;
        end
      end
      
      if contains_two and contains_eight then
        return {
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
          Xmult_mod = card.ability.extra.Xmult
        }
      end
    end
  end
}
