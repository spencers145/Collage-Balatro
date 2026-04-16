SMODS.Joker {
  key = 'blood_moon',
  atlas = 'Jokers',
  rarity = 3,
  cost = 8,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('blood_moon'),
  
  config = {
    extra = {
      xmult = 3,
      active = false
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        colours = {
          card.ability.extra.active and G.C.FILTER or G.C.UI.TEXT_INACTIVE
        },
        card.ability.extra.xmult,
        card.ability.extra.active and localize('rainydays_active') or localize('rainydays_inactive')
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.active and #context.full_hand > 1 then
      card.ability.extra.clear = true
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    if context.after and card.ability.extra.clear and not context.blueprint then
      card.ability.extra.clear = nil
      card.ability.extra.active = false
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end
    
    if context.destroy_card and not context.blueprint then
      if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] then
        if not card.ability.extra.active then
          card.ability.extra.active = true        
          return {
            message_card = card,
            message = localize('rainydays_activated'),
            colour = G.C.RED,
            remove = true
          }
        end
      end
    end
  end
}