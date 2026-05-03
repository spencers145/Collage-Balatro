-- edition shader on decks, heavily based on cryptid mod code
SMODS.DrawStep({
	key = "back_edition",
	order = 5,
	func = function(self)
		if safe_get(self,"area","config","type") == "deck" then
			-- following here is a horrendous mod compatability line
			local currentBack = not self.params.galdur_selector
					and ((Galdur and Galdur.config.use and type(self.params.galdur_back) == "table" and self.params.galdur_back) or type(
						self.params.viewed_back
					) == "table" and self.params.viewed_back or (self.params.viewed_back and G.GAME.viewed_back or G.GAME.selected_back))
				or Back(G.P_CENTERS["b_red"])
			if
				currentBack.effect.config.visual_negative
			then
				self.children.back:draw_shader("negative", nil, self.ARGS.send_to_shader, true)
				self.children.center:draw_shader("negative_shine", nil, self.ARGS.send_to_shader, true)
			end
		end
	end,
	conditions = { vortex = false, facing = "back" },
})

SMODS.DrawStep({
	key = "face_down_edition",
	order = 21,
	func = function(self)
		if safe_get(self,"area","config","type") ~= "deck" then
			-- following here is a horrendous mod compatability line
			local currentBack = not self.params.galdur_selector
					and ((Galdur and Galdur.config.use and type(self.params.galdur_back) == "table" and self.params.galdur_back) or type(
						self.params.viewed_back
					) == "table" and self.params.viewed_back or (self.params.viewed_back and G.GAME.viewed_back or G.GAME.selected_back))
				or Back(G.P_CENTERS["b_red"])
			if
				currentBack.effect.config.visual_negative
			then
				self.children.back:draw_shader("negative", nil, self.ARGS.send_to_shader, false)
				self.children.center:draw_shader("negative_shine", nil, self.ARGS.send_to_shader, false)
			end
		end
	end,
	conditions = { vortex = false, facing = "back" },
})