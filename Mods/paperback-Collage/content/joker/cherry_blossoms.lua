SMODS.Joker {
  key = "cherry_blossoms",
  config = {
    extra = {
      xMult = 1.4,
      xMult_gain = 0.02,
      xMult_base = 1.4,
      suit = "Hearts",
    }
  },
  rarity = 3,
  pos = { x = 2, y = 4 },
  atlas = "jokers_atlas",
  cost = 9,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  soul_pos = nil,

  loc_vars = PB_UTIL.panorama_loc_vars,
  calculate = PB_UTIL.panorama_logic,
  joker_display_def = PB_UTIL.panorama_joker_display_def
}
