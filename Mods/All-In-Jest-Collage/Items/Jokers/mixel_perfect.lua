local mixel_perfect = {
    object_type = "Joker",
    order = 115,

    key = "mixel_perfect",
    config = {
      extra = {
        mult = 10
      }
    },
    rarity = 1,
    pos = { x = 10, y = 4 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
      return {
        vars = {
          card.ability.extra.mult
        }
      }
    end,
  
    calculate = function(self, card, context)
      if context.joker_main and math.fmod(#context.full_hand, 2) == 1 then
        return {
          mult = card.ability.extra.mult
        }
      end
    end
  
}
return { name = {"Jokers"}, items = {mixel_perfect} }
