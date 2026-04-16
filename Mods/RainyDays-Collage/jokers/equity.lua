SMODS.Joker {
  key = 'equity',
  atlas = 'Jokers',
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('equity'),
  pixel_size = { w = 71, h = 94 },
  
  config = {
    extra = {
      mult = 15,
      poker_hand = 'Pair'
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult,
        localize(card.ability.extra.poker_hand, 'poker_hands')
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      local _, _, pokerhands = G.FUNCS.get_poker_hand_info(G.hand.cards)
      if not next(pokerhands[card.ability.extra.poker_hand]) then
        return {
          mult = card.ability.extra.mult
        }
      end
    end
  end
}