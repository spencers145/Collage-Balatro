SMODS.Joker {
  key = 'bonsai',
  atlas = 'Jokers',
  rarity = 1,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('bonsai'),
  
  config = {
    extra = {
      mult = 3,
      cards = 2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local amount = 0
    if G.deck and G.deck.cards then
      for i = 1, #G.deck.cards do
        if G.deck.cards[i]:is_suit('Clubs') then
          amount = amount + 1
        end
      end
    else
      amount = 13
    end
    
    return {
      vars = {
        card.ability.extra.mult,
        card.ability.extra.cards,
        card.ability.extra.mult * math.floor(amount / card.ability.extra.cards)
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      local amount = 0
      for i = 1, #G.deck.cards do
        if G.deck.cards[i]:is_suit('Clubs') then
          amount = amount + 1
        end
      end
      return {
        mult = card.ability.extra.mult * math.floor(amount / card.ability.extra.cards)
      }
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.playing_cards then
      for _, playing_card in ipairs(G.playing_cards or {}) do
        if playing_card:is_suit('Clubs') then
          count = count + 1
        end
      end
    else
      count = 13
    end
    
    return { 
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        5
      }
    }
  end,  
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' and G.GAME and G.GAME.RD_init_complete then
      local count = 0      
      for _, playing_card in ipairs(G.playing_cards or {}) do
        if playing_card:is_suit('Clubs', true) then
          count = count + 1
          if count > 5 then
            return false
          end
        else
        end
      end
      return true
    end
  end
}