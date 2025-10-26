----------------------------------------------
------------MOD CODE -------------------------

-- Code to allow for credits

local generate_UIBox_ability_table_ref = Card.generate_UIBox_ability_table

function Card.generate_UIBox_ability_table(self, vars_only)
	local AUT = generate_UIBox_ability_table_ref(self, vars_only)
	if not vars_only then AUT.mod_credit = self.config.center.credit or nil end
	return AUT
end

-- local card_h_popup_ref = G.UIDEF.card_h_popup

-- function G.UIDEF.card_h_popup(card)
-- 	local ret = card_h_popup_ref(card)

--     if card.ability_UIBox_table and ret.nodes then
-- 		local AUT = card.ability_UIBox_table
-- 		if AUT.mod_credit then
-- 			local main = ret.nodes[1]
-- 			local thing = {n=G.UIT.ROOT,  config={align = "cm", r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
-- 				{n=G.UIT.R, config={align = "cm", colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
-- 				{n=G.UIT.R, config={align = "cm", colour = lighten(G.C.GREY, 0.15), r = 0.1, padding=0.2}, nodes={
-- 				{n=G.UIT.R, config={align = "cm"}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = localize("c3x_art_by"), colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}},
-- 					{n=G.UIT.O, config={object = DynaText({string = AUT.mod_credit.art, colours = {G.C.3XC_COLOUR}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}}}},
-- 				{n=G.UIT.R, config={align = "cm"}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = localize("c3x_code_by"), colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}},
-- 					{n=G.UIT.O, config={object = DynaText({string = AUT.mod_credit.code, colours = {G.C.3XC_COLOUR }, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}}}},
-- 				{n=G.UIT.R, config={align = "cm"}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = localize("c3x_concept_by"), colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}},
-- 					{n=G.UIT.O, config={object = DynaText({string = AUT.mod_credit.concept, colours = {G.C.3XC_COLOUR }, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}}}},
-- 			}}}}}}

-- 			main.children = main.children or {}
-- 			main.children.credits = UIBox{
-- 				definition = thing,
-- 				config = {offset = {x=  0.03,y=0}, align = 'cr', parent = main}
-- 			}
-- 			main.children.credits:align_to_major()
-- 		end
-- 	end
-- 	return ret
-- end



function c3x_generate_deck_credit_payload()
	local obj = Moveable()
	obj= UIBox{
		definition = G.UIDEF.c3x_generate_credits(G.GAME.viewed_back.effect.center.credit),
		config = {offset = {x=0,y=0}, align = 'cm'}
	}

	local e = {n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={id = G.GAME.viewed_back.name, func = 'RUN_SETUP_check_back_credits', object = obj}}
	}}  
	return e
end


function G.UIDEF.c3x_generate_credits(credits)
	return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and localize("c3x_art_by") or " ", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.art or " ", colours = {SMODS.Gradients.c3x_COLOUR}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and localize("c3x_code_by") or "", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.code or G.GAME.viewed_back.effect.center.mod and "Modded Deck" or "Vanilla Deck", colours = {credits and SMODS.Gradients.c3x_COLOUR or G.C.DARK_EDITION}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and localize("c3x_concept_by") or " ", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.concept or " ", colours = {SMODS.Gradients.c3x_COLOUR}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},}}
end

function G.FUNCS.RUN_SETUP_check_back_credits(e)
	if G.GAME.viewed_back.name ~= e.config.id then 
		--removes the UI from the previously selected back and adds the new one
		if e.config.object then e.config.object:remove() end 
		e.config.object = UIBox{
			definition = G.UIDEF.c3x_generate_credits(G.GAME.viewed_back.effect.center.credit),
			config = {offset = {x=0,y=0}, align = 'cm', parent = e}
		}
		e.config.id = G.GAME.viewed_back.name
		e.config.object:recalculate()
	end
end

C3XHELPER = {}

function C3XHELPER.has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
 
	return false
 end

local align_h_popup_ref = Card.align_h_popup
function Card:align_h_popup()
	local ret = align_h_popup_ref(self)
	if not self.config.center.credit then return ret end
	if (G.STATE ~= G.STATES.SHOP or G.SETTINGS.paused or C3XHELPER.has_value(G.jokers.cards, self)) then
		local finalstr = ""
		local artstr = localize("c3x_art_by") .. (self.config.center.credit.art or "") 
		local codestr = localize("c3x_code_by") .. (self.config.center.credit.code or "") 

		finalstr = localize("c3x_concept_by") .. (self.config.center.credit.concept or "")
		if string.len(finalstr) < string.len(codestr) then
			finalstr = codestr
		end
		if string.len(finalstr) < string.len(artstr) then
			finalstr = artstr
		end
		-- create a dummy uibox we delete immediately after
		local dummy = UIBox {
			definition = {n=G.UIT.C,  config={align = "cm", r = 0.1, padding = 0.3, emboss = 0.10}, nodes={ 
				{n=G.UIT.R, config={align = "cm"}, nodes = {
					{n=G.UIT.O, config={object = DynaText({string = finalstr, colours = {{0,0,0,0}}, shadow = false, offset_y = -0.05, silent = true, spacing = 1, scale = 0.33})}}
				}}
			}},
			config = { align = "cm" }
		}
		ret.offset.x = ret.offset.x + (dummy.T.w/2)
		dummy:remove()
	end
	return ret
end
 

SMODS.Atlas({
    key = "modicon",
    path = "c3x_icon.png",
    px = 34,
    py = 34
}):register()

SMODS.Gradient({
    key="c3x_COLOUR",
    update=function(self, dt)
		self[1] = 0.0+0.1*math.sin(G.TIMERS.REAL*1.3)
        self[3] = 0.8+0.1*(0.0- math.sin(G.TIMERS.REAL*1.3))
        self[2] = math.max(self[3], self[1])
	end
})

-- Tests

-- Multibox test
-- SMODS.Joker({
--  	key="test",
--  	loc_txt={ 
--  		name="test",
--  		text={
--         {
--             "{C:green}#1# in #2#{} chance to",
--             "create a {C:dark_edition}Negative{} copy of",
--             "a random Joker in your possession", "at the end of the shop"
--         },
--         {
--             "{C:green}#1# in #3#{} chance to",
--             "destroy all {C:dark_edition}Negative{} Jokers",
--             "at the end of the shop"
--         },
--         {
--             "{C:green}#1# in #4#{} chance to",
--             "become {C:dark_edition}Negative{}"
--         }}
--  	},
--  	credit = {
--  		art = "Aurora Aquir",
--  		code = "Aurora Aquir",
--  		concept = "Aurora Aquir"
--  	},
--  })

-- SMODS.Booster({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Consumable({
-- 	key="testt",
-- 	set="Tarot",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Consumable({
-- 	key="testp",
-- 	set="Planet",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Consumable({
-- 	key="tests",
-- 	set="Spectral",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Edition({
-- 	key="test",
-- 	shader=false,
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Enhancement({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Joker({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Voucher({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Challenge({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })


-- SMODS.Sticker({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Seal({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Achievement({
-- 	key="test",
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- 	unlock_condition = function(self, args)
-- 		return false
-- 	end,
-- })

-- SMODS.Stake({
-- 	key="test",
-- 	applied_stakes = {},
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Rank({
-- 	key="test",
-- 	card_key = "X_X",
-- 	pos = {x=1,y=0},
-- 	nominal = 999,
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.Suit({
-- 	key="test",
-- 	card_key = "X_X",
-- 	pos = {x=1,y=0},
-- 	ui_pos = 0,
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })

-- SMODS.PokerHand({
-- 	key="test",
-- 	mult=1,
-- 	chips=1,
-- 	l_mult=999,
-- 	l_chips=999,
-- 	example=  {
--         { 'S_K', false }, -- King of Spades, does not score
--         { 'S_9', true }, -- 9 of Spades, scores
--         { 'D_9', true }, -- 9 of Diamonds, scores
--         { 'H_6', false }, -- 6 of Hearts, does not score
--         { 'D_3', false } -- 3 of Diamonds, does not score
--     },
-- 	evaluate = function(parts, hand) 
-- 		return {}
-- 	end,
-- 	loc_txt={ 
-- 		name="test",
-- 		text={"test item"}
-- 	},
-- 	credit = {
-- 		art = "Aurora Aquir",
-- 		code = "Aurora Aquir",
-- 		concept = "Aurora Aquir"
-- 	},
-- })


-- 
----------------------------------------------
------------MOD CODE END----------------------
