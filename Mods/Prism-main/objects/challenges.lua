function G.PRISM.Challenge(table)
	if table.dependency or table.dependency == nil then
		SMODS.Challenge(table)
	end
end

--[[G.PRISM.Challenge({
	dependency = G.PRISM.config.jokers_enabled,
    key = "aerial_warfare",
	rules = {
		custom = {
			{id = 'no_shop_jokers'},
		},
	},
	jokers = {
		{id = 'j_prism_aces_high', eternal = true},
	},
    restrictions = {
		banned_cards = {
			{id = 'c_judgement'},
			{id = 'c_wraith'},
			{id = 'c_soul'},
			{id = 'c_prism_spectral_djinn'},
			{id = 'p_buffoon_normal_1', ids = {
				'p_buffoon_normal_1','p_buffoon_normal_2','p_buffoon_jumbo_1','p_buffoon_mega_1',
			}},
		},
		banned_tags = {
			{id = 'tag_rare'},
			{id = 'tag_uncommon'},
			{id = 'tag_holo'},
			{id = 'tag_polychrome'},
			{id = 'tag_negative'},
			{id = 'tag_foil'},
			{id = 'tag_buffoon'},
			{id = 'tag_top_up'},
		},
		banned_other = {},
	},
	deck = {
		type = "Challenge Deck",
	},
})]]
G.PRISM.Challenge({
	key = "mvp",
	rules = {
		custom = {
		},
		modifiers = {
		}
	},
	jokers = {
		{id = 'j_blueprint', eternal = true},
		{id = 'j_blueprint', eternal = true},
		{id = 'j_brainstorm', eternal = true},
		{id = 'j_brainstorm', eternal = true},
	},
	deck = {
		type = 'Challenge Deck'
	},
	restrictions = {
		banned_cards = {
			{id = 'v_blank'},
			{id = 'v_antimatter'},
			{id = 'c_ectoplasm'},
		},
		banned_tags = {
			{id = 'tag_negative'},
		},
		banned_other = {
			{id = 'bl_final_acorn', type = 'blind'},
			{id = 'bl_final_heart', type = 'blind'},
			{id = 'bl_final_leaf', type = 'blind'}
		},
	},
})