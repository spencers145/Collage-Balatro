SMODS.Joker {
  key = "milk_tea",
  config = {
    extra = {
      percent = 50,
      reduction = 10
    }
  },
  rarity = 2,
  pos = { x = 16, y = 3 },
  atlas = "jokers_atlas",
  cost = 6,
  blueprint_compat = true,
  eternal_compat = false,
  perishable_compat = true,
  discovered = false,
  pools = {
    Food = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.percent,
        card.ability.extra.reduction
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local f_chips = math.floor(hand_chips * card.ability.extra.percent / 100)
      local f_mult = math.floor(mult * card.ability.extra.percent / 100)

      hand_chips = mod_chips(hand_chips - f_chips)
      mult = mod_mult(mult - f_mult)

      local total = f_chips + f_mult
      hand_chips = mod_chips(math.floor(total / 2) + hand_chips)
      mult = mod_mult(math.floor(total / 2) + mult)

      PB_UTIL.apply_plasma_effect(context.blueprint_card or card, true)

      -- Apply reduction if mult ended up greater than chips
      if mult > hand_chips and not context.blueprint then
        card.ability.extra.percent = card.ability.extra.percent - card.ability.extra.reduction

        if card.ability.extra.percent <= 0 then
          PB_UTIL.destroy_joker(card)

          return {
            message = localize('paperback_consumed_ex'),
            colour = G.C.MULT
          }
        end

        G.E_MANAGER:add_event(Event {
          delay = 0.4,
          func = function()
            SMODS.calculate_effect({
              message = localize('paperback_reduced_ex'),
              colour = G.C.MULT
            }, card)

            return true
          end
        })
      end

      return nil, true
    end
  end
}
