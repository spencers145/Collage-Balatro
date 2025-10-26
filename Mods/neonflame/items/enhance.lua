---- SMODS.Enhancement {
----     key = "snow",
----     name = "Snow Card",

----     atlas = "enhance",
----     pos = { x = 0, y = 0 },

----     config = { extra = { mult = 2 } },

----     loc_vars = function(self, info_queue, card)
----         return { vars = { card and card.ability.extra.mult or self.config.extra.mult } }
----     end,

----     calculate = function(self, card, context)
----         if context.playing_card_end_of_round and context.cardarea == G.hand then
---- 	    local bonus_m = 0
---- 	    for _, playing_card in pairs(G.hand.cards) do
---- 	        if SMODS.has_enhancement(playing_card, "m_nflame_snow") then
---- 		    bonus_m = bonus_m + card.ability.extra.mult
---- 		end
---- 	    end

----             card.ability.perma_mult = (card.ability.perma_mult or 0) + bonus_m

---- 	    return {
---- 	        message = localize('k_upgrade_ex'),
---- 		colour = G.C.CHIPS
---- 	    }
---- 	end
----     end
---- }

---- SMODS.Enhancement {
----     key = "rules",
----     name = "Rouxles",

----     atlas = "enhance",
----     pos = { x = 1, y = 0 },

----     config = { extra = { decreaseperc = 3, reroll = 6, disable = 5 } },

----     loc_vars = function(self, info_queue, card)
----     	local renum, reden = SMODS.get_probability_vars(card, 1, card and card.ability.extra.reroll or self.config.extra.reroll, "nflame_rules")
----         return { vars = {
---- 	    card and card.ability.extra.decreaseperc or self.config.extra.decreaseperc,
---- 	    renum, reden
---- 	} }
----     end,

----     calculate = function(self, card, context)
----         if context.main_scoring and context.cardarea == G.play then

---- 	    local doublehit = SMODS.pseudorandom_probability(card, "nflame_rules", 1, card.ability.extra.reroll)

---- 	    G.E_MANAGER:add_event(Event({
---- 	        func = function()
---- 		    local newperc = card.ability.extra.decreaseperc
---- 		    if doublehit then
---- 		        newperc = newperc * 2

---- 			if not G.GAME.blind.disabled then G.GAME.blind:disable() end
---- 		    end
---- 		    newperc = (100 - newperc) / 100
		    
---- 		    G.GAME.blind.chips = math.floor(G.GAME.blind.chips * newperc)
---- 		    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

---- 		    G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
---- 		    G.HUD_blind:recalculate()
---- 		    G.hand_text_area.blind_chips:juice_up()
---- 		    return true
---- 		end,
---- 	    }))

---- 	    return {
---- 	        message = doublehit and "Disabled!" or nil
---- 	    }
---- 	end
----     end
---- }


---- --[[
---- 	    local newboss = nil

---- 	    -- to make it a bit easier, 1/4 chance to disable outright
---- 	    if pseudorandom("nflame_rules") > 0.25 then
---- 		newboss = pseudorandom_element(G.P_BLINDS, "nflame_rules")
---- 	    end

---- 	    G.E_MANAGER:add_event(Event({
---- 	        func = function()
---- 		    local old_ch = G.GAME.blind.chips
---- 		    G.GAME.blind:disable()
---- 		    if newboss then
---- 		        G.GAME.blind:remove()
---- 		        G.GAME.blind:set_blind(newboss)
---- 		    end
---- 		    if old_ch < G.GAME.blind.chips then G.GAME.blind.chips = old_ch end
---- 		    return true
---- 		end
---- 	    }))
---- --]]