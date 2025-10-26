SMODS.Joker { --pie
  key = 'pie',
  pools = { Food = true },
  rarity = 1,
  cost = 6,
  discovered = false,
  atlas = "T.Jokers",
  pos = { x = 0, y = 2 },
  eternal_compat = false,
  perishable_compat = true,
  blueprint_compat = true,
  config = { extra =  { dollars = 4, dollar_mod = 1 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollars, card.ability.extra.dollar_mod } }
  end,
  calculate = function (self, card, context)
    if context.joker_main then
        return {
            dollars = card.ability.extra.dollars,
        }
    end
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint and G.GAME.current_round.hands_played ~= 0 then
        card.ability.extra.dollars = card.ability.extra.dollars - card.ability.extra.dollar_mod
        if card.ability.extra.dollars <= 0 then
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
        return {
          message = localize('k_eaten_ex'),
          colour = G.C.RED,
        }
      else
        return {
          message = "-$" .. tostring(card.ability.extra.dollar_mod),
          colour = G.C.MONEY,
        }
	  end
    end
  end
}