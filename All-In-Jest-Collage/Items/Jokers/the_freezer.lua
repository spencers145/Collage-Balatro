local the_freezer = {
    object_type = "Joker",
    order = 319,
    ignore = true,
    key = "the_freezer",
    config = {
    },
    rarity = 1,
    pos = { x = 15, y = 12},
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
return { name = {"Jokers"}, items = {the_freezer} }
