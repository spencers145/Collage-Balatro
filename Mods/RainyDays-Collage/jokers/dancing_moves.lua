SMODS.Joker {
  key = 'dancing_moves',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true, 
  in_pool = function(self, args) --only appears if player has at least one wild card in deck.
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_wild') then
          return true
        end
      end
    end
    return false
  end,
  pos = RainyDays.GetJokersAtlasTable('dancing_moves'),
  config = {
    extra = {
      repetitions = 1
    }
  },
    
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
  end,
  
  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      for i = 1, #context.full_hand do
        if SMODS.has_enhancement(context.full_hand[i], 'm_wild') then
          return {
            repetitions = card.ability.extra.repetitions
          }
        end
      end
    end
  end
}