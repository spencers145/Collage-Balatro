local oil_and_water = {
    object_type = "Joker",
    order = 73,
    ignore = true,

    key = "oil_and_water",
    config = {
      
    },
    rarity = 1,
    pos = { x = 18, y = 2 },
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
return { name = {"Jokers"}, items = {oil_and_water} }
