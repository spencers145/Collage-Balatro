SMODS.Joker {
    key = "sadcube",
    config = {
      extra = {
        money=1,
      }
    },
    rarity = 1,
    pos = { x = 3, y = 2},
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.money,
          }
        }
    end,

    calculate = function(self, card, context)
      if context.pseudorandom_result and not context.result then
        return {
          dollars = card.ability.extra.money,
          juice_card = context.blueprint_card or card
        }
      end
    end
    }