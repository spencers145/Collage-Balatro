local deburau = {
    object_type = "Joker",
    order = 1014,
    ignore = true,

    key = "deburau",
    config = {
      
    },
    rarity = 4,
	unlock_condition = {hidden = true},
    pos = { x = 3, y = 2},
    atlas = 'legendary_atlas',
    cost = 4,
    unlocked = false,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    soul_pos = { x = 3, y = 3},
  
    loc_vars = function(self, info_queue, card)
  
    end,
  
    calculate = function(self, card, context)
      
    end
  
}
return { name = {"Jokers"}, items = {deburau} }
