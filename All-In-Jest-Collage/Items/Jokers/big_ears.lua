local big_ears = {
    object_type = "Joker",
    order = 74,
    ignore = true,

    key = "big_ears",
    config = {
      
    },
    rarity = 1,
    pos = { x = 19, y = 2 },
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
return { name = {"Jokers"}, items = {big_ears} }
