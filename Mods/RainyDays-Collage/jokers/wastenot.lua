SMODS.Joker {
  key = 'waste_not',
  name = 'Waste Not',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true, 
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = GetJokersAtlasTable('waste_not'),
  config = {
    extra = {
      minus_chips = 3,
      count_cards_to_discard = 0,
      chips_taken = 0
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = { card.ability.extra.minus_chips }
    } 
  end,
  
  calculate = function(self, card, context)
    if context.pre_discard then
      card.ability.extra.count_cards_to_discard = #G.hand.highlighted --amount of cards to be discarded, count this down after each card eval.
      card.ability.extra.chips_taken = 0
    end
    
    if context.discard and #G.hand.cards > #G.hand.highlighted then
      local mes = nil
      local extra_mes = nil
      
      --taking
      local amount_to_take = math.min(card.ability.extra.minus_chips, context.other_card:get_chip_bonus()) --find the maximum amount of chips when can remove
      if amount_to_take > 0 and not context.other_card.debuff then --check if chips can be taken and if there are cards remaining in hand to give them to
        context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) - amount_to_take
        card.ability.extra.chips_taken = card.ability.extra.chips_taken + amount_to_take
        mes = {
          card = context.other_card,
          message = localize{ type = 'variable', key = 'a_chips_minus', vars = { amount_to_take }},
          colour = G.C.CHIPS
        }
      end
      
      --giving
      card.ability.extra.count_cards_to_discard = card.ability.extra.count_cards_to_discard - 1
      if card.ability.extra.count_cards_to_discard == 0 then --all cards have been discarded
        --find all cards remaing in hand and pick one at random, then give the taken chips to it
        local remaining_cards = {}
        for i = 1, #G.hand.cards do
          if not check_card_in_hand(G.hand.cards[i], G.hand.highlighted) then
            remaining_cards[#remaining_cards + 1] = G.hand.cards[i] 
          end
        end
        
        if #remaining_cards > 0 then
          local recieving_card = pseudorandom_element(remaining_cards, pseudoseed('WasteNot' .. G.GAME.round_scores.cards_discarded.amt))
          recieving_card.ability.perma_bonus = (recieving_card.ability.perma_bonus or 0) + card.ability.extra.chips_taken
          extra_mes = {
            card = recieving_card,
            message = localize('k_upgrade_ex'),
            colour = G.C.CHIPS
          }
        end
      end
      
      --message
      if mes then
        mes.extra = extra_mes
        return mes
      else
        return extra_mes
      end
    end
  end
}

--lets make it so that if stone or bonus cards transform into something else, their score doesn't become negative.
local old_func_set_ability = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
  --run the old function
  local ret = old_func_set_ability(self, center, initial, delay_sprites)
  
  --so that we don't target non-playing cards
  if not self.base then
    return ret
  end
  
  --disable debuffs so we can use get_chip_bonus properly
  local card_debuffed = self.debuff
  self.debuff = false;
  
  --prevent the chip_score from being negative
  local after_chip_score = self:get_chip_bonus()
  if after_chip_score < 0 then
    self.ability.perma_bonus = (self.ability.perma_bonus or 0) - after_chip_score
  end
  
  --set debuff back to previous state
  self.debuff = card_debuffed;

  --old function doesn't have a return value, put lets make sure for other mods/future changes.
  return ret
end