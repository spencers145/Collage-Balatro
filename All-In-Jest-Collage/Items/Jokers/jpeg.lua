local jpeg = {
    object_type = "Joker",
    order = 336,
    ignore = true,
    key = "jpeg",
    config = {
    },
    rarity = 1,
    pos = { x = 7, y = 13},
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
  
    loc_vars = function(self, info_queue, card)

    end,
  
    calculate = function(self, card, context)
        
    end
  
}
return { name = {"Jokers"}, items = {jpeg} }
