-- region Refund Policy

local refundpolicy = {
	name = "ccc_Refund Policy",
	key = "refundpolicy",
	config = { extra = { refund = 75 } },
	pos = { x = 4, y = 8 },
	rarity = 1,
	cost = 4,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "MiiK",
		code = "toneblock",
		concept = "Bred"
	},
    description = "On skipping a Booster Pack, gain a 75% refund"
}

refundpolicy.calculate = function(self, card, context)
	if context.skipping_booster then
		if context.booster.cost > 0 then
			return {dollars = math.max( 1, math.floor( context.booster.cost*(card.ability.extra.refund/100) ) )}
		end
	end
end

function refundpolicy.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.refund } }
end


return refundpolicy
-- endregion Refund Policy