
-- region cloud

local cloud = {
	name = "ccc_cloud",
	key = "cloud",
	config = { extra = { chips = 0, add = 30 } },
	pos = { x = 4, y = 4 },
	rarity = 1,
	cost = 4,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	},
    description = "Gains +30 CHips for each hand played this round"
}



cloud.calculate = function(self, card, context)
	if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
		card.ability.extra.chips = 0
	elseif context.cardarea == G.jokers and context.after and not context.blueprint then
		card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
	elseif context.joker_main and card.ability.extra.chips > 0 then
		return {
			message = localize {
				type = 'variable',
				key = 'a_chips',
				vars = { card.ability.extra.chips }
			},
			chip_mod = card.ability.extra.chips
		}
	end
end


function cloud.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.add, card.ability.extra.chips } }
end

return cloud
-- endregion cloud