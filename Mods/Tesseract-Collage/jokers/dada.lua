SMODS.Joker { --dada
  key = 'dada',
  rarity = 2,
  atlas = 'T.Jokers',
  pos = { x = 2, y = 1 },
  cost = 7,
  perishable_compat = true,
  blueprint_compat = true,
  eternal_compat = true,
  config = { extra = { xmult = 1.2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  discovered = false,

  calculate = function(self, card, context)
    if context.other_joker then
      return {
        xmult = card.ability.extra.xmult
      }
    end
  end
}