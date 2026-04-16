SMODS.Joker {
  key = 'golden_idol',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  in_pool = function(self, args) --only appears if player has at least one gold card in deck.
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_gold') then
          return true
        end
      end
    end
    return false
  end,
  pos = RainyDays.GetJokersAtlasTable('golden_idol'),
  
  config = {
    extra = {
      x_mult = 1,
      plus_xmult = 0.1
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    return {
      vars = {
        card.ability.extra.plus_xmult,
        card.ability.extra.x_mult
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main and card.ability.extra.x_mult > 1 then
      return {
        xmult = card.ability.extra.x_mult
      }
    end
    
     if context.rd_draw_individual and G.GAME.facing_blind and not context.blueprint then
      if SMODS.has_enhancement(context.other_card, 'm_gold') then
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.plus_xmult
        return {
          message_card = card,
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT
        }
      end
    end
  end
}