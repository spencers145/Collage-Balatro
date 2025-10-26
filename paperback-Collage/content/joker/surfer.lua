SMODS.Joker {
  key = 'surfer',
  config = {
    extra = {
      mult = 0,
      a_mult_held = 1,
      --a_chips_scored = 5,
      rank = "10",
    }
  },
  rarity = 1,
  pos = { x = 5, y = 10 },
  atlas = 'jokers_atlas',
  cost = 5,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.a_mult_held,
        --card.ability.extra.a_chips_scored,
        localize(card.ability.extra.rank, 'ranks'),
        card.ability.extra.mult,
      }
    }
  end,

  calculate = function(self, card, context)
    -- Gains +10 chips for each 10 held in hand at end of round
    if context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint then
      if PB_UTIL.is_rank(context.other_card, card.ability.extra.rank) then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_mult_held

        return {
          message = localize {
            type = 'variable',
            key = 'a_mult',
            vars = { card.ability.extra.a_mult_held }
          },
          colour = G.C.MULT,
          juice_card = context.other_card,
          message_card = card,
        }
      end
    end

    -- Gains +5 chips for each 10 scored
    --[[if context.individual and context.cardarea == G.play and not context.blueprint then
      if PB_UTIL.is_rank(context.other_card, card.ability.extra.rank) then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.a_chips_scored

        return {
          message = localize {
            type = 'variable',
            key = 'a_chips',
            vars = { card.ability.extra.a_chips_scored }
          },
          colour = G.C.CHIPS,
          juice_card = context.other_card,
          message_card = card,
        }
      end
    end]]

    -- Give chips during scoring
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
  end
}
