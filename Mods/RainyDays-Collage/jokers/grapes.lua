SMODS.Joker {
  key = 'grapes',
  atlas = 'Jokers',
  pools = { Food = true },
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('grapes'),
  config = {
    extra = {
      card_amount = 30,
      mult_lower = 0,
      mult_higher = 8
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.card_amount,
        card.ability.extra.mult_lower,
        card.ability.extra.mult_higher
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and card.ability.extra.card_amount > 0 then
      if not context.blueprint then
        card.ability.extra.card_amount = card.ability.extra.card_amount - 1
      end
      
      local mult_to_give = pseudorandom('grapes', card.ability.extra.mult_lower, card.ability.extra.mult_higher) 
      return {
        mult = mult_to_give ~= 0 and mult_to_give or nil,
        message = mult_to_give == 0 and localize {
          type = 'variable',
          key = 'a_mult',
          vars = { mult_to_give }
        } or nil,
        colour = G.C.MULT
      }
    end
    
    if context.after and card.ability.extra.card_amount <= 0 and not context.blueprint then
      SMODS.destroy_cards(card, nil, nil, true)
      G.E_MANAGER:add_event(Event({
        func = function()
          card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_eaten_ex'), colour = G.C.RED })
          return true
        end
      }))
    end
  end
}