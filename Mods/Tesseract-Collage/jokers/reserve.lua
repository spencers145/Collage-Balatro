SMODS.Joker {
  key = 'reserve',
  pixel_size = { w = 52, h = 82 },
  cost = 7,
  rarity = 2,
  discovered = false,
  atlas = 'T.Jokers',
  pos = { x = 3, y = 2 },
  config = { extra = { xmult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.xmult } }
  end,
  eternal_compat = true,
  perishable_compat = true,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.other_joker then 
      if context.other_joker.config.center.rarity == 3 or context.other_joker.config.center.rarity == "Rare" then
        G.E_MANAGER:add_event(Event({
            func = function()
                context.other_joker:juice_up(0.5, 0.5)
                return true
            end
        })) 
        return {
            message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
            Xmult_mod = card.ability.extra.xmult
        }
      end
    end
  end
}
