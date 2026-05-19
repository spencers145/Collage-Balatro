local sanctuary_gate = {
    object_type = "Consumable",
	key = 'sanctuary_gate',
	set = 'Thoth_Tarot',
	 
	pos = { x = 1, y = 6 },
	cost = 3,
	unlocked = true,
	discovered = false,
	order = 1,
	config = { mod_conv = 'm_aij_wood', max_highlighted = 3 },
	atlas = 'consumable_atlas',
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_aij_wood
		return {
			vars = {
				card.ability.max_highlighted,
				localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv }
			}
		}
	end,
}
return {name = {"Tarots"}, items = {sanctuary_gate}}