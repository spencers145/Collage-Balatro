SMODS.Joker { --blocks
  key = 'blocks',
  rarity = 2,
  cost = 6,
  eternal_compat = true,
  perishable_compat = false,
  blueprint_compat = true,
  atlas = "T.Jokers",
  discovered = false,
  pos = { x = 2, y = 2 },
  config = { extra = { mult = 0, mult_gain = tes.config.rebalance and 1 or 2 } },
  loc_vars = function(self, info_queue, card)
    card.ability.extra.mult_gain = tes.config.rebalance and 1 or 2
    return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
  end,
  
  calculate = function (self, card, context)
    if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_played == 0 and not context.blueprint then
      card.ability.extra.mult_gain = tes.config.rebalance and 1 or 2
      local upgrade = false
      for i = 1, #context.scoring_hand do
        local scoring_card = context.scoring_hand[i]
        if scoring_card:is_face() or scoring_card:get_id() == 14 then
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
          upgrade = true
        end
      end
      
      if upgrade then
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.MULT,
          card = card
        }
      end
    end
    
    if context.cardarea == G.jokers and context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize {
          type = 'variable',
          key = 'a_mult',
          vars = { card.ability.extra.mult  }
        },
        colour = G.C.MULT,
      }
    end
  end
}