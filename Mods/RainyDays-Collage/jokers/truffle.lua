SMODS.Joker {
  key = 'truffle',
  name = 'Truffle',
  atlas = 'Jokers',
  pools = { Food = true },
  rarity = 3,
  cost = 7,
  unlocked = true, 
  discovered = false,
  blueprint_compat = false,
  eternal_compat = false,
  perishable_compat = true,
  pos = GetJokersAtlasTable('truffle'),
  config = {
    extra = {
      amount = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
    return {
      vars = { 
        card.ability.extra.amount
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and not context.blueprint then
      for i = 1, #context.scoring_hand do
        local scoring_card = context.scoring_hand[i]
        if scoring_card:is_face() and card.ability.extra.amount > 0 and not scoring_card.edition then
          card.ability.extra.amount = card.ability.extra.amount - 1
          scoring_card:set_edition(pseudorandom_element({'e_foil', 'e_holo'}, pseudoseed('rainy_truffle')), true, true)
          --scoring_card.delay_edition = true
          G.E_MANAGER:add_event(Event({
            trigger = 'after', 
            delay = 0.4, 
            func = function()
              --scoring_card.delay_edition = nil
              scoring_card:juice_up()
              play_sound('foil1', 1.2, 0.4)
              return true 
            end 
          }))
          delay(0.3)
        end
      end
      
      if card.ability.extra.amount <= 0 then
        G.E_MANAGER:add_event(Event({func = function()
          play_sound('tarot1')
          card.T.r = -0.2
          card:juice_up(0.3, 0.4)
          card.states.drag.is = true
          card.children.center.pinch.x = true
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            blockable = false,
            func = function()
              card:remove()
              return true
            end
          }))
          return true
          end
        }))
        return {
          message = localize('k_eaten_ex'),
          colour = G.C.RED
        }
      end
    end
  end
}