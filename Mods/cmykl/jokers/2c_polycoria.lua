SMODS.Joker{ --Polycoria
    key = "polycoria",
    config = {
        extra = {
            Xmult = 2
        }
    },
    loc_txt = {
        ['name'] = 'Polycoria',
        ['text'] = {
            [1] = '{X:red,C:white}X2{} Mult if played',
            [2] = '{C:attention}poker hand{} has not ',
            [3] = 'been played this round'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main  then
            if not (G.GAME.hands[context.scoring_name] and G.GAME.hands[context.scoring_name].played_this_round > 1) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}   
