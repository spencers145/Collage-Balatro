return

SMODS.Joker {
  key = 'feather_precious',
  name = 'Precious Feather',
  atlas = 'Jokers',
  pools = { Feather = true },
  rarity = 1,
  cost = 5,
  unlocked = true, 
  discovered = false,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('feather_precious'),
  config = {
    extra = {
      plus_money = 2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.plus_money, 
        card.ability.extra.plus_money * kcv_common_joker_count()
      }
    } 
  end,
  
  calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.plus_money * kcv_common_joker_count()
		if bonus > 0 then 
      return bonus 
    end
	end
}