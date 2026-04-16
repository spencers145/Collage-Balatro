SMODS.Joker {
  key = 'goldfish',
  atlas = 'Jokers',
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('goldfish'),
  
  config = {
    extra = {
      money_bonus = 2,
      poker_hand = 'Pair'
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.money_bonus,
        localize(card.ability.extra.poker_hand, 'poker_hands')
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main and not next(context.poker_hands[card.ability.extra.poker_hand]) then
      return {
        dollars = card.ability.extra.money_bonus
      }
    end
  end
}