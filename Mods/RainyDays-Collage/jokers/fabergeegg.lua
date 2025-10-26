SMODS.Joker {
  key = 'fabergeegg',
  name = 'Fabergé Egg',
  atlas = 'Jokers',
  rarity = 1,
  cost = 4,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('fabergeegg'),
  config = {
    extra = {
      plus_value = 1
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.plus_value }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:is_face() then
      card.ability.extra_value = card.ability.extra_value + card.ability.extra.plus_value
      card:set_cost()
      return {
        message_card = card,
        message = localize('k_val_up'),
        colour = G.C.MONEY
      }
    end
  end
}