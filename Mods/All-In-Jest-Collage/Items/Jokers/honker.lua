local honker = {
    object_type = "Joker",
    order = 134,

    key = "honker",
    config = {
      extra = {
          xmult_mod = 0.05,
          cur_xmult = 1
      }
    },
    rarity = 2,
    pos = { x = 3, y = 5 },
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_mod,
                card.ability.extra.cur_xmult,
            }
        }
    end,
  
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card).m_mult then
                return {
                    func = function ()
                        SMODS.scale_card(card, {
                            ref_table = card.ability.extra,
                            ref_value = "cur_xmult",
                            scalar_value = "xmult_mod",
                            operation = '+',
                            scaling_message = {
                                message = localize('k_upgrade_ex'), 
                                colour = G.C.FILTER
                            }
                        })
                    end
                }
            end
        end
        if context.joker_main then
            if card.ability.extra.cur_xmult > 0 then
                return {
                    xmult = card.ability.extra.cur_xmult
                }
            end
        end
    end,

    in_pool = function(self, args)
        if G.deck then
            if #G.deck.cards > 0 then
                for i = 1, #G.deck.cards do
                    if SMODS.get_enhancements(G.deck.cards[i]).m_mult then
                        return true
                    end
                end
            end
        end
        return false
    end,
  
}
return { name = {"Jokers"}, items = {honker} }
