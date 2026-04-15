SMODS.Joker{ --Rebellion
    key = "rebellion",
    config = {
        extra = {
            Xmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Rebellion',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.07{} Mult for',
            [2] = 'each {C:attention}face card{} discarded',
            [3] = 'resets when a',
            [4] = '{C:attention}face card{} scores',
            [5] = '{C:inactive}(Currently{} {X:red,C:white}X#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = ''
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    Xmult = card.ability.extra.Xmult
                }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.Xmult = 1
                return {
                    message = "Silenced!"
                }
            end
        end
        if context.discard  then
            if (function()
    local rankFound = false
    for i, c in ipairs(context.full_hand) do
        if c:is_face() then
            if context.other_card:is_face() and not context.blueprint then rankFound = true end
            break
        end
    end
    
    return rankFound
end)() then
                return {
                    func = function()
                    card.ability.extra.Xmult = (card.ability.extra.Xmult) + 0.07
                    return true
                end
                }
            end
        end
    end
}