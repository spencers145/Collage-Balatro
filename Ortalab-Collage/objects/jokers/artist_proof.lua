SMODS.Joker({
	key = "artist_proof",
	atlas = "jokers",
	pos = {x=6,y=1},
	pixel_size = {h = 84},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {negative = 7, positive = 20}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.negative, card.ability.extra.positive}}
	end,
	calculate = function(self, card, context) --Beyond The Mask Logic
        if context.setting_blind and not context.blueprint then
            local amount = pseudorandom(pseudoseed('ortalab_artist_proof'), -card.ability.extra.negative, card.ability.extra.positive)
			return {
				dollars = amount,
			}
        end
    end
})