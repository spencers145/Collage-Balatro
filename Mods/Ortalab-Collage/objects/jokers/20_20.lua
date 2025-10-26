SMODS.Joker({
    key = "20_20",
    atlas = "jokers",
    pos = {x = 6, y = 9},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {reps = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.reps}}
    end,
    calculate = function(self, card, context)
        if context.before then
            local ranks = {}
            for _, _card in pairs(context.scoring_hand) do
                ranks[_card:get_id()] = ranks[_card:get_id()] or not SMODS.has_no_rank(_card) or nil
            end
            if table.size(ranks) > 1 then
                card.ability.extra.active = true
            else
                card.ability.extra.active = false
            end
        end
        if context.repetition and context.cardarea == G.play and card.ability.extra.active then
            return {
                repetitions = card.ability.extra.reps
            }
        end
    end    
})