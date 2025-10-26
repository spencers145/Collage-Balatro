SMODS.Joker({
    key = "actor",
    atlas = "jokers",
    pos = {x = 1, y = 15},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {xmult = 1, gain = 1}},
    artist_credits = {'crimson'},
    loc_vars = function(self, info_queue, card)
        local handsize = G.hand and G.hand.config.card_limit - count_negatives(G.hand.cards) or G.GAME.starting_params.hand_size
        return {vars = {card.ability.extra.gain, card.ability.extra.xmult + (math.abs(G.GAME.starting_params.hand_size - handsize) * card.ability.extra.gain), G.GAME.starting_params.hand_size}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local handsize = G.hand.config.card_limit - count_negatives(G.hand.cards)
            return {
                xmult = card.ability.extra.xmult + (math.abs(G.GAME.starting_params.hand_size - handsize) * card.ability.extra.gain)
            }
        end
    end    
})

function count_negatives(table)
    local extra = 0
    for _, card in pairs(table) do
        if card.edition and card.edition.card_limit then
            extra = extra + card.edition.card_limit
        end
    end
    return extra
end