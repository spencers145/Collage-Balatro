-- region PICO-8 Joker

local picojoker = {
	name = "ccc_PICO-8 Joker",
	key = "pico8joker",
	config = {extra = {}},
	pos = {x = 1, y = 7},
	rarity = 2,
	cost = 4,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "9Ts",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Retrigger each played Ace, 8 or 6"
}

picojoker.calculate = function(self, card, context)
	if context.repetition then
		if context.cardarea == G.play then
			if context.other_card:get_id() == 6 
			or context.other_card:get_id() == 8
			or context.other_card:get_id() == 14 then
				return {
					message = localize('k_again_ex'),
					repetitions = 1,
					card = card
				}
			end
		end
	end
end

function picojoker.loc_vars(self, info_queue, card)
	return {vars = {}}
end

return picojoker
-- endregion PICO-8 Joker