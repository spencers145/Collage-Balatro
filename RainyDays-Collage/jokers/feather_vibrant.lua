return

SMODS.Joker {
  key = 'feather_vibrant',
  name = 'Vibrant Feather',
  atlas = 'Jokers',
  pools = { Feather = true },
  rarity = 1,
  cost = 5,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('feather_vibrant'),
  config = {
    extra = {
      plus_chips = 30
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.plus_chips, 
        card.ability.extra.plus_chips * kcv_common_joker_count()
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      local feather_count = kcv_common_joker_count()
      return {
        chip_mod = feather_count * card.ability.extra.plus_chips,
        message = localize {
          type = 'variable',
          key = 'a_chips',
          vars = { feather_count * card.ability.extra.plus_chips }
        },
        colour = G.C.CHIPS,
      }
    end
  end
}