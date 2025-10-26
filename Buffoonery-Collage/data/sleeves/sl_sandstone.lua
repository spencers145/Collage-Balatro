CardSleeves.Sleeve {
    key = 'sandstone',
    unlocked = false,
    unlock_condition = { deck = "b_buf_sandstone", stake = "stake_bunc_magenta" },
    atlas = 'buf_sleeves',
    pos = {
        x = 3,
        y = 0,
    },
    config = {},
	loc_vars = function(self)
        if self.get_current_deck_key() == "b_buf_sandstone" then
            return {key = self.key .. '_alt', vars = {}}
        end
    end,
    apply = function(self)
		if self.get_current_deck_key() == "b_buf_sandstone" then
			local ante = G.GAME.win_ante - 1 
			local int_part, frac_part = math.modf(ante)               -- this is here to be more compatible with other modifiers to
			local rounded = int_part + (frac_part >= 0.5 and 1 or 0)  -- G.GAME.win_ante that might come before this deck
			G.GAME.win_ante = rounded
			G.GAME.starting_params.ante_scaling = 3
		else
			local ante = G.GAME.win_ante * 0.75 
			local int_part, frac_part = math.modf(ante)               -- this is here to be more compatible with other modifiers to
			local rounded = int_part + (frac_part >= 0.5 and 1 or 0)  -- G.GAME.win_ante that might come before this deck
			G.GAME.win_ante = rounded
			G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 2
		end
    end,
}