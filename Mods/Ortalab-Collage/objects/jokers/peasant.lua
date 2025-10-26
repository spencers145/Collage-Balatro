SMODS.Joker({
    key = "peasant",
    atlas = "jokers",
    pos = {x = 2, y = 10},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {mult = 15}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.cardarea == G.hand and not SMODS.has_no_rank(context.other_card) then
            return {
                mult = card.ability.extra.mult - context.other_card.base.nominal
            }
        end
    end    
})



--[[
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.individual and context.scoring_hand and context.other_card:is_numbered() then
            return {
                mult = context.other_card.base.nominal
            }
        end
    end    
})]]
