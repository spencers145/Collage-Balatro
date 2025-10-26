if PB_UTIL.should_load_spectrum_items() then
  SMODS.Joker {
    key = "lurid_joker",
    config = {
      t_chips = 80,
      type = 'paperback_Spectrum'
    },
    rarity = 1,
    pos = { x = 19, y = 1 },
    atlas = "jokers_atlas",
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    paperback = {
      requires_custom_suits = true,
      requires_spectrum_or_suit = true
    },

    loc_vars = function(self, info_queue, card)
      return {
        vars = {
          card.ability.t_chips,
          localize(card.ability.type, 'poker_hands')
        }
      }
    end
  }
end
