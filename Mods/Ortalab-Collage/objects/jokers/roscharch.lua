SMODS.Joker({
	key = "roscharch",
    atlas = "jokers",
	pos = {x = 6, y = 6},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 25, mult = 5}},
    artist_credits = {'flare'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.mult}}
    end,
    calculate = function(self, card, context) --Roscharch Logic
        if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 5 or context.other_card:get_id() == 2) then
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
})