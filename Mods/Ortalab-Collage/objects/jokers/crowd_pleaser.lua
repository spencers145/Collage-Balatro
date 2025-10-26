SMODS.Joker({
    key = "crowd_pleaser",
    atlas = "jokers",
    pos = {x = 5, y = 1},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        local pokerhands = Ortalab.pokerhands_by_played()
        local hand = pokerhands[3]
        if pokerhands[3].played == pokerhands[2].played then
            hand = pokerhands[2]
            if pokerhands[2].played == pokerhands[1].played then
                hand = pokerhands[1]
            end
        end
        return {vars = {localize(hand.key, 'poker_hands')}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            local pokerhands = Ortalab.pokerhands_by_played()
            local hand = pokerhands[3]
            if pokerhands[3].played == pokerhands[2].played then
                hand = pokerhands[2]
                if pokerhands[2].played == pokerhands[1].played then
                    hand = pokerhands[1]
                end
            end
            return {
                level_up_hand = hand.key,
                level_up = true
            }
        end
    end    
})

function Ortalab.pokerhands_by_played()
    local pokerhands = {}
    for k,v in pairs(G.GAME.hands) do
        v.key = k
        pokerhands[#pokerhands + 1] = SMODS.is_poker_hand_visible(k) and v or nil
    end
    table.sort(pokerhands, function(x, y)
        if x.played == y.played then
            return x.order < y.order
        else 
            return (x.played or 0) > (y.played or 0)
        end
    end)

    return pokerhands
end