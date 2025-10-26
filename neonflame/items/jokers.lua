 SMODS.Joker {
     key = "jokerhelp",
     name = "Helping Hand",

     atlas = "jokers1",
     pos = { x = 0, y = 0 },

     config = { extra = { bonus = 1 } },
     rarity = 2,
     cost = 3,
     blueprint_compat = false,
     eternal_compat = true,
     perishable_compat = true,
     demicolon_compat = true,

     loc_vars = function(self, info_queue, card)
         return { vars = {card.ability.extra.bonus} }
     end,

     calculate = function(self, card, context)
         if context.blueprint then return end
	
         if context.setting_blind or context.forcetrigger
 	or (context.card_added and context.card == card)
 	then
 	    bonus_hand = 0
 	    for _, tcard in ipairs(G.jokers.cards) do
                if tcard:is_rarity(1) then
 	        G.E_MANAGER:add_event(Event({
 		    trigger = "after",
 		    delay = 0.3,
 		    func = function()
 		        tcard:juice_up(0.8, 0.5)
 			return true
 		    end,
 		}))

 		bonus_hand = bonus_hand + card.ability.extra.bonus
                 end
 	    end

 	    G.E_MANAGER:add_event(Event({
 	        func = function()
 		    ease_hands_played(bonus_hand)
 		    card_eval_status_text(context.blueprint_card or card, "extra", nil, nil, nil, {
 		        messsage = localize({ type = "variable", key = "a_hands", vars = {bonus_hand} })
 		    })

 		    return true
 		end
 	    }))
 	end
     end,
 }

---- SMODS.Joker {
----     name = "Hoarder",
----     key = "hoarder",

----     atlas = "jokers1",
----     pos = { x = 1, y = 0 },

----     rarity = 3,
----     cost = 5,
----     blueprint_compat = true,
----     config = { extra = { mult = 0.5 }, immutable = { lv = 1 } },
----     loc_vars = function(self, info_queue, center)
----         return {vars = { center.ability.extra.mult, center.ability.extra.mult * center.ability.immutable.lv }}
----     end,

----     update_numbers = function(self, card)
----         local value = 0
---- 	if G.STEAM and G.STEAM.user then
---- 	    value = G.STEAM.user.getPlayerSteamLevel()
---- 	end

---- 	card.ability.immutable.lv = 1 + value
----     end,

----     set_ability = function(self, card, initial, delay_sprites)
----         self:update_numbers(card)
----     end,

----     load = function(self, card, card_table, other_card)
----         self:update_numbers(card)
----     end,

----     calculate = function(self, card, context)
	
----         if context.joker_main or context.forcetrigger
---- 	then
---- 	    local cmult = card.ability.extra.mult * card.ability.immutable.lv
	    
---- 	    return {
---- 	        message = localize({ type = "variable", key = "a_xmult", vars = { cmult } }),
---- 		Xmult_mod = cmult,
---- 		colour = G.C.MULT,
---- 	    }
---- 	end
----     end,
---- }


---- SMODS.Joker {
----     key = "nflame",
----     name = "Neonflame",

----     atlas = "jokers1",
----     pos = { x = 2, y = 0 },

----     -- hardcoding the timestamp will definitely not bite me in the butt later
----     config = {extra = { Xmult = 1, decay = 0.1 }, immutable = { cards = 0, timestamp = 1760917610 }},
----     rarity = 3,
----     cost = 7,
----     blueprint_compat = true,
----     eternal_compat = true,
----     perishable_compat = true,
----     demicolon_compat = true,

----     loc_vars = function(self, info_queue, card)
----         return { vars = {card.ability.extra.Xmult, card.ability.extra.decay, self:calc_xmult(card) } }
----     end,

----     update_numbers = function(self, card)
----     	local scale = 0
----         for _, jok in pairs(G.P_CENTER_POOLS.Joker) do
---- 	    if jok.original_mod and jok.original_mod.id == "nflame" then
---- 	        scale = scale + 1
---- 	    end
---- 	end

---- 	card.ability.immutable.cards = scale
----     end,

----     calc_xmult = function(self, card)
----     	local xm = card.ability.extra.Xmult * card.ability.immutable.cards
---- 	local decaytime = (os.time() - card.ability.immutable.timestamp) / 86400
---- 	xm = xm - (card.ability.extra.decay * decaytime)

---- 	return math.max(xm, 1.5)
----     end,

----     set_ability = function(self, card, initial, delay_sprites)
----     	self:update_numbers(card)
----     end,

----     load = function(self, card, card_table, other_card)
----     	self:update_numbers(card)
----     end,

----     calculate = function(self, card, context)
----         if context.joker_main or context.forcetrigger
---- 	then
---- 	    local xm = self:calc_xmult(card)
---- 	    return {
---- 	        message = localize({ type = "variable", key = "a_xmult", vars = { xm } }),
---- 		Xmult_mod = xm,
---- 		colour = G.C.MULT,
---- 	    }
---- 	end
----     end,
---- }

---- SMODS.Joker {
----     key = "forecast",
----     name = "Forecast",

----     atlas = "jokers1",
----     pos = { x = 3, y = 0 },

----     config = { extra = { cards = 8 } },
----     rarity = 1,
----     cost = 4,
----     blueprint_compat = true,
----     demicolon_compat = true,
----     eternal_compat = true,

----     loc_vars = function(self, info_queue, card)
----         return { vars = {card.ability.extra.cards} }
----     end,

----     calculate = function(self, card, context)
----     	if context.ending_booster then
----  	    card.stopinf = false
---- 	end

----         if context.other_drawn or context.force_trigger then
---- 	    if card.stopinf then return end
---- 	    G.E_MANAGER:add_event(Event({
---- 		func = function()
---- 		    card:juice_up(0.8, 0.5)
---- 		    SMODS.draw_cards(card.ability.extra.cards)

---- 		    return true
---- 		end,
---- 	    }))

---- 	    card.stopinf = true
---- 	end
----     end,
---- }
 
---- SMODS.Joker {
----     key = "numberup",
----     name = "Number Go Up",

----     atlas = "jokers1",
----     pos = { x = 4, y = 0 },

----     config = { extra = { increase = 1.5, requirement = 3 } },
----     rarity = 3,
----     cost = 8,
----     blueprint_compat = true,
----     demicolon_compat = true,
----     eternal_compat = true,

----     loc_vars = function(self, info_queue, card)
----         return { vars = { card.ability.extra.increase, card.ability.extra.requirement} }
----     end,

----     calculate = function(self, card, context)
----         local xm_trigger = context.forcetrigger
	
----         if context.other_joker and context.other_joker.ability.set == "Joker" then
---- 	    G.E_MANAGER:add_event(Event({
---- 	        func = function()
---- 		    context.other_joker:juice_up(0.5, 0.5)
---- 		    return true
---- 		end
---- 	    }))
---- 	    xm_trigger = true
---- 	end

---- 	if xm_trigger then
---- 	    local multv = card.ability.extra.increase
---- 	    return {
---- 	        message = localize({ type = "variable", key = "a_xmult", vars = { multv }}),
---- 		colour = G.C.MULT,
---- 		Xmult_mod = multv,
---- 	    }
---- 	end

---- 	if context.final_scoring_step then
---- 	    if SMODS.calculate_round_score() > (G.GAME.blind.chips * card.ability.extra.requirement) then
---- 	        return {
---- 		    dollars = math.floor(G.GAME.dollars * -1),
---- 		    color = G.C.MONEY
---- 		}
---- 	    end
---- 	end
----     end,
---- }


---- SMODS.Joker {
----     key = "tjhenry",
----     name = "TJ HENRY Yoshi",

----     atlas = "layerjoker",
----     pos = { x = 0, y = 0 },
----     soul_pos = { x = 1, y = 0},

----     config = { extra = { size = 3, xmgain = 0.1 } },
----     rarity = 4,
----     cost = 20,
----     blueprint_compat = true,
----     demicolon_compat = true,
----     eternal_compat = true,
----     perishable_compat = false,

----     loc_vars = function(self, info_queue, card)
----         return { vars = {card.ability.extra.size, card.ability.extra.xmgain} }
----     end,

----     calculate = function(self, card, context)
----         if context.individual and context.cardarea == G.play then
---- 	    if #context.full_hand > card.ability.extra.size and not context.force_trigger then return end

---- 	    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.xmgain
----             context.other_card.ability.nflame_tjdraw = true
	    
---- 	    return {
---- 	        extra = {
---- 		    message = localize('k_upgrade_ex'),
---- 		    colour = G.C.MULT
---- 		},
---- 	    }

---- 	end

----         if context.first_hand_drawn then
----             for _, c in pairs(G.deck.cards) do
----                 if c.ability.nflame_tjdraw then
---- 		    draw_card(G.deck, G.hand, nil, "up", true, c)
---- 		    c.ability.nflame_tjdraw = false
---- 		end
----             end

---- 	    card:juice_up(0.5, 0.5)
---- 	end
----     end,
---- }

---- SMODS.Joker {
----     key = "stanleybucket",
----     name = "Reassurance Bucket",

----     atlas = "jokers1",
----     pos = { x = 5, y = 0 },

----     -- its a stanley parable item of course we reference "8"
----     config = { extra = { score = 8 } },
----     rarity = 3,
----     cost = 8,
----     blueprint_compat = false,
----     demicolon_compat = false,
----     eternal_compat = true,
----     perishable_compat = false,

----     loc_vars = function(self, info_queue, card)
----         return { vars = {card.ability.extra.score} }
----     end,

----     calculate = function(self, card, context)


----         if context.press_play then

---- 	    G.E_MANAGER:add_event(Event({
---- 	        func = function()
---- 		    card:juice_up(0.5, 0.5)
---- 		    return true
---- 		end,
---- 	    }))


---- 	    G.E_MANAGER:add_event(Event({
---- 	        trigger = 'ease',
---- 		ref_table = G.GAME,
---- 		ref_value = "chips",
---- 		ease_to = to_big(G.GAME.chips + card.ability.extra.score),
---- 		delay = 1,
---- 		func = (function(t) return math.floor(t) end)
---- 	    }))

---- 	    return {
---- 	           message = "...",
---- 		   message_card = card,
---- 		   -- func = (function() G.GAME.chips = to_big(G.GAME.chips + card.ability.extra.score) end),
----             }
---- 	end


---- 	if context.pre_discard and not context.hook then
---- 	    G.E_MANAGER:add_event(Event({
---- 	        func = function()
---- 		    card:juice_up(0.5, 0.5)
---- 		    return true
---- 		end,
---- 	    }))

----   	    card.ability.extra.score = card.ability.extra.score + G.GAME.chips

---- 	    G.E_MANAGER:add_event(Event({
---- 	        trigger = 'ease',
---- 		ref_table = G.GAME,
---- 		ref_value = "chips",
---- 		ease_to = to_big(0),
---- 		delay = 1,
---- 		func = (function(t) return math.floor(t) end)
---- 	    }))

---- 	    return {
---- 	           message = "...",
---- 		   message_card = card,
---- 		   -- func = (function() G.GAME.chips = to_big(G.GAME.chips + card.ability.extra.score) end),
----             }
---- 	end
----     end,
---- }

---- SMODS.Joker {
----     key = "acpart",
----     name = "Agamemnon Counterpart",

----     atlas = "jokers1",
----     pos = { x = 0, y = 1 },

----     rarity = 1,
----     cost = 4,
----     blueprint_compat = true,
----     demicolon_compat = true,
----     eternal_compat = true,
----     perishable_compat = false,

----     calculate = function(self, card, context)
----         local trigger = context.force_trigger

---- 	if context.before then
---- 	    for _, playing_card in ipairs(G.play.cards) do
---- 	    	print(playing_card:get_id())
---- 	        if playing_card:get_id() == 14 then
---- 		    trigger = true
---- 		    print("trigger enable")
---- 		end
---- 	    end
---- 	end

---- 	if not trigger then return end

---- 	-- looking for non aces in hand
---- 	local ace_hand = {}
---- 	for _, playing_card in ipairs(G.hand.cards) do
---- 	    if playing_card:get_id() ~= 14 then ace_hand[#ace_hand + 1] = playing_card end
---- 	    print(playing_card:get_id())
---- 	end

---- 	if #ace_hand < 1 then return end

---- 	local c = pseudorandom_element(ace_hand, "nflame_acpart")
----         G.E_MANAGER:add_event(Event({
---- 	    func = function()
---- 	        assert(SMODS.change_base(c, nil, 'Ace'))
---- 	        c:juice_up(0.8, 0.5)
---- 		card:juice_up(0.5, 0.5)
---- 		return true
---- 	    end,
---- 	}))
----     end
---- }

---- SMODS.Joker {
----    key = "potatorevenge",
----    name = "Cold Potato",

----    atlas = "jokers1",
----    pos = { x = 2, y = 1 },

----    rarity = 1,
----    price = 4,
----    blueprint_compat = true,
----    demicolon_compat = true,
----    perishable_compat = true,
----    eternal_compat = true,

----    config = { extra = { enigmatic = 1, fires = {}, newcounter = 0 } },

----    blowingsmoke = {
----       "acceptable", "excellent", "exceptional", "favorable", "great",
----       "marvelous", "positive", "satisfactory", "satisfying", "superb",
----       "valuable", "wonderful", "ace", "capital", "pleasing", "prime",
----       "quality", "rad", "sterling", "superior", "superior", "superior", "superior",
----       "worthy", "admirable", "agreeable", "commendable", "cogneial",
----       "deluxe", "first-class", "first-rate", "gnarly", "honorable",
----       "jake", "neat", "precious", "reputable", "select", "shipshape",
----       "splendid", "stupendous", "super-excellent", "tiptop", "upright",
----       "ethical", "blameless", "incorrupt", "capable", "clever", "proper",
----       "appropriate", "beneficial", "decent", "desirable", "fruitful",
----       "healthy", "helpful", "proper", "satisfying", "suitable", "right",
----       "ample", "apt", "favoring", "opprotune", "flawless", "normal",
----       "perfect", "safe", "solid", "stable", "eatable", "fresh", "loyal",
----       "unhurt", "considerate", "humane", "true", "valid", "reliable",
----       "legitimate", "dependable", "genuine", "trustworthy", "well-founded",
----       "dutiful", "profitable", "respectable", "worthwhile", "great", "full",
----       "extensive", "immesurable", "lucrative", "sizeable", "substantial",
----       "godsend", "favor", "profitable", 
----    },

----    loc_vars = function(self, info_queue, card)
----       return { vars = {
---- 		  pseudorandom_element(self.blowingsmoke, "nflame_potato"),
---- 		  card.ability.extra.enigmatic
----       } }
----    end,

----    set_ability = function(self, card, inital, delay_sprites)
----       self:add_ability(card)
----    end,

----    add_ability = function(self, card)
----       local newability = {}

----       local outcomes = {
---- 	 nonblind = { "scale", "xscale", "create" },
---- 	 blind = { "scale", "xscale", "create", "score" },
---- 	 score = { "scale", "xscale", "create", "mult", "chips", "xmult", "xchips" }
----       }

----       local requirements = {
---- 	 cardtype = { "Joker", "consumeable", "Tarot", "Spectral", "Planet", "dollars", "Default" },
---- 	 cardsuit = { "Hearts", "Clubs", "Spades", "Diamonds", "Stone" }, -- stone is any non rank
---- 	 cardrank = { 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 }, -- 0 is no rank
---- 	 cardany = { "Stone", "Hearts", "Clubs", "Spades", "Diamonds", 0, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 },
---- 	 blind = { "Small", "Big", "Boss" },
---- 	 rarity = { 1, 2, 3, 4, 5 } -- 5 is modded
----       }
      
----       local possibility = {
---- 	 open_booster = { out = outcomes.nonblind },
---- 	 buying_card = { out = outcomes.nonblind, req = "cardtype" },
---- 	 selling_card = { out = outcomes.blind, req = "cardtype" },
---- 	 reroll_shop = { out = outcomes.nonblind },
---- 	 skip_blind = { out = outcomes.nonblind },
---- 	 skipping_booster = { out = outcomes.nonblind },
---- 	 playing_card_added = { out = outcomes.nonblind, req = "cardany" },
---- 	 first_hand_drawn = { out = outcomes.blind, req = "cardany", },
---- 	 setting_blind = { out = outcomes.blind, req = "bind" },
---- 	 remove_playing_cards = { out = outcomes.nonblind, req = "cardany" },
---- 	 using_consumeable = { out = outcomes.nonblind }, -- once per round :(
---- 	 debuffed_hand = { out = outcomes.score },
---- 	 pre_discard = { out = outcomes.blind },
---- 	 discard = { out = outcomes.blind, req = "cardany" },
---- 	 end_of_round = { out = outcomes.blind, req = "cardany" },
---- 	 individual = { out = outcomes.score, req = "cardany" },
---- 	 other_joker = { out = outcomes.score, req = "rarity" },
---- 	 before = { out = outcomes.nonblind },
---- 	 after = { out = outcomes.nonblind },
---- 	 joker_main = { out = outcomes.score }
----       }

----       local desc, ctx = pseudorandom_element(possibility, "nflame_potato")
----       newability.context = ctx

----       if desc.req and requirements[desc.req] and (pseudorandom("nflame_potato") < 0.5) then
---- 	 newability.requiretype = desc.req
---- 	 newability.requires = pseudorandom_element(requirements[desc.req], "nflame_potato")
----       end

----       newability.outcome = pseudorandom_element(desc.out, "nflame_potato")
----       if newability.outcome == "create" then
---- 	 newability.outcome = pseudorandom_element(requirements.cardtype, "nflame_potato")
----       end
----       if newability.outcome == "Joker" and (pseudorandom("nflame_potato") < 0.5) then
---- 	 -- this isnt implemented yet, but someday?
---- 	 newability.rarity = pseudorandom_element(requirements.rarity, "nflame_potato")
----       end

----       -- rng 0 - 30
----       newability.scalar = (pseudorandom("nflame_potato") * 30)

----       card.ability.extra.fires[#card.ability.extra.fires + 1] = newability
----    end,

----    check_requirements = function(self, context, ability)
----       if not ability.requiretype then return true end

----       local rtype = ability.requiretype

----       if rtype == "cardtype" then
---- 	 if not context.other_card then return false end
	 
---- 	 if context.other_card.set == ability.requires then return true end
---- 	 if (context.other_card.set == "Default") and (ability.requires == "Enhanced") then return true end
---- 	 if (context.other_card.set == "Enhanced") and (ability.requires == "Default") then return true end
---- 	 if context.other_card.ability.consumeable and (ability.requires == "consumeable") then return true end
----       end

----       if rtype == "cardany" then
---- 	 if type(ability.requires) == "string" then rtype = "cardsuit" end
---- 	 else rtype = "cardrank"
----       end
      
----       if rtype == "cardsuit" then
---- 	 if not context.other_card then return false end
	 
---- 	 if context.other_card.is_suit and context.other_card:is_suit(ability.requires) then return true end
---- 	 if ability.requires == "Stone" and SMODS.has_no_suit(context.other_card) then return true end
----       end
      
----       if rtype == "cardrank" then
---- 	 if not context.other_card then return false end
	 
---- 	 if context.other_card.get_id and (context.other_card:get_id() == ability.requires) then return true end
---- 	 if (ability.requires == 0) and (SMODS.has_no_rank(context.other_card)) then return true end
----       end

----       if rtype == "rarity" then
---- 	 if not context.other_card then return false end

---- 	 if context.other_card:is_rarity(ability.requires) then return true end
---- 	 if type(context.other_card.rarity) == "string" and ability.requires == 5 then return true end
----       end
	 
----    end,

----    calculate = function(self, card, context)
----       local fire = false
----       for _, ability in pairs(card.ability.extra.fires) do
---- 	 if context[ability.context] and self:check_requirements(self, context, ability)
---- 	 and not (ability.context == "individual" and context.area ~= G.Jokers)
---- 	 then
---- 	    fire = ability
---- 	 end
----       end

----       if not fire then return end

----       card.ability.extra.newcounter = card.ability.extra.newcounter + 1
----       if card.ability.extra.newcounter > 3 then
---- 	 self:add_ability(card) -- no indication to the player, minor trolling :3
---- 	 card.ability.extra.newcounter = 0
----       end
      
----       if fire.outcome == "scale" then
---- 	 card.ability.extra.enigmatic = card.ability.extra.enigmatic + (fire.scalar - 5)
---- 	 return {
---- 	    message = localize('k_upgrade_ex'),
---- 	    message_card = card
---- 	 }
----       end

----       if fire.outcome == "xscale" then
---- 	 card.ability.extra.enigmatic = card.ability.extra.enigmatic + (fire.scalar / 10)
---- 	 return {
---- 	    message = localize('k_upgrade_ex'),
---- 	    message_card = card
---- 	 }
----       end

----       if fire.outcome == "score" then
---- 	 G.GAME.blind.chips = G.GAME.blind.chips + (fire.scalar * 3000)
---- 	 return {
---- 	    message = localize('k_upgrade_ex'),
---- 	    message_card = card
---- 	 }
----       end

----       if fire.outcome == "mult" or fire.outcome == "chips"
---- 	 or fire.outcome == "xmult" or fire.outcome == "xchips"
----          or fire.outcome == "dollars" then

---- 	 local ff = {}
---- 	 ff[fire.outcome] = fire.scalar
---- 	 return ff
----       end

----       if fire.outcome == "Default" then fire.outcome = "Enhanced" end
----       -- we've gotten all the other ones out first so we can do this one with minimal checking :)
----       SMODS.add_card { set = fire.outcome }
----    end
---- }

---- SMODS.Joker {
----    key = "bakerfool",
----    name = "Bakers Dozen",

----    atlas = "jokers1",
----    pos = { x = 4, y = 1 },

----    rarity = 2,
----    price = 5,
----    blueprint_compat = true,
----    demicolon_compat = true,
----    perishable_compat = true,
----    eternal_compat = true,

----    calculate = function(self, card, context)
----       if context.open_booster then

----          G.E_MANAGER:add_event(Event({
----             func = function()
----                -- wait for the cards to generate before we do anything
----                if not G.pack_cards.cards[1] then return false end

----                local set = G.pack_cards.cards[1].ability.set
----                local ckey = nil

----                -- we are NOT creating new playing cards
----                if set == "Default" or set == "Enhanced" then return true end

----                if SMODS.ObjectTypes[set] and SMODS.ObjectTypes[set].default and G.P_CENTERS[SMODS.ObjectTypes[set].default] then
----                   ckey = SMODS.ObjectTypes[set].default
                  
----                -- unfortunately we need to hardcode these becaues the game does
----                -- also idk if any pack gives tags but might as well put it ere
----                elseif set == "Tarot"    then ckey = "c_strength"
----                elseif set == "Joker"    then ckey = "j_joker"
----                elseif set == "Planet"   then ckey = "c_pluto"
----                elseif set == "Spectral" then ckey = "c_incantation"
----                elseif set == "Tag"      then ckey = "tag_handy"
----                end

----                if not ckey then
----                   sendWarnMessage("No default for set " .. set .. " found, defaulting to Tarot", "Neonflame - Bakers Dozen")
----                   ckey = "c_fool"
----                end

----                SMODS.add_card { key = ckey }
----                card:juice_up(0.5, 0.5)
----                return true
----             end
----          }))
----       end
----    end
---- }

---- SMODS.Joker {
----    key = "sappy",
----    name = "Sappy",

----    atlas = "layerjoker",
----    pos = { x = 2, y = 0 },
----    soul_pos = { x = 3, y = 0 },

----    config = { extra = { xmhandgain = 0.2 } },
----    rarity = 4,
----    price = 20,
----    blueprint_compat = true,
----    demicolon_compat = true,
----    perishable_compat = true,
----    eternal_compat = true,

----    loc_vars = function(self, info_queue, card)
----       return { vars = { card.ability.extra.xmhandgain } }
----    end,

----    calculate = function(self, card, context)
----       if context.pre_discard then
----          local carddraw = 0
----          for i, c in ipairs(context.full_hand) do
----             if not context.blueprint then
----                G.E_MANAGER:add_event(Event({
----                 blocking = false,
----                 func = function()
----                    if G.STATE ~= G.STATES.DRAW_TO_HAND then return false end
----                    -- gimmie my quickdraws damnit
----                    draw_card(G.discard, G.hand, nil, "up", true, c, 0.05)
----                    return true
----                 end                           
----                }))
----                carddraw = i
----             end


----             G.E_MANAGER:add_event(Event({
----                 func = function()
----                    c:juice_up(0.5, 0.5)
----                    card:juice_up(0.5, 0.5)

----                    return true
----                 end
----             }))

----             c.ability.perma_h_x_mult = (c.ability.perma_h_x_mult or 1) + card.ability.extra.xmhandgain
----          end

----          if carddraw > 0 then
----             G.E_MANAGER:add_event(Event({
----                 blocking = false,
----                 func = function()
----                    if G.STATE ~= G.STATES.SELECTING_HAND then return false end
----                    SMODS.draw_cards(carddraw)
----                    return true
----                 end
----             }))
----          end

         
----          return {
----             extra = {
----                card = card,
----                message = localize("k_upgrade_ex"),
----                colour = G.C.MULT
----             },
----          }
----       end
----    end
---- }

SMODS.Joker {
    key = "refund",
    name = "Money Back Guarantee",

    atlas = "jokers1",
    pos = { x = 5, y = 1 },

    config = { extra = { chance = 2 } },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    demicolon_compat = false,

    loc_vars = function(self, info_queue, card)
    local num, den = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, "nflame_refund")
        return { vars = { num, den } }
    end,

    calculate = function(self, card, context)
    if context.selling_card and context.card and context.card.ability.consumeable 
        and not context.card.ability.nflame_refundjeapordy then
            if SMODS.pseudorandom_probability(card, "nflame_refund", 1, card.ability.extra.chance) then
                local ncard = SMODS.add_card { set = context.card.ability.set }
                ncard.ability.nflame_refundjeapordy = true
                return {
                    message = "Full Refund!"
                }
            end
        end
    end
}

SMODS.Joker {
    key = "rapdog",
    name = "Parappa",

    atlas = "placeholders",
    pos = { x = 0, y = 0 },

    config = { extra = { xmgain = 0.02, xm = 1 }, immutable = { rank = "Ace", retrigger = 3 } },
    rarity = 3,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    demicolon_compat = true,

    loc_vars = function(self, info_queue, card)
        local rank = localize(card.ability.immutable.rank, "ranks")
        return { vars = { card.ability.extra.xmgain, card.ability.immutable.retrigger, rank, card.ability.extra.xm } }
    end,

    calculate = function(self, card, context)
        if context.before then
            local lead = context.scoring_hand[1]
            if not lead then return end -- thanks cass
            if SMODS.has_no_rank(lead) then return end

            if lead.base.value == card.ability.immutable.rank then
                card.ability.extra.xm = card.ability.extra.xm + card.ability.extra.xmgain
                return { message = localize("k_upgrade_ex") }
            end
        end

        if context.individual and context.cardarea == G.play then
            card.ability.immutable.rank = context.other_card.base.value
        end

            if context.joker_main or context.forcetrigger then
            if card.ability.extra.xm <= 1 then return end

            local accum = 1
            for i = 1, card.ability.immutable.retrigger do
                SMODS.calculate_effect({
                    remove_default_message = true,
                    xmult = card.ability.extra.xm,
                    sound = "nflame_rapdog_oops",
                    message = "Oops!"
                }, card)
                accum = accum * card.ability.extra.xm
            end

            accum = math.floor(accum * 10) / 10
            return { message = "X" .. accum .. " Combo!", color = G.C.MULT, sound = "nflame_rapdog_oops_end" }
        end
    end
}
