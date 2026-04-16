SMODS.Joker {
  key = 'catalogue',
  atlas = 'Jokers',
  rarity = 2,
  cost = 5,
  unlocked = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('catalogue'),
  config = {
    extra = {
      numerator_in = 1,
      denominator_in = 2
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local numerator_out, denominator_out = SMODS.get_probability_vars(card, card.ability.extra.numerator_in, card.ability.extra.denominator_in)
    return {
      vars = {
        numerator_out, 
        denominator_out
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.discard and not SMODS.has_no_rank(context.other_card) then
      if SMODS.pseudorandom_probability(card, 'catalogue', card.ability.extra.numerator_in, card.ability.extra.denominator_in) then
        local ranks = { 'Ace', 'King', 'Queen', 'Jack', '10', '9', '8', '7', '6', '5', '4', '3', '2' }
        RainyDays.remove_by_value(ranks, context.other_card.base.value)
        local new_rank = pseudorandom_element(ranks, pseudoseed('catalogue'))
        context.other_card.rainydays_hide_rank_change = true
        SMODS.change_base(context.other_card, nil, new_rank)
        context.other_card.rainydays_hide_rank_change = nil
        G.GAME.blind:debuff_card(context.other_card)
        
        G.E_MANAGER:add_event(Event({
          func = function()
            context.other_card:set_sprites(nil, context.other_card.config.card)
            context.other_card:juice_up()
            return true
          end
        }))
        
        return {
          extra = {
            message_card = card,
            message = localize('rainydays_new_rank'),
            colour = G.C.FILTER
          }
        }
      end
    end
  end
}