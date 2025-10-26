if next(SMODS.find_mod('plantain')) then
  SMODS.Joker:take_ownership('pl_croissant',
    {  
      config = {
        extra = {
          upgrades_left = 4,
          give_repetitition = false
        }
      },
      
      calculate = function (self, card, context)
        if context.hand_upgrade_repetitions then
          if context.blueprint then
            if GetJokerPosition(context.blueprint_card) < GetJokerPosition(card) then
               card.ability.extra.give_repetitition = (card.ability.extra.upgrades_left > 1)
            end
          else
            card.ability.extra.give_repetitition = false
            if card.ability.extra.upgrades_left > 0 then
              card.ability.extra.give_repetitition = true
              card.ability.extra.upgrades_left = card.ability.extra.upgrades_left - 1
            end
          end

          if card.ability.extra.give_repetitition then
            local func_eaten = function()
              card_eval_status_text(card, 'jokers', nil, nil, nil, { message = localize('k_eaten_ex'), colour = G.C.RED })
              G.E_MANAGER:add_event(Event({
                func = function()
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
            end

            return { 
              repetitions = 1,
              func = (not context.blueprint and card.ability.extra.upgrades_left <= 0) and func_eaten or nil
            }
          end
        end
      end
    },
    true
  )
end