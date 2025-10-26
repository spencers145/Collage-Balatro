SMODS.Joker {
  key = 'bankaccount',
  name = 'Bank Account',
  atlas = 'Jokers',
  rarity = 1,
  cost = 4,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('bankaccount'),
  config = {
    extra = {
      plus_chips = 100,
      interest_saved = 0
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.plus_chips }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.plus_chips,
        message = localize {
          type = 'variable',
          key = 'a_chips',
          vars = { card.ability.extra.plus_chips }
        },
        colour = G.C.CHIPS,
      }
    end
    
    --we use the overide function below to add custom events before and after the payout to check bank account.
    if not context.blueprint then
      --before the payout screen triggers, we quickly check how much interest we would earn, then turn off interest.
      if context.RD_before_payout and not G.GAME.current_round.RD_skip_interest then
        G.GAME.current_round.RD_skip_interest = true;
        if not G.GAME.modifiers.no_interest then -- if interest would normally be earned, increase this joker's sell value
          card.ability.extra.interest_saved = G.GAME.interest_amount * math.floor(math.min(G.GAME.dollars / 5, G.GAME.interest_cap / 5))
        end
      end
      
      --increase this joker's value after the whole payout screen has appeared.
      if context.RD_after_payout and to_big(card.ability.extra.interest_saved) > to_big(0) then
        G.E_MANAGER:add_event(Event({ --we do need this event, otherwise the piggybank-value will go up before the payout is drawn.
          func = function()
            card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.interest_saved
            card.ability.extra.interest_saved = 0
            card:set_cost()
            return true
          end
        }))
        card_eval_status_text(card, 'extra', nil, nil, nil, {
          message = localize('k_val_up'),
          colour = G.C.MONEY
        })
      end
    end
  end
}

--override of original function.
local old_func_evaluate_round = G.FUNCS.evaluate_round
function G.FUNCS.evaluate_round()
  local ret = nil
  
  --a custom eval_card_moment, just before the payout.
  for i = 1, #G.jokers.cards do
    eval_card(G.jokers.cards[i], {cardarea = G.jokers, RD_before_payout = true})
  end
  
  if G.GAME.current_round.RD_skip_interest then
    local interest_setting = G.GAME.modifiers.no_interest --we simply turn interest off, run the original function, then turn interest back on.
    G.GAME.modifiers.no_interest = true
    local ret = old_func_evaluate_round()
    G.GAME.modifiers.no_interest = interest_setting
    G.GAME.current_round.RD_skip_interest = false
  else 
    ret = old_func_evaluate_round() --if not skipping interest, simply execute the original function
  end
  
  --a custom eval_card_moment, just after the payout.
  for i = 1, #G.jokers.cards do
    eval_card(G.jokers.cards[i], {cardarea = G.jokers, RD_after_payout = true})
  end
  
  return ret
end