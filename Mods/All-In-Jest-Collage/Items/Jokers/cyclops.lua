local cyclops = {
  object_type = "Joker",
  order = 177,
  ignore = true,

  key = "cyclops",
  config = {
    
  },
  rarity = 1,
  pos = { x = 20, y = 6},
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
return { name = {"Jokers"}, items = {cyclops} }
