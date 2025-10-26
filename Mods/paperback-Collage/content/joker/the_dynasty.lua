if PB_UTIL.should_load_spectrum_items() then
  SMODS.Joker {
    key = "the_dynasty",
    config = {
      Xmult = 5,
      type = 'paperback_Spectrum'
    },
    rarity = 3,
    pos = { x = 19, y = 2 },
    atlas = "jokers_atlas",
    cost = 8,
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
          card.ability.Xmult,
          localize(card.ability.type, 'poker_hands')
        }
      }
    end
  }
end
