local magazine_ad = {
    object_type = "Joker",
    order = 309,
    ignore = true,
    key = "magazine_ad",
    config = {
    },
    rarity = 1,
    pos = { x = 6, y = 12},
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
return { name = {"Jokers"}, items = {magazine_ad} }
