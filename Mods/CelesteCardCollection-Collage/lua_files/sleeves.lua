
---/ Summit^2 effect: You only win the game upon beating the ante 16 boss  (no showdown on 8?)
--- Virus^2 effect: Each played card is retriggered twice then permanently debuffed 
---X B-Side^2 effect: double(partnered) boss blinds
--- Heartside^2 effect: Add 11 meme jokers to the pool

--[[
CardSleeves.Sleeve({
	key = "virus",
	name = "ccc_Virus Sleeve",
	atlas = "s_ccc_sleeves",
	pos = { x = 0, y = 0 },
	config = {virus = true},
	unlocked = true,
	unlock_condition = { deck = "ccc_Virus Deck", stake = 1 },
	loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_ccc_virus" then
            key = self.key .. "_alt"
            self.config = { virus_all_drawn = true}
        else
            key = self.key
            self.config = { virus = true }
        end
		return { key = key, vars = {} }
	end,
	trigger_effect = function(self, args) end,
	apply = function(self)
		G.GAME.modifiers.ccc_virus = (G.GAME.modifiers.ccc_virus or 0) + 1
	end,
})]]

CardSleeves.Sleeve({
	key = "summit",
	name = "ccc_Summit Sleeve",
	atlas = "s_ccc_sleeves",
	pos = { x = 1, y = 0 },
	config = {joker_slot = -4, add_slot_each_ante = 1},
	unlocked = false,
	unlock_condition = { deck = "ccc_Summit Deck", stake = 1 },
	loc_vars = function(self)
		local key
        if self.get_current_deck_key() == "b_ccc_summit" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        return { key = key, vars = {} }
	end,
	trigger_effect = function(self, args) end,
	apply = function(self)

		if self.get_current_deck_key() == "b_ccc_summit" then
			G.GAME.win_ante = 16
		else
			G.GAME.modifiers.ccc_summit = G.GAME.modifiers.ccc_summit or {minus = 0, add = 0}
			G.GAME.modifiers.ccc_summit.minus = G.GAME.modifiers.ccc_summit.minus + self.config.joker_slot	-- this isn't used... oops
			G.GAME.modifiers.ccc_summit.add = G.GAME.modifiers.ccc_summit.add + self.config.add_slot_each_ante
	
			G.GAME.starting_params.joker_slots = G.GAME.starting_params.joker_slots + self.config.joker_slot	-- needs to be done for sleeves but NOT for decks
		
		end
	end,
})

CardSleeves.Sleeve({
	key = "bside",
	name = "ccc_B-Side Sleeve",
	atlas = "s_ccc_sleeves",
	pos = { x = 2, y = 0 },
	config = {everything_is_boss = true, ccc_vouchers = {'v_grabber', 'v_wasteful', 'v_blank'}},
	unlocked = true,
	loc_txt = {
	},
	unlock_condition = { deck = "ccc_B-Side Deck", stake = 1 },
	loc_vars = function(self)
		local key = self.key
		if self.get_current_deck_key() == "b_ccc_bside" then
			key = self.key .. "_alt"
		end
		return { key = key, vars = {self.config.hands, self.config.discards, self.config.joker_slots} }
	end,
	trigger_effect = function(self, args) end,
	apply = function(self)
		G.GAME.modifiers.ccc_bside = (G.GAME.modifiers.ccc_bside or 0) + 1
		if self.get_current_deck_key() == "b_ccc_bside" then
			for k, v in pairs(self.config.ccc_vouchers) do
				G.GAME.used_vouchers[v] = true
				G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						Card.apply_to_run(nil, G.P_CENTERS[v])
						return true
					end
				}))
			end
		end
	end,
})

--[[CardSleeves.Sleeve({
	key = "heartside",
	name = "ccc_Heartside Sleeve",
	atlas = "s_ccc_sleeves",
	pos = { x = 3, y = 0 },
	config = {all_jokers_modded = true},
	unlocked = true,
	unlock_condition = { deck = "ccc_Heartside Deck", stake = 1 },
	loc_vars = function(self)
		return { vars = {} }
	end,
	trigger_effect = function(self, args) end,
	apply = function(self)
		G.GAME.modifiers.ccc_heartside = (G.GAME.modifiers.ccc_heartside or 0) + 1
	end,
})]]

sendDebugMessage("[CCC] Sleeves loaded")
----------------------------------------------
------------MOD CODE END----------------------
