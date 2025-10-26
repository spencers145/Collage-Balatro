SMODS.Joker({
    key = "driver",
    atlas = "jokers",
    pos = {x = 4, y = 4},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {chips = 12}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
	calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_numbered() then
            local prior_ranks = {}
            local chip_mod = 0
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i] == context.other_card then
                    chip_mod = table.size(prior_ranks)
                elseif context.scoring_hand[i].base.id ~= context.other_card.base.id then
                    prior_ranks[context.scoring_hand[i].base.id] = true
                end
            end
            if chip_mod > 0 then
                return {
                    chips = card.ability.extra.chips * chip_mod,
                    card = card
                }
            end
        end
    end  
})