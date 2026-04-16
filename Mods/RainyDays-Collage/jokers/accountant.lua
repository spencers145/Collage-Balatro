SMODS.Joker {
  key = 'accountant',
  atlas = 'Jokers',
  rarity = 1,
  cost = 5,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('accountant'),
  
  config = {
    extra = {
      mult = 0.5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult,
        card.ability.extra.mult * (G.GAME.facing_blind and G.GAME.rd_cards_drawn_this_round or 0)
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.rd_draw_individual and G.GAME.facing_blind and not context.blueprint then
      return { 
        message = localize('k_upgrade_ex'),
        colour = G.C.MULT,
        delay = 0.2
      }
    end
    
    if context.joker_main then
      return {
          mult = card.ability.extra.mult * G.GAME.rd_cards_drawn_this_round
      }
    end
    
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.rd_cards_drawn_this_round > 0 then
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end
  end,

  check_for_unlock = function(self, args)
    return args.type == 'round_win' and #G.deck.cards <= 0
  end
}