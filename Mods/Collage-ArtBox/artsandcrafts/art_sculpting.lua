SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_sculpting',
	set = 'art',
	name = 'Carving',
	pos = { x = 0, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = false,
	config = {mod_conv = "m_artb_marble", max_highlighted = 1},
    effect = 'Enhance',
	in_pool = function (self, args)
		return collage_ease_pool(44, 44, 8)
	end,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})