-- region Event Horizon

local eventhorizon = {
	name = "ccc_Event Horizon",
	key = "eventhorizon",
	config = { extra = { count = 0, req = 4 } },
	pos = { x = 8, y = 4 },
	rarity = 2,
	cost = 7,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "sunsetquasar + toneblock",
		code = "toneblock",
		concept = "Fytos"
	},
    description = "Every 5th Planet card used acts as a Black Hole"
}

eventhorizon.calculate = function(self, card, context)
	if context.using_consumeable then
		if context.consumeable.ability.set == 'Planet' and not context.blueprint and card.ability.extra.count < card.ability.extra.req then
			card.ability.extra.count = card.ability.extra.count + 1
			if (card.ability.extra.count >= card.ability.extra.req) and not card.ccc_juiced then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = (function()
						local eval = function(_card) return _card.ability.extra.count >= _card.ability.extra.req end
						juice_card_until(card, eval, true)
						return true
					end)
				}))
				card.ccc_juiced = true	-- doesn't get saved but neither does juice_card_until
			end
			if (card.ability.extra.count <= card.ability.extra.req) then
				return {
					message = (card.ability.extra.count < card.ability.extra.req) and (card.ability.extra.count..'/'..card.ability.extra.req) or localize('k_active_ex'),
					colour = G.C.FILTER,
					card = card
				}
			end
		end
	elseif context.ccc_event_horizon and card.ability.extra.count >= card.ability.extra.req and not context.blueprint then
		if not context.planet.event_horizoned then
			card.ability.extra.count = card.ability.extra.count - card.ability.extra.req
			context.planet.event_horizoned = true
			card:juice_up()
		end
	end
end



function eventhorizon.loc_vars(self, info_queue, card)
	info_queue[#info_queue + 1] = G.P_CENTERS.c_black_hole
	return { vars = { card.ability.extra.count, card.ability.extra.req } }
end

return eventhorizon
-- endregion Event Horizon