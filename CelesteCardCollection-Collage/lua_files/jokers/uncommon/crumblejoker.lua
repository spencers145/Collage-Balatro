-- region Crumble Joker

local crumblejoker = {
	name = "ccc_Crumble Joker",
	key = "crumblejoker",
	config = {extra = {xmult = 2}},
	pos = {x = 3, y = 7},
	rarity = 2,
	cost = 5,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	enhancement_gate = "m_stone",
	atlas = "j_ccc_jokers",
	credit = {
		art = "9Ts",
		code = "toneblock",
		concept = "Fytos"
	},
    description = "Played stone cards each give X2 mult and are destroyed"
}

crumblejoker.calculate = function(self, card, context)
	if context.individual and context.cardarea == G.play then
		if SMODS.has_enhancement(context.other_card, 'm_stone') then
			return {
				x_mult = card.ability.extra.xmult,
				card = card
			}
		end
	end
	if context.cardarea == G.play and context.destroying_card then
		if SMODS.has_enhancement(context.destroy_card, 'm_stone') then
			return {remove = true}
		end
	end
end

function crumblejoker.loc_vars(self, info_queue, card)
	info_queue[#info_queue+1] = G.P_CENTERS.m_stone
	return {vars = {card.ability.extra.xmult}}
end

return crumblejoker
-- endregion Crumble Joker