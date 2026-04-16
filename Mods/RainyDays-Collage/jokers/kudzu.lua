SMODS.Joker {
  key = 'kudzu',
  atlas = 'Jokers',
  rarity = 2,
  cost = 3,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('kudzu'), 
  config = {
    extra = {
      mult_bonus = 1,
      mult_current = 0
    }
  },
  
  loc_vars = function(self, info_queue, card)  
    return {
      vars = {
        card.ability.extra.mult_bonus,
        card.ability.extra.mult_current
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main and card.ability.extra.mult_current > 0 then
      return {
        mult = card.ability.extra.mult_current
      }
    end
    
    if context.setting_blind and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function()
          if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            play_sound('timpani')
            SMODS.add_card { key = 'j_RainyDays_kudzu' }
          end
          
          local count = #SMODS.find_card('j_RainyDays_kudzu')
          if count > 0 then 
            card.ability.extra.mult_current = card.ability.extra.mult_current + count
            card_eval_status_text(card, 'jokers', nil, nil, nil, { message = localize('k_upgrade_ex'), colour = G.C.MULT })
          end
          return true
        end
      }))
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local max_count = 0
    if G.jokers and G.jokers.cards then
      for i = 1, #G.jokers.cards do
        local count = 0
        local key = G.jokers.cards[i].config.center.key
        for j = i, #G.jokers.cards do
          if G.jokers.cards[j].config.center.key == key then
            count = count + 1
          end
        end
        max_count = math.max(max_count, count)
      end
    end
    
    return {
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(max_count) or nil,
      vars = { 
        3
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_jokers' and G.jokers then
      for i = 1, #G.jokers.cards - 2 do
        local count = 0
        local key = G.jokers.cards[i].config.center.key
        for j = i, #G.jokers.cards do
          if G.jokers.cards[j].config.center.key == key then
            count = count + 1
            if count >= 3 then
              return true
            end
          end
        end
      end
      return false
    end
  end
}