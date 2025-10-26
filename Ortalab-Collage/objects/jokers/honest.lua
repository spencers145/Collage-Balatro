SMODS.Joker({
	key = "honest",
	atlas = "jokers",
	pos = {x=9,y=12},
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult = 10, hand_type = 'Pair'}},
	artist_credits = {'crimson'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.mult, localize(card.ability.extra.hand_type, 'poker_hands')}}
	end,
	calculate = function(self, card, context)
        if context.joker_main and not next(context.poker_hands[card.ability.extra.hand_type]) then
            return {
                mult = card.ability.extra.mult, 
            }
        end
    end
})