SMODS.Joker({
	key = "scared_face",
	atlas = "jokers",
	pos = {x = 1, y = 2},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {chips = 30}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context) --Scared Face Logic
        if context.individual and context.cardarea == G.play and context.other_card:get_id() <= 5 and not SMODS.has_no_rank(context.other_card) then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end    
})