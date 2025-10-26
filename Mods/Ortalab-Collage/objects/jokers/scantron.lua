SMODS.Joker({
	key = "scantron",
	atlas = "jokers",
	pos = {x=0,y=11},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chance = 2, denom = 3, repetitions = 2}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.denom)
		return {vars = {n, d, card.ability.extra.repetitions}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            if not SMODS.pseudorandom_probability(card, 'ortalab_scantron', card.ability.extra.chance, card.ability.extra.denom) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
        
    end
})

--[[SMODS.JimboQuip({
    key = 'scantron',
    extra = {
        center = 'j_ortalab_scantron',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_scantron')) then
            if type == 'win' then
                return true, { weight = 5 } 
            end
		end
    end
})]]