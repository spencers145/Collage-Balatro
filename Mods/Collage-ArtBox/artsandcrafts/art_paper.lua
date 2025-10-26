SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_paper',
	set = 'art',
	name = 'Paper',
	pos = { x = 2, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = false,
	config = {mod_conv = "m_artb_pinata", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})