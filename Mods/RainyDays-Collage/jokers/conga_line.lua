SMODS.Joker {
  key = 'conga_line',
  atlas = 'Jokers',
  rarity = 2,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('conga_line'),
  config = {
    extra = {
      repetitions = 1
    }
  },
  
  calculate = function (self, card, context)
    if context.repetition and context.cardarea == G.play and RainyDays.Is_odd(context.other_card) then
      return {
        repetitions = card.ability.extra.repetitions
      }
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if RainyDays.Is_odd(G.playing_cards[i]) then
          count = count + 1
        end
      end
    else
      count = 20
    end
    
    return {
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        30
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' and G.playing_cards then
      local count = 0
      for i = 1, #G.playing_cards do
        if RainyDays.Is_odd(G.playing_cards[i]) then
          count = count + 1 
          if count >= 30 then
            return true
          end
        end
      end
    return false
    end
  end
}