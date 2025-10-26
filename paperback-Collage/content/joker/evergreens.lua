SMODS.Joker {
  key = "evergreens",
  config = {
    extra = {
      xMult = 1.1,
      xMult_gain = 0.1,
      xMult_base = 1.1,
      suit = "Spades"
    }
  },
  rarity = 3,
  pos = { x = 3, y = 4 },
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
