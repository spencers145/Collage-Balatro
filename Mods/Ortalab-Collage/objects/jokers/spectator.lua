SMODS.Joker({
	key = "spectator",
	atlas = "jokers",
	pos = {x=9,y=10},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 2}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
})