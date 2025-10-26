SMODS.Joker {
  key = "joke_master",
  config = {
    extra = {
      mult = 0,
      a_mult = 2,
    }
  },
  rarity = 1,
  pos = { x = 15, y = 2 },
  atlas = "jokers_atlas",
  cost = 3,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  discovered = false,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.a_mult,
        localize(G.GAME.paperback.joke_master_hand, 'poker_hands'),
        card.ability.extra.mult
      }
    }
  end,

  calculate = function(self, card, context)
    if not context.blueprint and context.before and context.main_eval then
      -- Check that scoring hand is exactly the one needed
      if context.scoring_name == G.GAME.paperback.joke_master_hand then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult

        return {
          message = localize {
            type = 'variable',
            key = 'a_mult',
            vars = { card.ability.extra.mult }
          },
          colour = G.C.MULT
        }
      end
    end

    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
  end
}
