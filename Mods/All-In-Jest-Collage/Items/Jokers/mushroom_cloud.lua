local mushroom_cloud = {
    object_type = "Joker",
    order = 229,
    ignore = true,

    key = "mushroom_cloud",
    config = {
      
    },
    rarity = 1,
    pos = { x = 18, y = 8},
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
return { name = {"Jokers"}, items = {mushroom_cloud} }
