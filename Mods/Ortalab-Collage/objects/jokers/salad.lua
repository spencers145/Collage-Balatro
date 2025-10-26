SMODS.Joker({
	key = "salad",
	atlas = "jokers",
	pos = {x=5,y=6},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	config = {extra = {xmult = 1, gain = 0.5, chance = 10}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.gain, card.ability.extra.xmult + (card.ability.extra.gain * G.GAME.current_round.discards_left), SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'ortalab_salad')}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult + (card.ability.extra.gain * G.GAME.current_round.discards_left)
            }
        end
        if context.pre_discard then
            if SMODS.pseudorandom_probability(card, 'ortalab_salad', 1, card.ability.extra.chance) then
                SMODS.calculate_effect({message = localize('k_eaten_ex'),colour = G.C.RED,}, card)
                SMODS.destroy_cards(card, nil, nil, true)
            else
                return {
                    message = localize('ortalab_infected_safe'),
                    colour = G.C.GREEN
                }
            end
        end
    end
})