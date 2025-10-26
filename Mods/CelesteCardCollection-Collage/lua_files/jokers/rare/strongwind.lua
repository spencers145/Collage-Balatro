-- region Strong Winds

local strongwinds = {
	name = "ccc_Strong Winds",
	key = "strongwinds",
    config = {extra = {xmult = 3.33}},
	pos = {x = 4, y = 2},
	rarity = 3,
	cost = 7,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "toneblock",
		code = "toneblock",
		concept = "goose!"
	},
    description = "X2.22 Mult. Highest ranked scoring card is destroyed"
}

strongwinds.calculate = function(self, card, context)
	if context.cardarea == G.jokers then
		if context.joker_main then
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				Xmult_mod = card.ability.extra.xmult
			}
		end
	end
	if context.cardarea == G.play and context.destroying_card then
		local bitch = context.scoring_hand[1] or nil
		for k = 1, #context.scoring_hand do
			if context.scoring_hand[k].ability.name ~= 'Stone Card' then
				if context.scoring_hand[k]:get_id() > bitch:get_id() then
					bitch = context.scoring_hand[k]
				end
			end
		end
		if bitch and bitch == context.destroy_card then
			return {remove = true}
		end
	end
end

function strongwinds.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra.xmult}}
end

return strongwinds
-- endregion Strong Winds