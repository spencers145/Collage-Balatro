local joker_baby = {
    object_type = "Joker",
    order = 58,
    ignore = true,

    key = "joker_baby",
    config = {
      
    },
    rarity = 1,
    pos = { x = 4, y = 2 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
  
    loc_vars = function(self, info_queue, card)
  
    end,
  
    calculate = function(self, card, context)
      
    end
  
}
return { name = {"Jokers"}, items = {joker_baby} }
