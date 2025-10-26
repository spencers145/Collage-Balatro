SMODS.Joker { --mint
  key = 'mint',
  pools = { Food = true },
  config = { extra = { money = 10, money_decrease = 2 } },
  rarity = 2,
  atlas = 'T.Jokers',
  pos = { x = 1, y = 0 },
  cost = 8,
  discovered = false,
  eternal_compat = false,
  blueprint_compat = false,
  perishable_compat = true,
  in_pool = function(self, args)
    if (next(SMODS.find_mod('plantain')) and tes.config.suppression_apple_pie == 2) then
      return false
    end
    return true
  end,
  no_collection = (next(SMODS.find_mod('plantain')) and tes.config.suppression_apple_pie == 2) and true or nil,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, card.ability.extra.money_decrease } }
  end,

  calc_dollar_bonus = function(self, card)
    local bonus = card.ability.extra.money
    if bonus > 0 then return bonus end
  end,

  calculate = function(self, card, context)
    if context.pre_discard and not context.blueprint then
      card.ability.extra.money = card.ability.extra.money - card.ability.extra.money_decrease
      if card.ability.extra.money <= 0 then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
                return true
              end
            }))
            return true
          end
        }))
    
        card_eval_status_text(card, 'jokers', nil, nil, nil, {message = localize('k_eaten_ex'), colour = G.C.RED})
      else
        card_eval_status_text(card, 'jokers', nil, nil, nil, {message = '-$1', colour = G.C.GOLD})
      end
    end
  end
}

--override of original function.
local old_func_evaluate_round = G.FUNCS.evaluate_round
function G.FUNCS.evaluate_round()
  local ret = old_func_evaluate_round()
  --a custom event, just after the payout.
  for i = 1, #G.jokers.cards do
    eval_card(G.jokers.cards[i], {cardarea = G.jokers, tesseract_mint_payout = true})
  end
  return ret
end