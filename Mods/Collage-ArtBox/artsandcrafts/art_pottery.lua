SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_pottery',
	set = 'art',
	pos = { x = 3, y = 2 },
	cost = 4,
	unlocked = true,
	discovered = false,
	config = {mod_conv = "m_artb_clay", max_highlighted = 2},
    effect = 'Enhance',
	in_pool = function (self, args)
		return collage_ease_pool(20, 20, 4)
	end,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})