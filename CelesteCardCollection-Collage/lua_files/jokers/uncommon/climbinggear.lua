-- region Climbing Gear

local climbinggear = {
	name = "ccc_Climbing Gear",
	key = "climbinggear",
	config = { d_size = 3 },
	pos = { x = 6, y = 1 },
	rarity = 2,
	cost = 5,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "goose!"
	},
    description = "+3 discards. Played and discarded cards are reshuffled into deck"
}

-- literally NO code needs to be here, it's all done in lovely patches

function climbinggear.loc_vars(self, info_queue, card)
	return { vars = { card.ability.d_size } }
end

return climbinggear
-- endregion Climbing Gear