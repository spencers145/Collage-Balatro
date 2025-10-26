SMODS.Joker({
	key = "scratch_card",
	atlas = "jokers",
	pos = {x = 8, y = 2},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chance = 3, money = 2}},
    artist_credits = {'kosze','salad','gappie'},
	loc_vars = function(self, info_queue, card)
        local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return {vars = {a, b, card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_numbered() and not context.other_card.config.center.always_scores then
            if SMODS.pseudorandom_probability(card, 'ortalab_scratchcard', 1, card.ability.extra.chance) then
                return {
                    dollars = card.ability.extra.money,
                    card = card
                }
            end
        end
    end
})