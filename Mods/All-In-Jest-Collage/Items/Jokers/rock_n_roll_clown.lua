local rock_n_roll_clown = {
    object_type = "Joker",
    order = 365,
    ignore = true,
    key = "rock_n_roll_clown",
    config = {
    },
    rarity = 1,
    pos = { x = 23, y = 19},
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
return { name = {"Jokers"}, items = {rock_n_roll_clown} }
