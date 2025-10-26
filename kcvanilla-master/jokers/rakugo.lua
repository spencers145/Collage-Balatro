SMODS.Joker {
    key = "rakugo",
    atlas = 'kcvanillajokeratlas',
    pos = {
        x = 0,
        y = kcv_getJokerAtlasIndex('rakugo')
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    calculate = function(self, card, context)
        if context.individual and context.other_card and context.cardarea == G.play then
            if next(context.poker_hands["Straight"]) then
                local rank = context.other_card:get_id()
                if rank == 2 or rank == 3 or rank == 4 or rank == 5 or rank == 6 or rank == 7 then
                    return {
                        mult = rank,
                        card = card
                    }
                end
            end
        end
    end
}
