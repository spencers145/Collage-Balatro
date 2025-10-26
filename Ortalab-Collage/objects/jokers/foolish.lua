SMODS.Joker({
	key = "foolish",
	atlas = "jokers",
	pos = {x=1,y=13},
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult = 8, hand_type = 'Two Pair'}},
	artist_credits = {'crimson'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.mult, localize(card.ability.extra.hand_type, 'poker_hands')}}
	end,
	calculate = function(self, card, context)
        if context.joker_main and not next(context.poker_hands[card.ability.extra.hand_type]) then
            return {
                mult = card.ability.extra.mult, 
                colour = G.C.RED,
            }
        end
    end
})