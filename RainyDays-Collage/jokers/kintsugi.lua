SMODS.Joker {
  key = 'kintsugi',
  name = 'Kintsugi',
  atlas = 'Jokers',
  rarity = 2,
  cost = 5,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  in_pool = function(self, args) --only appears if player has at least one glass card in deck.
    for i = 1, #G.playing_cards do
      if SMODS.has_enhancement(G.playing_cards[i], 'm_glass') then
        return true
      end
    end
    return false
  end,
  
  draw = function(self, card, layer)
    if card.config.center.discovered or card.bypass_discovery_center then
      card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
    end
  end,
    
  pos = GetJokersAtlasTable('kintsugi'),
  soul_pos = GetJokersAtlasTable('kintsugi_vase'),
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    info_queue[#info_queue + 1] = {key = 'gold_seal', set = 'Other'}
  end,

  calculate = function(self, card, context)
    if context.remove_playing_cards then
      --create the cards and apply the gold seals.
      local copies = {}
      for i = 1, #context.removed do
        if SMODS.has_enhancement(context.removed[i], 'm_glass') then
          local copy = copy_card(context.removed[i], nil, nil, G.playing_card) --create copy of glass card
          copy:set_seal('Gold', true) --add seal to copy
          copy.states.visible = nil
          table.insert(G.playing_cards, copy)
          copies[#copies + 1] = copy
        end
      end
      
      if #copies > 0 then
        G.E_MANAGER:add_event(Event({
          blocking = false,
          func = function() 
            if #G.play.cards > 0 then
              return false
            end
            
            for i = 1, #copies do
              copies[i]:start_materialize({ G.C.SECONDARY_SET.Enhanced })
              G.play:emplace(copies[i])
            end
            
            G.E_MANAGER:add_event(Event({
              trigger = "after", --delay the event by 1 unit. exact time depends on game speed.
              delay = 1,
              func = function()
                for i = 1, #copies do
                  copies[i]:add_to_deck() --handles achievements
                  draw_card(G.play, G.deck, 90, 'up', nil, copies[i]) --draw from play into the deck.
                end
                G.deck:shuffle('kintsugi'..G.GAME.round_resets.ante) --shuffle the deck
                SMODS.calculate_context({ playing_card_added = true, cards = copies }) --some jokers care about adding cards to the deck, so we let them know.
                return true
              end
            }))
            return true
          end
        }))
      end
    end
  end
}