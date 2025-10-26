-- region brittle cloud

local brittlecloud = {
	name = "ccc_brittlecloud",
	key = "brittlecloud",
	config = { extra = { chips = 125 } },
	pos = { x = 5, y = 4 },
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
	description = "+125 Chips in first hand of round"
}


brittlecloud.calculate = function(self, card, context)
	if context.joker_main and G.GAME.current_round.hands_played == 0 then
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


function brittlecloud.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.chips } }
end

return brittlecloud
-- endregion brittle cloud