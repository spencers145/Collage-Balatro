local grock = {
    object_type = "Joker",
    order = 1012,
    ignore = true,

    key = "grock",
    config = {
      
    },
    rarity = 4,
	unlock_condition = {hidden = true},
    pos = { x = 1, y = 2},
    atlas = 'legendary_atlas',
    cost = 4,
    unlocked = false,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    soul_pos = { x = 1, y = 3},
  
    loc_vars = function(self, info_queue, card)
  
    end,
  
    calculate = function(self, card, context)
      
    end
  
}
return { name = {"Jokers"}, items = {grock} }
