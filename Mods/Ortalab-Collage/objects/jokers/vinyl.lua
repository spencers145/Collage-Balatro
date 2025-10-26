SMODS.Joker({
	key = "vinyl",
	atlas = "jokers",
	pos = {x = 5, y = 10},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1, gain = 0.5}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain}}
    end,
	calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card == context.scoring_hand[#context.scoring_hand] then
            local prior_ranks = {}
            for i=1, #context.scoring_hand do
                if context.scoring_hand[i].base.id ~= context.other_card.base.id and not SMODS.has_no_rank(context.other_card) then
                    prior_ranks[context.scoring_hand[i].base.id] = true
                end
            end
            return {
                xmult = card.ability.extra.xmult + (card.ability.extra.gain * table.size(prior_ranks))
            }
        end
    end
})