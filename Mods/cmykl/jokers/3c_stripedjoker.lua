SMODS.Joker{ --Striped Joker
    key = "stripedjoker",
    config = {
        extra = {
            Xmult = 3
        }
    },
    loc_txt = {
        ['name'] = 'Striped Joker',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult if the scoring',
            [2] = 'cards\' {C:attention}ranks{} are {C:attention}alternating{}',
            [3] = '{C:inactive}(ex: 7, 5, 7, 5, 7){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    calculate = function(self, card, context)
    local hand = context.scoring_hand
    if context.cardarea == G.play then
        if #context.scoring_hand == 5 then
            local card1 = hand[1]:get_id()
            local card3 = hand[3]:get_id()
            local card5 = hand[5]:get_id()
            local card2 = hand[2]:get_id()
            local card4 = hand[4]:get_id()

            matcher = (card1 == card3 and card1 == card5 and card2 == card4 and card1 ~= card2)

        elseif #context.scoring_hand == 4 then
            local card1 = hand[1]:get_id()
            local card3 = hand[3]:get_id()
            local card2 = hand[2]:get_id()
            local card4 = hand[4]:get_id()

            matcher = (card1 == card3 and card2 == card4 and card1 ~= card2)
        end  
    end
    if matcher and context.joker_main then
            return {
                    Xmult = 3
                }
        end
end
}