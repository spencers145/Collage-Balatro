SMODS.Joker {
  key = 'avocado',
  atlas = 'Jokers',
  pools = { Food = true },
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('avocado'),
  config = {
    extra = {
      mult = 24,
      malus_mult = 8
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.mult,
        card.ability.extra.malus_mult
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
    
    if context.open_booster and not context.blueprint then
      card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.malus_mult
      if card.ability.extra.mult <= 0 then
        SMODS.destroy_cards(card, nil, nil, true)
        return {
          message = localize('k_eaten_ex'),
          colour = G.C.RED
        }
      else 
        return {
          message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.extra.malus_mult }},
          colour = G.C.MULT
        }
      end
    end
  end
}