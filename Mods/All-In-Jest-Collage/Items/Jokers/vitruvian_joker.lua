local vitruvian_joker = {
    object_type = "Joker",
    order = 270,
    
    key = "vitruvian_joker",
    config = {
      extra = {
        xmult = 3
      }
    },
    rarity = 3,
    pos = { x = 17, y = 10},
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult
            }
        }
    end,
  
    calculate = function(self, card, context)
        if context.joker_main and #G.jokers.cards == 5 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
  
}
return { name = {"Jokers"}, items = {vitruvian_joker} }
