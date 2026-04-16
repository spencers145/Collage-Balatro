SMODS.Joker {
  key = 'purple_card',
  atlas = 'Jokers',
  rarity = 1,
  cost = 4,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('purple_card'),
  
  calculate = function(self, card, context)      
    if context.skipping_booster then
      return RainyDays.create_consumable(context.blueprint_card or card, RainyDays.Constellations and 'CN_Constellation' or 'Tarot')
    end
  end
}