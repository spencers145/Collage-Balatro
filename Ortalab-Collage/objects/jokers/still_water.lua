SMODS.Joker({
	key = "still_water",
	atlas = "jokers",
	pos = {x=8,y=9},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {mult = 1, total_mult = 0}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.mult, card.ability.extra.total_mult}}
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #context.scoring_hand < #context.full_hand then
				SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "total_mult",
                    scalar_value = "mult",
                    message_key = 'a_mult',
					colour = G.C.RED
                })
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.total_mult
            }
        end
        
    end
})

--[[SMODS.JimboQuip({
    key = 'still_water',
    extra = {
        center = 'j_ortalab_still_water',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_still_water')) then
            if type == 'loss' then
                return true, { weight = 5 }
            end
		end
    end
})]]