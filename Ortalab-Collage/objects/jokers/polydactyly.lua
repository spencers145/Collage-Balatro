SMODS.Joker({
	key = "polydactyly",
	atlas = "jokers",
	pos = {x=7,y=0},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {cards = 3, hand_1 = 'Flush', hand_2 = 'Straight'}},
	artist_credits = {'eremel','grassy'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.cards, localize(card.ability.extra.hand_1, 'poker_hands'), localize(card.ability.extra.hand_2, 'poker_hands')}}
	end,
})

Ortalab.polydactyly = {cards = {}}

local ortalab_calc_main_scoring = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
	ortalab_calc_main_scoring(context, scoring_hand)
	if context.cardarea == G.play and (next(SMODS.find_card('j_ortalab_polydactyly')) or next(SMODS.find_card('v_ortalab_statue'))) then
		context.cardarea = Ortalab.polydactyly
		ortalab_calc_main_scoring(context, scoring_hand)
		context.cardarea = G.play
	end
	return
end

local ortalab_calc_destroyed = SMODS.calculate_destroying_cards
function SMODS.calculate_destroying_cards(context, cards_destroyed, scoring_hand)
	ortalab_calc_destroyed(context, cards_destroyed, scoring_hand)
	if context.cardarea == G.play and (next(SMODS.find_card('j_ortalab_polydactyly')) or next(SMODS.find_card('v_ortalab_statue'))) then
		context.cardarea = Ortalab.polydactyly
		ortalab_calc_destroyed(context, cards_destroyed, scoring_hand)
		context.cardarea = G.play
	end
	return
end