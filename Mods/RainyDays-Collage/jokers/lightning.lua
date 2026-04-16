SMODS.Joker {
  key = 'lightning',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  in_pool = function(self, args) --only appears if player has at least one mult card in deck.
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_mult') then
          return true
        end
      end
    end
    return false
  end,
  pos = RainyDays.GetJokersAtlasTable('lightning'),
  
  config = {
    extra = {
      mult = 12
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    return {
      vars = {
        card.ability.extra.mult,
        G.P_CENTERS.m_mult.config.mult
      }
    }
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.GAME.rd_block_mult = (G.GAME.rd_block_mult or 0) + 1
  end,
  
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.rd_block_mult = (G.GAME.rd_block_mult or 0) - 1
  end,
  
  calculate = function(self, card, context)    
    if context.individual and context.cardarea == G.play then
      if SMODS.has_enhancement(context.other_card, 'm_mult') then
        return {
          mult = card.ability.extra.mult
        }
      end
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_mult') then
          count = count + 1
        end
      end
    end
    
    return { 
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        5
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' and G.playing_cards then
      local count = 0
      for i = 1, #G.playing_cards do
        if SMODS.has_enhancement(G.playing_cards[i], 'm_mult') then
          count = count + 1 
          if count >= 5 then
            return true
          end
        end
      end
    return false
    end
  end
}

local get_chip_mult_ref = Card.get_chip_mult
function Card.get_chip_mult(self)
  local mult_amount = get_chip_mult_ref(self)
  if SMODS.has_enhancement(self, 'm_mult') and G.GAME.rd_block_mult and G.GAME.rd_block_mult > 0 then
    mult_amount = mult_amount - G.P_CENTERS.m_mult.config.mult
  end
  return mult_amount
end