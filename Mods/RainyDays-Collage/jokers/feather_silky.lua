return

SMODS.Joker {
  key = 'feather_silky',
  name = 'Silky Feather',
  atlas = 'Jokers',
  pools = { Feather = true },
  rarity = 1,
  cost = 4,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('feather_silky'),
  config = {
    extra = {
      plus_mult = 4
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.plus_mult, 
        card.ability.extra.plus_mult * kcv_common_joker_count()
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      local feather_count = kcv_common_joker_count()
      return {
        mult_mod = feather_count * card.ability.extra.plus_mult,
        message = localize {
          type = 'variable',
          key = 'a_mult',
          vars = { feather_count * card.ability.extra.plus_mult }
        },
        colour = G.C.MULT,
      }
    end
  end
}