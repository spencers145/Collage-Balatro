SMODS.Joker {
  key = "forlorn",
  config = {
    extra = {
      reduction = 0.04
    }
  },
  rarity = 1,
  pos = { x = 16, y = 10 },
  atlas = "jokers_atlas",
  cost = 6,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  in_pool = function (self, args)
    return PB_UTIL.has_suit_in_deck("bunc_Halberds", true)
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.reduction * 100
      }
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and context.other_card:is_suit('bunc_Halberds') and not context.end_of_round then
      return {
        collage_reduce_blind = card.ability.extra.reduction
      }
    end
  end
}
