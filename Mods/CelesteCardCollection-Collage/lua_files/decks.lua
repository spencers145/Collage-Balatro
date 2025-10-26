local trigger_effect_callbacks = {}
local start_run_after_callbacks = {}
-- region virus deck -----------------------

local eval_cardRef = eval_card
function eval_card(card, context) 
	local ret, post = eval_cardRef(card, context)

    if context.repetition_only and context.cardarea == G.play and G.GAME.modifiers.ccc_virus then
		if not ret.seals then
			ret.seals = {
				message = localize('k_again_ex'),
				repetitions = G.GAME.modifiers.ccc_virus,
				card = card
			}
		else
			ret.seals.repetitions = ret.seals.repetitions + G.GAME.modifiers.ccc_virus
		end
    end

	return ret, post
end

local debuff_cardRef = Blind.debuff_card

function Blind.debuff_card(self, card, from_blind)
	if G.GAME.modifiers.ccc_virus and card.ability.played_this_ante then
		card:set_debuff(true)
		return
	end

	debuff_cardRef(self, card, from_blind)
end

function virus_effect(self, args)
    if G.GAME.modifiers.ccc_virus and args.context == 'final_scoring_step' then
		
        G.E_MANAGER:add_event(Event({
            func = (function()
				for _, v in ipairs(G.playing_cards) do
					if G.GAME.modifiers.ccc_virus and v.ability.played_this_ante then
						v:set_debuff(true)
					end
				end
                return true
			end)
		}))
	end
end

table.insert(trigger_effect_callbacks, virus_effect)

local virus = SMODS.Back({
	name = "ccc_Virus Deck",
	key = "virus",
	config = {virus = true},
	unlocked = false,
	check_for_unlock = function(self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 7
    end,
	pos = {x = 0, y = 0},
	apply = function(self)
		G.GAME.modifiers.ccc_virus = (G.GAME.modifiers.ccc_virus or 0) + 1
	end,
	atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})

-- endregion virus deck-----------------------
-- region summit deck -----------------------

-- now displayed in ease_ante, this was old display in case we wanna switch back (end of round)
-- function summit_effect(self, args)
-- 	if self.effect.config.add_slot_each_ante and G.GAME.round_resets.ante > self.effect.config.add_slot_each_ante and args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
-- 		G.E_MANAGER:add_event(Event({func = function()
-- 			if G.jokers then
-- 				local width = G.round_eval.T.w - 0.51
-- 				local slotAdded = {n=G.UIT.R, config={align = "cm", minw = width}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = {'+1 Joker Slot!'}, colours = {G.C.ORANGE},shadow = true, float = false, y_offset = 0, scale = 0.66, spacing = 0, font = G.LANGUAGES['en-us'].font, pop_in = 0})}}
-- 				}}
-- 				local spacer = {n=G.UIT.R, config={align = "cm", minw = width}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = {'......................................'}, colours = {G.C.WHITE},shadow = true, float = true, y_offset = -30, scale = 0.45, spacing = 13.5, font = G.LANGUAGES['en-us'].font, pop_in = 0})}}
-- 				}}
-- 				G.round_eval:add_child(spacer,G.round_eval:get_UIE_by_ID('base_round_eval'))
-- 				G.round_eval:add_child(slotAdded,G.round_eval:get_UIE_by_ID('base_round_eval'))
						
-- 			end
-- 			return true end }))
-- 	end
-- end

local ease_anteRef = ease_ante
function ease_ante(mod, ante_end)
	ease_anteRef(mod, ante_end)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = function () 
			if G.GAME.modifiers.ccc_summit and G.GAME.round_resets.ante % G.GAME.win_ante ~= 0 and G.GAME.round_resets.ante > G.GAME.highest_ante then
						G.jokers.config.card_limit = G.jokers.config.card_limit + G.GAME.modifiers.ccc_summit.add
						G.GAME.highest_ante = G.GAME.round_resets.ante
						attention_text({
							text = "+"..G.GAME.modifiers.ccc_summit.add.." Joker Slot"..(G.GAME.modifiers.ccc_summit.add > 1 and 's' or ''),
							scale = 0.5, 
							hold = 3.3,
							cover = G.jokers.children.area_uibox,
							cover_colour = G.C.CLEAR,
							offset = {x=-2.75,y=1.25}
						})
			end
			return true
		end
	}))

end


table.insert(trigger_effect_callbacks, summit_effect)

--[[local summit = SMODS.Back({
	name = "ccc_Summit Deck",
	key = "summit",
	config = {joker_slot = -4, add_slot_each_ante = 1},
	pos = {x = 1, y = 0},
	apply = function(self)
		G.GAME.modifiers.ccc_summit = G.GAME.modifiers.ccc_summit or {minus = 0, add = 0}
		G.GAME.modifiers.ccc_summit.minus = G.GAME.modifiers.ccc_summit.minus + self.config.joker_slot	-- this isn't used... oops
		G.GAME.modifiers.ccc_summit.add = G.GAME.modifiers.ccc_summit.add + self.config.add_slot_each_ante
	end,
	atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})

]]
-- endregion summit deck-----------------------
-- region B-Side deck

--[[local bside = SMODS.Back({
	name = "ccc_B-Side Deck",
	key = "bside",
	config = {everything_is_boss = true},
	pos = {x = 2, y = 0},
	apply = function(self)
		G.GAME.modifiers.ccc_bside = (G.GAME.modifiers.ccc_bside or 0) + 1
	end,
	atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Bred"
	}
})]]

local get_type_ref = Blind.get_type
function Blind:get_type()
	local ret = get_type_ref
	if G.GAME.blind_on_deck then 
		return G.GAME.blind_on_deck
	end
	
	return ret
end

local end_round_ref = end_round
function end_round()
	if (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1) and G.GAME.blind_on_deck ~= "Boss" then 
		-- no money red stake
		if G.GAME.modifiers.no_blind_reward and G.GAME.modifiers.no_blind_reward[G.GAME.blind:get_type()] then G.GAME.blind.dollars = 0 end
	end
	return end_round_ref()
end

-- alter some joker statistics in b-side deck
local sabref = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
	sabref(self, center, initial, delay_sprites)
	if G.GAME and G.GAME.modifiers and G.GAME.modifiers.ccc_bside and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1) and initial then
		local k = self.config.center.key
		if k == 'j_campfire' or k == 'j_throwback' then
			self.ability.extra = self.ability.extra*3
		elseif k == 'j_rocket' then
			self.ability.extra.increase = self.ability.extra.increase/2
		elseif k == 'j_ccc_zipper' then
			self.ability.extra.chips_scale = self.ability.extra.chips_scale*3
		elseif k == 'j_ccc_goldenstrawberry' or k == 'j_ccc_wingedgoldenstrawberry' then
			self.ability.extra.money = math.floor(self.ability.extra.money/2)
		elseif k == 'j_ccc_checkpoint' then
			self.ability.extra.xmult_scale = self.ability.extra.xmult_scale/2
		elseif k == 'j_ccc_theocrystal' then
			self.ability.extra.scale = self.ability.extra.scale/2
		end
	end
end

function bside_start_run(self)
	G.GAME.round_resets.blind_choices.ccc_bonus = {}
	if (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1) then
		G.GAME.round_resets.ante = 0
		G.GAME.round_resets.blind_ante = 0
		G.GAME.round_resets.blind_choices.Small = get_new_boss()
		G.GAME.round_resets.blind_choices.Big = get_new_boss()
		if (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 2) then
			for _, v in ipairs({'Small', 'Big', 'Boss'}) do
				G.GAME.round_resets.blind_choices.ccc_bonus[v] = get_new_boss()
				local i = 0
				while G.GAME.round_resets.blind_choices.ccc_bonus[v] == G.GAME.round_resets.blind_choices[v] and i < 100 do
					G.GAME.round_resets.blind_choices.ccc_bonus[v] = get_new_boss()
					i = i + 1
				end
			end
		end
	end
end

-- overwrite this for double blind
function SMODS.juice_up_blind(blind)
	if (not blind) or (blind == true) then 
		blind = 'blind' 
	end
	local ui_elem = G.HUD_blind:get_UIE_by_ID('HUD_blind_debuff')
	for _, v in ipairs(ui_elem.children) do
		v.children[1]:juice_up(0.3, 0)
	end
	G.GAME[blind]:juice_up()
end

-- handle verdant leaf more specifically
function Blind:ccc_verdant_disable()
	self.disabled = true
	for _, v in ipairs(G.playing_cards) do
		self:debuff_card(v)
	end
end

table.insert(start_run_after_callbacks, bside_start_run)


-- endregion B-Side deck

-- region Heartside 

function heartside_start_run(self)
	if G.GAME.modifiers.ccc_heartside then
		local jokerPool = {}
		for k, v in pairs(G.P_CENTERS) do
			if v.set == 'Joker' then
				if (not v.mod) then
					G.GAME.banned_keys[k] = true
				end
			end
		end
		G.GAME.pool_flags.heartside_deck = true
	else 
		G.GAME.pool_flags.heartside_deck = false
	end
end

table.insert(start_run_after_callbacks, heartside_start_run)

-- endregion 
-- region HOOKS

local trigger_effectRef = Back.trigger_effect

function Back.trigger_effect(self, args)
	for _, callback in ipairs(trigger_effect_callbacks) do
		callback(self, args)
	end
	return trigger_effectRef(self, args)
end

local start_run_ref = Game.start_run
function Game:start_run(args)
	local ret = start_run_ref(self, args)
	if not args.savetext then
		for _, callback in ipairs(start_run_after_callbacks) do
			callback(self)
		end
	
		self.GAME.highest_ante = self.GAME.highest_ante or 1	-- idk what this does
	end
	return ret
end

-- endregion HOOKS

sendDebugMessage("[CCC] Decks loaded")
----------------------------------------------
------------MOD CODE END----------------------
