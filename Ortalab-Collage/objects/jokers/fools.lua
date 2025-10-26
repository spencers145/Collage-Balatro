SMODS.Joker({
    key = "fools",
    atlas = "jokers",
    pos = {x = 3, y = 14},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {gain = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "extra_value",
                scalar_table = card.ability.extra,
                scalar_value = "gain",
                operation = function(ref_table, ref_value, initial, scaling)
                    ref_table[ref_value] = initial + (#G.jokers.cards - 1) * scaling
                end
            })
            card:set_cost() 
            juice_card(card)
        end
    end    
})