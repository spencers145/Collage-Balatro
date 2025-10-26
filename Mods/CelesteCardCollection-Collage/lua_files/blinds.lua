---- -- region Snow

---- local snow = SMODS.Blind{
---- 	name = "ccc_The Snow",
---- 	slug = "snow", 
---- 	key = 'snow',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 0},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 2, max = 10},
---- 	boss_colour = HEX('d8d8d8'),
---- }

---- -- Snow, Stone, Crystal and Berry use lovely to keep suits flipped

---- snow.disable = function(self)
---- 	for i = 1, #G.hand.cards do
---- 		if G.hand.cards[i].facing == 'back' then
---- 			G.hand.cards[i]:flip()
---- 		end
---- 	end
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.wheel_flipped = nil
---- 	end
---- end

---- snow.stay_flipped = function(self, area, card)
---- 	if card:is_suit('Clubs', true) and area == G.hand then
---- 		return true
---- 	end
---- end

---- -- endregion Snow

---- -- region Stone

---- local stone = SMODS.Blind{
---- 	name = "ccc_The Stone",
---- 	slug = "stone", 
---- 	key = 'stone',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 1},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 2, max = 10},
---- 	boss_colour = HEX('575f7d'),
---- }

---- stone.disable = function(self)
---- 	for i = 1, #G.hand.cards do
---- 		if G.hand.cards[i].facing == 'back' then
---- 			G.hand.cards[i]:flip()
---- 		end
---- 	end
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.wheel_flipped = nil
---- 	end
---- end

---- stone.stay_flipped = function(self, area, card)
---- 	if card:is_suit('Spades', true) and area == G.hand then
---- 		return true
---- 	end
---- end

---- -- endregion Stone

---- -- region Crystal

---- local crystal = SMODS.Blind{
---- 	name = "ccc_The Crystal",
---- 	slug = "crystal", 
---- 	key = 'crystal',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 2},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 2, max = 10},
---- 	boss_colour = HEX('fd7a30'),
---- }

---- crystal.disable = function(self)
---- 	for i = 1, #G.hand.cards do
---- 		if G.hand.cards[i].facing == 'back' then
---- 			G.hand.cards[i]:flip()
---- 		end
---- 	end
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.wheel_flipped = nil
---- 	end
---- end

---- crystal.stay_flipped = function(self, area, card)
---- 	if card:is_suit('Diamonds', true) and area == G.hand then
---- 		return true
---- 	end
---- end

---- -- endregion Crystal

---- -- region Berry

---- local berry = SMODS.Blind{
---- 	name = "ccc_The Berry",
---- 	slug = "berry", 
---- 	key = 'berry',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 3},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 2, max = 10},
---- 	boss_colour = HEX('f3639b'),
---- }

---- berry.disable = function(self)
---- 	for i = 1, #G.hand.cards do
---- 		if G.hand.cards[i].facing == 'back' then
---- 			G.hand.cards[i]:flip()
---- 		end
---- 	end
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.wheel_flipped = nil
---- 	end
---- end

---- berry.stay_flipped = function(self, area, card)
---- 	if card:is_suit('Hearts', true) and area == G.hand then
---- 		return true
---- 	end
---- end

---- -- endregion Berry

---- -- region Gap

---- local gap = SMODS.Blind{
---- 	name = "ccc_The Gap",
---- 	slug = "gap", 
---- 	key = 'gap',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 5},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 3, max = 10},
---- 	boss_colour = HEX('b3c9ff'),
---- 	set_blind = function(self, reset, silent)
---- 		G.GAME.ccc_gap_active = 2
---- 	end,
---- }
---- gap.disable = function(self)
---- 	G.GAME.ccc_gap_active = nil
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ccc_gaptarget = nil
---- 	end
---- end
---- gap.defeat = function(self)
---- 	G.GAME.ccc_gap_active = nil
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ccc_gaptarget = nil
---- 	end
---- end
---- gap.press_play = function(self)
----         for i, v in ipairs(G.hand.highlighted) do
---- 		if v.ccc_gaptarget then
---- 			v:set_debuff(true)	-- scuffed
---- 			if v.debuff then v.debuffed_by_blind = true end
---- 			v.ccc_gaptarget = nil
---- 		end
----         end
---- 	G.GAME.ccc_gap_active = (#G.hand.highlighted % 2 == 1) and G.GAME.ccc_gap_active - 1 or G.GAME.ccc_gap_active
---- 	if G.GAME.ccc_gap_active == 0 then G.GAME.ccc_gap_active = 2 end	-- there's definitely a smarter way to do this logic but whatever
---- end

---- SMODS.DrawStep {
----     key = 'ccc_gaptarget',
----     order = 71,
----     func = function(self)
----         if self.ccc_gaptarget then
----             self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
----             if self.children.front and (self.ability.delayed or (self.ability.effect ~= 'Stone Card' and not self.config.center.replace_base_card)) then
----                 self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
----             end
----         end
----     end,
----     conditions = { vortex = false, facing = 'front' },
---- }
---- local caalref = CardArea.align_cards
---- function CardArea:align_cards()
---- 	caalref(self)
---- 	if G.GAME.ccc_gap_active and self.config.type == 'hand' and G.GAME.STOP_USE <= 0 then
---- 		table.sort(self.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
---- 		for i, v in ipairs(self.highlighted) do
---- 			if i % 2 == G.GAME.ccc_gap_active % 2 then
---- 				v.ccc_gaptarget = true
---- 			else
---- 				v.ccc_gaptarget = nil
---- 			end
---- 		end
---- 		for i, v in ipairs(self.cards) do
---- 			if not v.highlighted then
---- 				v.ccc_gaptarget = nil
---- 			end
---- 		end
---- 	end
---- end

---- -- endregion Gap

---- -- region Fallacy

---- local fallacy = SMODS.Blind{
---- 	name = "ccc_The Fallacy",
---- 	slug = "fallacy", 
---- 	key = 'fallacy',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 4},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 3, max = 10},
---- 	boss_colour = HEX('2f4063'),
---- }

---- fallacy.press_play = function(self)
---- 	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
----         for i = 1, #G.play.cards do
---- 		G.E_MANAGER:add_event(Event({func = function()
---- 			local card = G.play.cards[i]
---- 			local new_rank = 'Ace'
---- 			for _, v in pairs(SMODS.Ranks) do
---- 				for __, _v in ipairs(v.next) do
---- 					if card.base.value == _v then
---- 						new_rank = v.key
---- 						break
---- 					end
---- 				end
---- 			end
----                         assert(SMODS.change_base(card, nil, new_rank))
---- 			card:juice_up()
---- 			play_sound('tarot1')
---- 		return true end }))
---- 		delay(0.23)
----         end
----         return true end }))
---- 	G.GAME.blind.triggered = true
----         return true
---- end

---- -- endregion Fallacy

---- -- region Shriek

---- local shriek = SMODS.Blind{
---- 	name = "ccc_The Shriek",
---- 	slug = "shriek", 
---- 	key = 'shriek',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 6},
---- 	dollars = 5, 
---- 	mult = 2, 
---- 	vars = {}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 3, max = 10},
---- 	boss_colour = HEX('591829'),
---- }

---- shriek.recalc_debuff = function(self, card, from_blind)
---- 	if card.ability.ccc_shriek then	-- originally i was gonna keep undebuff tech, but it undebuffed too frequently
---- 		return true
---- 	end
---- end

---- shriek.disable = function(self)
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.ccc_shriek = nil
---- 	end
---- end
---- shriek.defeat = function(self)
---- 	for k, v in pairs(G.playing_cards) do
---- 		v.ability.ccc_shriek = nil
---- 	end
---- end

---- -- endregion Shriek

---- -- region Golden Crown

---- local goldencrown = SMODS.Blind{
---- 	name = "ccc_Golden Crown",
---- 	slug = "goldencrown", 
---- 	key = 'goldencrown',
---- 	atlas = 'bl_ccc_blinds',
---- 	pos = {x = 0, y = 9},
---- 	dollars = 8, 
---- 	mult = 2.5, 
---- 	vars = {extra = 3}, 
---- 	debuff = {},
---- 	discovered = true,
---- 	boss = {min = 1, max = 10, showdown = true},
---- 	boss_colour = HEX('ffe073'),
---- 	loc_vars = function(self)
---- 		return { vars = { (G.GAME.ccc_golden_progress or self.vars.extra), (G.GAME.ccc_golden_progress or self.vars.extra) == 1 and '' or 's' } } -- no bignum?
---- 	end,
---- 	collection_loc_vars = function(self)
---- 		return { vars = { self.vars.extra, "s" } }
---- 	end,
---- 	set_blind = function(self, reset, silent)
---- 		G.GAME.ccc_golden_progress = self.vars.extra
---- 	end,
---- }
---- goldencrown.disable = function(self)
---- 	G.GAME.ccc_golden_progress = 1
---- 	G.GAME.blind.chips = (G.GAME.blind.chips/5)*4
---- 	G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
---- end
---- goldencrown.defeat = function(self)
---- 	G.GAME.ccc_golden_progress = nil
---- end
