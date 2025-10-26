SMODS.Joker { --waterfall
  key = 'waterfall',
  rarity = 3,
  atlas = 'T.Jokers',
  pos = { x = 1, y = 1 },
  cost = 8,
  discovered = false,
  perishable_compat = false,
  eternal_compat = true,
  blueprint_compat = true,
  config = { extra = { d_size = 1, chips = 0, chips_mod = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.d_size, card.ability.extra.chips_mod, card.ability.extra.chips } }
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
  end,
  
  -- Inverse of above function.
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
  end,
  
  calculate = function(self, card, context)
    if context.discard and not context.blueprint and not context.other_card.debuff then 
      if context.other_card:get_id() == 3 or context.other_card:get_id() == 6 then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
        return {
          message = localize('k_upgrade_ex'),
          colour = G.C.CHIPS,
          message_card = card
        }
      end
    end
    
    if context.cardarea == G.jokers and context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize {
          type = 'variable',
          key = 'a_chips',
          vars = { card.ability.extra.chips }
        },
        colour = G.C.CHIPS,
      }
    end
  end

}