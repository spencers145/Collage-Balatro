SMODS.Joker {
  key = 'bazaar',
  atlas = 'Jokers',
  rarity = 3,
  cost = 8,
  unlocked = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('bazaar'),
  config = {
    extra = {
      hand_size = 3,
      card_count = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { 
        card.ability.extra.hand_size,
        card.ability.extra.card_count
      }
    }
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.hand_size)
    G.GAME.rd_bazaar = (G.GAME.rd_bazaar or 0) + 1
    G.GAME.rd_bazaar_cards = card.ability.extra.card_count
  end,
  
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.hand_size)
    G.GAME.rd_bazaar = (G.GAME.rd_bazaar or 0) - 1
    G.GAME.rd_bazaar_cards = card.ability.extra.card_count
  end,
  
  calculate = function(self, card, context)
    if context.debuff_hand and #context.scoring_hand < card.ability.extra.card_count and not context.blueprint then 
      return {
        debuff = true,
        debuff_text = localize('rainydays_must_play_hand_with_5_scoring_cards'),
        message_card = (not context.check) and card or nil,
        message = (not context.check) and localize('rainydays_denied') or nil,
        colour = G.C.FILTER
      }
    end
  end
}