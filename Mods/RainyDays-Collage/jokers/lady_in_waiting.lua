SMODS.Joker {
  key = 'lady_in_waiting',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('lady_in_waiting'),
  
  config = {
    extra = {
      rank = 'Queen',
      chip_bonus = 1
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(card.ability.extra.rank, 'ranks'),
        card.ability.extra.chip_bonus
      }
    }
  end,
  
  calculate = function(self, card, context)    
    if context.rd_draw_individual and G.GAME.facing_blind and context.other_card:get_id() == RainyDays.balatro_ranks_to_id[card.ability.extra.rank] then
      if G.playing_cards and not context.other_card.debuff then
        for _, playing_card in ipairs(G.playing_cards) do
          playing_card.ability.perma_bonus = (playing_card.ability.perma_bonus or 0) + card.ability.extra.chip_bonus
        end
      end
      
      return {
        message_card = context.other_card,
        message = localize('k_upgrade_ex'),
        colour = G.C.CHIPS
      }
    end
  end,
  
  locked_loc_vars = function(self, info_queue, card)
    local count = 0
    if G.playing_cards then
      for i = 1, #G.playing_cards do
        if G.playing_cards[i]:get_id() == RainyDays.balatro_ranks_to_id['Queen'] then
          count = count + 1
        end
      end
    else
      count = 4
    end
    
    return {
      main_end = not self.unlocked and RainyDays.generate_main_end_counter(count) or nil,
      vars = { 
        12,
        localize('Queen', 'ranks')
      }
    }
  end,
  
  check_for_unlock = function(self, args)
    if args.type == 'modify_deck' and G.playing_cards then
      local count = 0
      for i = 1, #G.playing_cards do
        if G.playing_cards[i]:get_id() == RainyDays.balatro_ranks_to_id['Queen'] then
          count = count + 1 
          if count >= 12 then
            return true
          end
        end
      end
    return false
    end
  end
}