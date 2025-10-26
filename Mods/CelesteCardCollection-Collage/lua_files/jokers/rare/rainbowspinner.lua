
---- -- region Rainbow Spinner

---- local rainbowspinner = {
---- 	name = "ccc_Rainbow Spinner",
---- 	key = "rainbowspinner",
---- 	config = {},
---- 	pos = { x = 3, y = 4 },
---- 	rarity = 3,
---- 	cost = 11,
---- 	discovered = true,
---- 	blueprint_compat = false,
---- 	eternal_compat = true,
---- 	perishable_compat = true,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "toneblock",
---- 		code = "toneblock",
---- 		concept = "sunsetquasar"
---- 	},
----     description = "Gold Seals act as every seal"
---- }

---- -- this hook handles red and purple, still need lovely for blue

---- local sealref = Card.calculate_seal
---- function Card:calculate_seal(context)
---- 	if next(SMODS.find_card('j_ccc_rainbowspinner')) and self.seal == 'Gold' then
---- 		local oldseal = self.seal
---- 		local ret, post = nil, nil
---- 		for k, v in pairs(G.P_SEALS) do
---- 			self.seal = k
---- 			ret, post = sealref(self, context)
---- 			if ret or post then break end
---- 		end
---- 		self.seal = oldseal
---- 		return ret, post
---- 	else
---- 		local ret, post = sealref(self, context)
---- 		return ret, post
---- 	end
---- end

---- function rainbowspinner.loc_vars(self, info_queue, card)
---- 	info_queue[#info_queue + 1] = { key = 'gold_seal', set = 'Other' }
---- end

---- function rainbowspinner.in_pool(self)
---- 	for i, v in ipairs(G.playing_cards) do
---- 		if v.seal and v.seal == 'Gold' then return true end
---- 	end
---- 	return false
---- end

---- return rainbowspinner
---- -- endregion Rainbow Spinner