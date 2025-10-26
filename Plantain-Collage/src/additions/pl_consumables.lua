---- SMODS.Consumable{
---- 	set = 'Spectral',
---- 	key = 'spec_aether', 
----     atlas = 'pl_atlas_consumables',
---- 	pos = { x = 0, y = 0 },
	
---- 	config = {extra = {count = 4, cost = 8}},
---- 	discovered = true,

---- 	loc_vars = function(self, info_queue, card)
---- 		info_queue[#info_queue + 1] =
---- 		{ set = "Other", key = "pl_lavender_seal", specific_vars = {} }
---- 		return {
---- 			vars = { card.ability.max_highlighted }
---- 		}
---- 	end,
---- 	use = function(self, card, area, copier)
---- 		for i = 1, #G.hand.highlighted do
---- 			local highlighted = G.hand.highlighted[i]
---- 			-- G.E_MANAGER:add_event(Event({
---- 			-- 	func = function()
---- 			-- 		play_sound("tarot1")
---- 			-- 		highlighted:juice_up(0.3, 0.5)
---- 			-- 		return true
---- 			-- 	end,
---- 			-- }))
---- 			-- G.E_MANAGER:add_event(Event({
---- 			-- 	trigger = "after",
---- 			-- 	delay = 0.1,
---- 			-- 	func = function()
---- 			-- 		if highlighted then
---- 			-- 			highlighted:set_seal("pl_lavender")
---- 			-- 		end
---- 			-- 		return true
---- 			-- 	end,
---- 			-- }))
---- 			-- delay(0.5)
---- 			-- G.E_MANAGER:add_event(Event({
---- 			-- 	trigger = "after",
---- 			-- 	delay = 0.2,
---- 			-- 	func = function()
---- 			-- 		G.hand:unhighlight_all()
---- 			-- 		return true
---- 			-- 	end,
---- 			-- }))

---- 			G.E_MANAGER:add_event(Event({func = function()
---- 				play_sound('tarot1')
---- 				card:juice_up(0.3, 0.5)
---- 				return true end }))
			
---- 			G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
---- 				highlighted:set_seal('pl_lavender', nil, true)
---- 				return true end }))
			
---- 			delay(0.5)
---- 			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
---- 		end
---- 	end,
---- 	can_use = function(self, card, area)
---- 		if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] then
---- 			return true
---- 		else
---- 			return false
---- 		end
---- 	end
---- }

---- SMODS.Consumable{
---- 	set = 'Spectral',
---- 	key = 'spec_rebirth',
----     atlas = 'pl_atlas_consumables',
---- 	pos = { x = 1, y = 0 },

---- 	config = {extra = {cost = 4}},
---- 	discovered = true,

---- 	can_use = function(self, card)
---- 		if #G.hand.highlighted == 3 then
---- 			return true
---- 		else
---- 			return false
---- 		end
---- 	end,

---- 	use = function(self, card)


---- 		local rightmost = G.hand.highlighted[3]
---- 		local middle = G.hand.highlighted[2]
---- 		local leftmost = G.hand.highlighted[1]

---- 		for i=1, #G.hand.highlighted do
---- 			if G.hand.highlighted[i].T.x < math.max(rightmost.T.x, middle.T.x, leftmost.T.x) and G.hand.highlighted[i].T.x > math.min(rightmost.T.x, middle.T.x, leftmost.T.x) then
---- 				middle = G.hand.highlighted[i]
---- 			end
---- 		end

---- 		for i=1, #G.hand.highlighted do
---- 			if (G.hand.highlighted[i] ~= middle) then
---- 				local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
----            		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.5, func = function() 
---- 					G.hand.highlighted[i]:flip();
---- 					play_sound('tarot2', percent, 0.6);
---- 					G.hand.highlighted[i]:juice_up(0.3, 0.3);
---- 				return true end }))
---- 			else
---- 				destroyed_card = middle
---- 			end
---- 		end
---- 		for i=1, #G.hand.highlighted do
---- 			if (G.hand.highlighted[i] ~= middle) then
				
---- 				G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.5,func = function()
---- 					local suit_prefix = string.sub(G.hand.highlighted[i].base.suit, 1, 1)..'_'
----                 	local rank_suffix = middle.base.id < 10 and tostring(middle.base.id) or
---- 					middle.base.id == 10 and 'T' or middle.base.id == 11 and 'J' or
---- 					middle.base.id == 12 and 'Q' or middle.base.id == 13 and 'K' or
---- 					middle.base.id == 14 and 'A'
---- 					G.hand.highlighted[i]:set_base(G.P_CARDS[suit_prefix..rank_suffix])
---- 					G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);
---- 					G.hand.highlighted[i]:juice_up(0.3, 0.3);
---- 					return true end }))
---- 			end
---- 		end

---- 		G.E_MANAGER:add_event(Event({
----             trigger = 'after',
----             delay = 0.2,
----             func = function() 
---- 				if SMODS.shatters(destroyed_card) then
---- 					destroyed_card:shatter()
---- 				else
---- 					destroyed_card:start_dissolve(nil, destroyed_card)
---- 				end
---- 		return true end }))
---- 	end,
---- }