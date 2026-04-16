SMODS.Joker {
  key = 'count_orlok',
  atlas = 'Jokers',
  rarity = 2,
  cost = 7,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('count_orlok'),
  
  config = {
    extra = {
      face_cards = 3,
      xmult = 1,
      xmult_gain = 0.2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.face_cards,
        card.ability.extra.xmult_gain,
        card.ability.extra.xmult
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.xmult > 1 then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    
    if context.before and context.main_eval and not context.blueprint then
      card.ability.extra.card_to_destroy = nil
      local face_cards = {}
      for i = 1, #context.full_hand do
        if context.full_hand[i]:is_face() then
          face_cards[#face_cards + 1] = context.full_hand[i]
        end
      end
      
      if #face_cards >= card.ability.extra.face_cards then
        card.ability.extra.card_to_destroy = pseudorandom_element(face_cards, pseudoseed('orlok'))
        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
    end
    
    if card.ability.extra.card_to_destroy and context.destroy_card == card.ability.extra.card_to_destroy and context.cardarea == G.play and not context.blueprint then
      card.ability.extra.card_to_destroy = nil
      return {
        remove = true
      }
    end
  end
}