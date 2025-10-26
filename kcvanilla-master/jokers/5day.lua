SMODS.Joker {
    key = "5day",
    atlas = 'kcvanillajokeratlas',
    pos = {
        x = 0,
        y = kcv_getJokerAtlasIndex('5day')
    },
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and context.cardarea == G.play then
            if next(context.poker_hands["Straight"]) then
                local rank = context.other_card:get_id()
                if rank == 6 or rank == 7 or rank == 8 or rank == 9 or rank == 10 then
                    return {
                        xmult = 1.3,
                        card = card
                    }
                end
            end
        end
    end
}
