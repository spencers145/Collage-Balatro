local nature_tapes = {
    object_type = "Joker",
    order = 71,

    key = "nature_tapes",
    config = {
      extra = {
          cur_mult = 0,
          --mult_mod = 5
      }
    },
    rarity = 2,
    pos = { x = 17, y = 2 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.cur_mult,
            }
        }
    end,
  
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.ability.set == 'Planet' then
                local hand = context.consumeable.ability.consumeable.hand_type
                SMODS.scale_card(card, {
	                ref_table = card.ability.extra,
                    ref_value = "cur_mult",
	                scalar_table = G.GAME.hands[hand],
                    scalar_value = "l_mult",
                    operation = '+',
                    scaling_message = {
	                    message = localize('k_upgrade_ex'), 
                        colour = G.C.FILTER
                    }
                })
            end
        end
        if context.joker_main then
            if to_big(card.ability.extra.cur_mult) > to_big(0) then
                return {
                    mult = card.ability.extra.cur_mult
                }
            end
        end
    end
  
}
return { name = {"Jokers"}, items = {nature_tapes} }
