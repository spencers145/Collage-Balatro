loc_colour() --first time running creates G.ARGS.LOC_COLOURS
G.ARGS.LOC_COLOURS.mint = HEX('50e8b1')

SMODS.Seal {
  key = 'mint',
  atlas = 'Seals',
  pos = { x = 1, y = 0 },
  badge_colour = G.ARGS.LOC_COLOURS.mint,
  unlocked = true, 
  discovered = true,
  config = {
    extra = {
      plus_mult = 2, --values need to be changed manually in stigmata file as well
      numerator_in = 1,
      denominator_in = 5
    }
  },
  
  loc_vars = function (self, info_queue, card)
    local numerator_out, denominator_out = SMODS.get_probability_vars(card, card.ability.seal.extra.numerator_in, card.ability.seal.extra.denominator_in)
    return { 
      vars = {
        denominator_out,
        card.ability.seal.extra.plus_mult
      }
    }
  end,

  calculate = function(self, card, context)
    if context.before then
      if SMODS.pseudorandom_probability(card, 'atom', #context.scoring_hand, card.ability.seal.extra.denominator_in) then
        level_up_hand(card, context.scoring_name, false, 0, nil, card.ability.seal.extra.plus_mult)
      end
    end
  end
}