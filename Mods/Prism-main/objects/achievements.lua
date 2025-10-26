SMODS.Atlas({
	key = "prismachieve",
	path = "achievements.png",
	px = 66,
	py = 66
})

SMODS.Achievement({
	key = "stoned",
	bypass_all_unlocked = true,
	atlas = "prismachieve",
	pos = { x = 2, y = 0 },
	unlock_condition = function(self, args)
		if args.type == "stoned" then
			return true
		end
	end
})