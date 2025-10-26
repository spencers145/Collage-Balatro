SMODS.Joker({
	key = "cutout",
	atlas = "jokers",
	pos = {x=6,y=0},
	pixel_size = {h = 69, w = 47},
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	config = {extra = {xmult = 3}},
	artist_credits = {'kosze'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
        if context.selling_card and context.card.config.center.set == 'Joker' then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.8,
                func = function()
                    card:start_dissolve()                
                    return true
                end
            }))
            return {
                message = localize('ortalab_cutout')
            }
        end
	end
})