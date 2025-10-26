SMODS.Joker({
	key = "business",
	atlas = "jokers",
	pos = {x=9,y=1},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {reroll_gain = 2}},
	artist_credits = {'alex'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.reroll_gain}}
	end,
	calculate = function(self, card, context)
		if context.reroll_shop then
			return {
				dollars = card.ability.extra.reroll_gain
			}
		end
	end
})

--[[SMODS.JimboQuip({
    key = 'business',
    extra = {
        center = 'j_ortalab_business',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_business')) then
            if type == 'win' then
                return true, { weight = 5 } 
            end
		end
    end
})]]