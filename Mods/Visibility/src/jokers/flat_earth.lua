SMODS.Joker {
    key = "flat_earth",
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    blueprint_compat = false,
    atlas = "TextureAtlasJokers",
    pos = { x = 3, y = 6 },
    credits = {
        developer = true,
    },
    config = { extra = { mult = 3 } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.poker_hands and next(context.poker_hands['Full House']) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
