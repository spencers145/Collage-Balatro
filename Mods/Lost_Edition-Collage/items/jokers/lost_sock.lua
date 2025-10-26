local jokerInfo = {
discovered = false,
    key = 'lost_sock',
    pos = LOSTEDMOD.funcs.coordinate(3),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = { extra = { mult_gain = 2, mult = 0, size = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.size, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and #context.full_hand <= card.ability.extra.size then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

return jokerInfo
