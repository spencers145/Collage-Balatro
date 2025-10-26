local jokerInfo = {
discovered = false,
    key = "jimbo_hood",
    pos = LOSTEDMOD.funcs.coordinate(70),
    soul_pos = LOSTEDMOD.funcs.coordinate(80),
    atlas = 'losted_jokers',
    rarity = 4,
    cost = 20,
    unlocked = false,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.destroying_card and (context.destroying_card:get_id() == 12 or context.destroying_card:get_id() == 13) then
            return {
                remove = true,
                dollars = 25
            }
        end
    end,
    in_pool = function(self)
        return true
    end
}

return jokerInfo