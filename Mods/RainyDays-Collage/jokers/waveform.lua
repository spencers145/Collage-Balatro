SMODS.Joker {
  key = 'waveform',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('waveform'),
  
  config = {
    extra = {
      numerator_in = 1,
      denominator_in = 3,
      mult_amount = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local numerator_out, denominator_out = SMODS.get_probability_vars(card, card.ability.extra.numerator_in, card.ability.extra.denominator_in)
    return {
      vars = {
        numerator_out,
        denominator_out,
        card.ability.extra.mult_amount
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.rd_is_repetition then
      return {
        mult = card.ability.extra.mult_amount
      }
    end
    
    if context.repetition and context.cardarea == G.play then
      if SMODS.pseudorandom_probability(card, 'waveform', card.ability.extra.numerator_in, card.ability.extra.denominator_in) then
        return {
          repetitions = 1
        }
      end
    end
  end
}