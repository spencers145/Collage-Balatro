SMODS.Joker({
	key = "frowny_face",
	atlas = "jokers",
	pos = {x = 7, y = 6},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult = 3}},
	artist_credits = {'golddisco'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
	calculate = function(self, card, context) --Frowny Face Logic
        if context.individual and context.cardarea == G.play and context.other_card:get_id() <= 10 and not SMODS.has_no_rank(context.other_card) then
            return {
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
})