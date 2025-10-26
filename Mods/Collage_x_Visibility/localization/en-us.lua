return {
	["descriptions"] = {
		Joker = {
			j_collage_vis_harken = {
                name = 'Harken',
                text = {
                    {"Gains {C:white,X:mult}X#1#{} Mult when",
					"a playing card is destroyed",
					"{C:inactive}(Currently {C:white,X:mult}X#2#{C:inactive})"},
					{"If no cards are destroyed",
					"for 1 round, {C:red}dampen",
					"until one is destroyed"},
                }
            },

            j_collage_vis_harken_inactive = {
                name = 'Harken',
                text = {
                    {"{C:inactive}Gains {C:white,X:inactive}X#1#{C:inactive} Mult when",
					"{C:inactive}a playing card is destroyed",
					"{C:inactive}(Currently {C:white,X:inactive}X#2#{C:inactive})"},
					{"This joker is {C:red}dampened",
					"until a playing card",
					"is destroyed"},
                }
            },
		}
	},
}
