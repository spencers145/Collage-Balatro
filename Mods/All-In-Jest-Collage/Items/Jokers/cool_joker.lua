local cool_joker = {
    object_type = "Joker",
    order = 48,
    ignore = true,

    key = "cool_joker",
    config = {
      
    },
    rarity = 1,
    pos = { x = 19, y = 1 },
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
return { name = {"Jokers"}, items = {cool_joker} }
