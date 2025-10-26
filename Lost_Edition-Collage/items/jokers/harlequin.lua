local jokerInfo = {
discovered = false,
    key = "harlequin",
    pos = LOSTEDMOD.funcs.coordinate(25),
    atlas = 'losted_jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    blueprint_compat = true,
    config = { extra = { chips = 40 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)  
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}

return jokerInfo
