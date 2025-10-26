SMODS.Joker {
    key = "trixel",
    rarity = 2,
    pos = { x = 1, y = 4},
    atlas = 'joker_atlas',
    config = {
      extra = {
        mult_mod = 3,
        mult = 0,
      }
    },
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.mult_mod,
            card.ability.extra.mult,
          }
        }
    end,

    calculate = function(self, card, context)

		if not context.blueprint and context.before and context.main_eval and context.scoring_name=="Three of a Kind" then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod

          return {
          message = localize {
            type = 'variable',
            key = 'a_mult',
            vars = { card.ability.extra.mult }
          },
          colour = G.C.MULT
          }
        end
        
        if context.joker_main then
        return {
        mult = card.ability.extra.mult
        }
        end
	end
    }