SMODS.Joker { --blue_java
    key = "blue_java",
    pools = { Food = true },
    yes_pool_flag = 'plantain_extinct',
    config = { extra = { chips = 250 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
      end,
    rarity = 1,
    discovered = false,
    perishable_compat = true,
    blueprint_compat = true,
    eternal_compat = true,
    atlas = 'T.Jokers',
    pos = { x = 0, y = 0 },
    -- Cost of card in shop.
    cost = 4,
    calculate = function(self, card, context)
      if context.joker_main then
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
        }
      end
    end
}