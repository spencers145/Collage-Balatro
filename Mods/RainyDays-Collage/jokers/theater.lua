SMODS.Joker {
  key = 'theater',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('theater'),
  
  config = {
    sort = false,
    extra = {
      mult = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult
      }
    }
  end,
  
  calculate = function(self, card, context)
     if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_face() then
      if context.other_card.debuff then
        return {
          message = localize('k_debuffed'),
          colour = G.C.RED
        }
      else
        return {
          mult = card.ability.extra.mult
        }
      end
    end
    
    if context.before and not context.blueprint then
      G.GAME.theater_drawn_cards = G.GAME.theater_drawn_cards or {}
      local amount = math.min(#G.deck.cards, G.hand.config.card_limit - #G.hand.cards)
      if amount > 0 then
        for i = 1, amount do
          local card_drawn = G.deck.cards[i]
          G.hand.cards[#G.hand.cards + 1] = card_drawn
          G.GAME.theater_drawn_cards[card_drawn.ID] = true
          draw_card(G.deck, G.hand, i * 100 / amount, 'up', false, card_drawn)
        end
        
        SMODS.calculate_context({ hand_drawn = SMODS.drawn_cards })
        SMODS.drawn_cards = nil
      end
    end
    
    if context.after and G.GAME.theater_drawn_cards and not context.blueprint then
      for i = #G.hand.cards, 1, -1 do
        local card_in_hand = G.hand.cards[i]
        if G.GAME.theater_drawn_cards[card_in_hand.ID] then
          table.remove(G.hand.cards, i)
          G.GAME.theater_drawn_cards[card_in_hand.ID] = nil
        end
      end
      G.GAME.theater_drawn_cards = nil
      
      G.E_MANAGER:add_event(Event({
        func = function()
          G.hand:sort()
          return true
        end
      }))
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    return { vars = { 5 }}
  end,  
  
  check_for_unlock = function(self, args)
    if args.type == 'round_win' then
      local count = 0
      for i = 1, #G.hand.cards do
        if G.hand.cards[i]:is_face() then
          count = count + 1
          if count >= 5 then
            return true
          end
        end
      end
    end
    return false
  end
}