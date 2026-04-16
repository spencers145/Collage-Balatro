SMODS.Joker {
  key = 'heirloom',
  atlas = 'Jokers',
  rarity = 2,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  in_pool = function(self, args) --only appears if player has at least one bonus or mult card in deck.
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_bonus') or SMODS.has_enhancement(G.playing_cards[i], 'm_mult') then
          return true
        end
      end
    end
    return false
  end,
  pos = RainyDays.GetJokersAtlasTable('heirloom'),
  
  config = {
    extra = {
      numerator_in = 1,
      denominator_in = 4
    }
  },
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    local numerator_out, denominator_out = SMODS.get_probability_vars(card, card.ability.extra.numerator_in, card.ability.extra.denominator_in)
    return {
      vars = {
        numerator_out,
        denominator_out
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.before then
      local possible_bonus = {}
      local possible_mult = {}
      for i = 1, #context.full_hand do
        if context.full_hand[i - 1] then
          if SMODS.has_enhancement(context.full_hand[i - 1], 'm_bonus') then
            possible_bonus[context.full_hand[i].ID] = true
          end
          if SMODS.has_enhancement(context.full_hand[i - 1], 'm_mult') then
            possible_mult[context.full_hand[i].ID] = true
          end
        end
        
        if context.full_hand[i + 1] then
          if SMODS.has_enhancement(context.full_hand[i + 1], 'm_bonus') then
            possible_bonus[context.full_hand[i].ID] = true
          end
          if SMODS.has_enhancement(context.full_hand[i + 1], 'm_mult') then
            possible_mult[context.full_hand[i].ID] = true
          end
        end
      end
      
      local enhanced
      for i = 1, #context.full_hand do
        if possible_bonus[context.full_hand[i].ID] or possible_mult[context.full_hand[i].ID] then
          if SMODS.pseudorandom_probability(card, 'heirloom', card.ability.extra.numerator_in, card.ability.extra.denominator_in) then
            local enhancement
            if possible_bonus[context.full_hand[i].ID] then
              if possible_mult[context.full_hand[i].ID] then
                enhancement = pseudorandom_element({ 'm_bonus', 'm_mult' }, pseudoseed('heirloom' .. G.GAME.round_resets.ante))
              else
                enhancement = 'm_bonus'
              end
            else
              enhancement = 'm_mult'
            end
            context.full_hand[i]:set_ability(enhancement, nil, true)
            enhanced = true
          end
        end
      end
      
      if enhanced then
        return {
          message_card = card,
          message = localize('rainydays_enhanced'),
          colour = G.C.FILTER
        }
      end
    end
  end
}