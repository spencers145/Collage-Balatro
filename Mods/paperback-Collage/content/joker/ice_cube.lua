SMODS.Joker {
  key = "ice_cube",
  config = {
    extra = {
      x_mult_mod = 1,
      rounds_left = 4,
    }
  },
  rarity = 1,
  pos = { x = 3, y = 8 },
  atlas = 'jokers_atlas',
  cost = 4,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = false,
  pools = {
    Food = true
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.x_mult_mod,
        card.ability.extra.rounds_left,
        (#PB_UTIL.get_owned_food() + 1) * card.ability.extra.x_mult_mod
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local x_mult = (#PB_UTIL.get_owned_food() + 1) * card.ability.extra.x_mult_mod

      if x_mult > 1 then
        return {
          x_mult = x_mult
        }
      end
    end

    -- At end of round decrease the amount of rounds left, destroying
    -- itself if it ever goes below 1
    if context.final_scoring_step and (hand_chips * mult > G.GAME.blind.chips) and not context.blueprint then
      G.E_MANAGER:add_event(Event {
        trigger = 'after',
        delay = 0.5,
        func = function()
          PB_UTIL.destroy_joker(card)
          return true
        end
      })
      return {
        message = localize('paperback_melted_ex')
      }
    end
  end
}
