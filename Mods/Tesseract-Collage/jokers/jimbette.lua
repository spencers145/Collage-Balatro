SMODS.Joker { --jimbette
  key = 'jimbette',
  
  cost = 6,
  perishable_compat = false,
  blueprint_compat = true,
  eternal_compat = true,
  rarity = 2,
  atlas = 'T.Jokers',
  pos = { x = 4, y = 1 },
  config = { extra = { mult = 0, mult_gain = 4, num = 0, jh = 7 } },
  loc_vars = function(self, info_queue, card)
    return {vars = { card.ability.extra.mult_gain, card.ability.extra.mult, card.ability.extra.jh } }
  end,
  discovered = false,
  calculate = function(self, card, context)
    if not context.blueprint then
      if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit("Hearts") then
          card.ability.extra.num = card.ability.extra.num + 1
          card.ability.extra.jh = card.ability.extra.jh - 1
        end
        if card.ability.extra.num >= 7 then 
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
          card.ability.extra.num = 0
          card.ability.extra.jh = 7
          return {
            message_card = card,
            message = localize('k_upgrade_ex'),
            colour = G.C.MULT,
          }
        end
      end
    end
    
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
  end
}