SMODS.Joker {
  key = 'sticky_stick',
  config = {
    extra = {
      xMult = 1
    }
  },
  rarity = 1,
  pos = { x = 5, y = 3 },
  atlas = 'jokers_atlas',
  cost = 7,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = nil,
  yes_pool_flag = "sticks_can_spawn",

  loc_vars = function(self, info_queue, card)
    local xMult = PB_UTIL.calculate_stick_xMult(card)

    return {
      vars = {
        card.ability.extra.xMult,
        xMult
      }
    }
  end,

  calculate = PB_UTIL.stick_joker_logic,
  joker_display_def = PB_UTIL.stick_joker_display_def
}
