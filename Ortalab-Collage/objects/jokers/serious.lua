SMODS.Joker({
	key = "serious",
	atlas = "jokers",
	pos = {x=5,y=12},
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 50, hand_type = 'Three of a Kind'}},
	artist_credits = {'crimson'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.chips, localize(card.ability.extra.hand_type, 'poker_hands')}}
	end,
	calculate = function(self, card, context)
        if context.joker_main and not next(context.poker_hands[card.ability.extra.hand_type]) then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})