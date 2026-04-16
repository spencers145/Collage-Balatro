SMODS.Joker {
  key = 'serial',
  atlas = 'Jokers',
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('serial'),
  config = {
    extra = {
      chips = 40,
      first_suits = {}
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.chips
      }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      for key in pairs(card.ability.extra.first_suits) do
        card.ability.extra.first_suits[key] = nil
      end
      local suits_used = {}
      
      local count = 0
      for i = 1, #context.scoring_hand do
        if not SMODS.has_no_suit(context.scoring_hand[i]) and not context.scoring_hand[i].debuff then
          if SMODS.has_any_suit(context.scoring_hand[i]) then
            card.ability.extra.first_suits[context.scoring_hand[i].ID] = true
            count = count + 1
          else
            for key in pairs(SMODS.Suits) do
              if context.scoring_hand[i]:is_suit(key) and not suits_used[key] then
                suits_used[key] = true
                card.ability.extra.first_suits[context.scoring_hand[i].ID] = true
                count = count + 1
                break
              end
            end
          end
          
          if count >= G.GAME.rd_suit_count then
            break
          end
        end
      end
    end

    if context.individual and context.cardarea == G.play and card.ability.extra.first_suits[context.other_card.ID] then
      return {
        chips = card.ability.extra.chips
      }
    end
    
    if context.after and not context.blueprint then
      for key in pairs(card.ability.extra.first_suits) do
        card.ability.extra.first_suits[key] = nil
      end
    end
  end
}