return {
	descriptions = {
		Statement = {
			c_collagexdread_interference = {
				name = "Interference",
				text = {
					"When {C:attention}active{},",
					"scoring cards permanently gain",
					"{C:money}$1{}, +{X:mult,C:white}X0.1{} Mult, or +{X:chips,C:white}X0.1{} Chips"
				},
			},
		},
		art = {
			c_collagexdread_art_bleach = {
				name = "Bleach",
				text = {
					{"Strip all modifiers",
					"from {C:attention}1{} selected card"},
					{"Apply each of its",
					"modifiers to {C:attention}3{} random",
					"cards held in hand",
					"{C:inactive}(May overwrite modifiers)"}
				},
			},
		},
		travel = {
			c_collagexdread_slay_the_princess = {
				name = "Pristine Blade",
				text = {
					{"Destroy a selected",
					"face card"},
					{"After {C:attention}#2#{} uses, gain",
					"{C:blue}+1{} hand {C:attention}permanently",
					"{C:inactive}(Currently #1#/#2#)"}
				},
			},
		},
		Polymino = {
			c_collagexdread_buffer = {
				name = "The Buffer",
				text = {
					"Link up to {C:attention}5",
					"selected cards"
				},
			},
		},
		BlackMarket = {
			c_collagexdread_undeveloped_film = {
				name = "Film Negative",
				text = {
					"Apply {C:dark_edition}Negative{} edition to",
					"{C:attention}1{} random playing card",
					"held in hand"
				},
			},
		},
		collectable = {
			c_collagexdread_blind_box = {
				name = "Blind Box",
				text = {
					"Gain {C:attention}1{} random tag"
				},
			},
		},
		Divine = {
			c_collagexdread_rapture = {
				name = "Rapture",
				text = {
					"Create an {C:dark_edition,E:1}Anaglyphic{}",
                    "or {C:dark_edition,E:1}Dichrome{} {C:spectral}Spectral{} card",
					"{C:inactive}(Room not needed)"
				},
			},
		},
		Other = {
			c_collagexdread_rotten = {
				name = "Rotten Consumable",
				text = {
					"Has a unique effect",
					"{s:0.2} {}",
					"Only obtainable by",
					"converting consumables with",
					"certain {C:attention}Jokers{}"
				}
			}
		}
	},
}
