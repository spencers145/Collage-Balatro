function SMODS.current_mod.process_loc_text()

	G.localization.descriptions.Other.flc_card_extra_mult = {
		text={
			"{C:mult}+#1#{} extra Mult",
		}
	}

	if not G.localization.descriptions.Mod then G.localization.descriptions.Mod = {} end
	G.localization.descriptions.Mod.FemtoLabsCollection = {
		name = "Femto Labs Collection",
		text = {
			"Adds a bit of everything,",
			"with no particular theme.",
			" ",
			"{X:attention,C:white}Code:",
			"sunsetquasar",
			" ",
			"{X:chips,C:white}Concepts:",
			"sunsetquasar, ABuffZucchini, goose!,",
			"tobyaaa, vitellary & zeodexic",
			" ",
			"{X:mult,C:white}Art:",
			"sunsetquasar, ABuffZucchini, tobyaaa",
			"xolimono, vitellary, frenchtardigrade & dewdrop",
			" ",
			"{X:black,C:white}Playtesting:",
			"JayTeff, zeodexic, ABuffZucchini,",
			"tobyaaa & vitellary", 
			" ",
			"{X:dark_edition,C:white}Inspiration:",
			"vitellary",
		}
	}
	G.localization.misc.v_text['ch_c_flc_purple_stake_scaling'] = {
		"Required score scales faster for each {C:attention}Ante",
	}

	G.localization.misc.v_text['ch_c_flc_empty_shop'] = {
		"{C:red}-1{} card in the {C:attention}shop"
	}

	G.localization.misc.v_text['ch_c_flc_one_booster'] = {
		"{C:red}-1{} booster pack each {C:attention}shop"
	}
end