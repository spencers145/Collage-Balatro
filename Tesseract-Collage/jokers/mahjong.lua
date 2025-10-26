SMODS.Joker { --mahjong
  key = 'mahjong',
  pixel_size = { w = 61, h = 84 },
  rarity = 1,
  cost = 5,
  perishable_compat = true,
  eternal_compat = true,
  blueprint_compat = true,
  atlas = 'T.Jokers',
  pos = { x = 5, y = 1 },
  config = { extra = { dollars = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollars } }
  end,
  discovered = false,
  calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Pair']) then
      ease_dollars(card.ability.extra.dollars)
      return {
        message = localize('$')..card.ability.extra.dollars,
        colour = G.C.MONEY
      }
    end
  end
}
