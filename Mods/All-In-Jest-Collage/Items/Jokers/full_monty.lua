local full_monty = {
    object_type = "Joker",
    order = 330,
    ignore = true,
    key = "full_monty",
    config = {
    },
    rarity = 1,
    pos = { x = 1, y = 13},
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
return { name = {"Jokers"}, items = {full_monty} }
