-- 00_patch_lovely.lua
-- Ensure Paperback always has its ranks_scored_this_ante table initialized
-- so that state_events.lua never tries to index a nil value.

SMODS.Atlas({
    key = "collagexvisjokers",
    path = "jonkers.png",
    px = 71,
    py = 95
})

SMODS.Sound {
   key = 'harken',
   path = 'harken.mp3'
}

SMODS.Sound {
   key = 'dad1',
   path = 'General_SmallHit_001.mp3'
}
SMODS.Sound {
   key = 'dad3',
   path = 'General_SmallHit_003.mp3'
}
SMODS.Sound {
   key = 'dad4',
   path = 'General_SmallHit_004.mp3'
}
SMODS.Sound {
   key = 'dad5',
   path = 'General_SmallHit_005.mp3'
}
SMODS.Sound {
   key = 'dad6',
   path = 'General_SmallHit_006.mp3'
}
SMODS.Sound {
   key = 'dad7',
   path = 'General_SmallHit_007.mp3'
}
SMODS.Sound {
   key = 'dad8',
   path = 'General_SmallHit_008.mp3'
}
SMODS.Sound {
   key = 'dad9',
   path = 'General_SmallHit_009.mp3'
}
SMODS.Sound {
   key = 'dad10',
   path = 'General_SmallHit_010.mp3'
}
SMODS.Sound {
   key = 'dad11',
   path = 'General_SmallHit_011.mp3'
}
SMODS.Sound {
   key = 'dad12',
   path = 'General_SmallHit_012.mp3'
}
SMODS.Sound {
   key = 'dad13',
   path = 'General_SmallHit_013.mp3'
}
SMODS.Sound {
   key = 'dad14',
   path = 'General_SmallHit_014.mp3'
}
SMODS.Sound {
   key = 'dad15',
   path = 'General_SmallHit_015.mp3'
}

SMODS.Joker{
	key = "ena",
    loc_txt = {
        name = 'ENA',
        text = {
        "{C:white,X:mult}X#1#{} Mult if scoring hand",
        "contains at least {C:attention}two{}",
        "unique {C:money}Face{} {C:blue}Card{} ranks",
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 0, y = 0 },
	cost = 7,
	config = { extra = { xmult = 3 } },
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            local ids = {}
            for key, value in pairs(context.scoring_hand) do
                if value:is_face() then
                    ids[value:get_id()] = true
                end
            end
            print("context in here")
            print(inspect(ids))
            local num_diff = 0
            for k, v in pairs(ids) do
                num_diff = num_diff + 1
            end
            if num_diff >= 2 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
		end
	end
}

SMODS.Joker{
	key = "ena2",
    loc_txt = {
        name = 'ENA',
        text = {
            {"Scored {C:inactive}Face{} {C:mult}Cards{} have",
            "a {C:green}#3# in #4#{} chance",
            "to give {C:money}$#2#"},
            {"Otherwise, they",
            "give {C:white,X:mult}X#1#{} Mult"}
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 1, y = 0 },
	cost = 10,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 1.5, dollars = 2, odds = 2 } },
	loc_vars = function(self, info_queue, card)
        n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ena2')
		return { vars = { card.ability.extra.xmult, card.ability.extra.dollars, n, d } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            if SMODS.pseudorandom_probability(card, pseudoseed('collage_ena2'), 1, card.ability.extra.odds, 'collage_ena2') then
                return {
                    dollars = card.ability.extra.dollars
                }
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
		end
	end
}


SMODS.Joker{
	key = "sunflower_seeds",
    loc_txt = {
        name = 'Seeds of Creativity',
        text = {
            {"Scored {C:attention}Queens{} have a",
            "{C:green}#1# in #2#{} chance to",
            "create an {C:art}Art Card{}",
            "{C:inactive,s:0.8}(Who does this represent?)"},
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 2,
	atlas = "collagexvisjokers",
	pos = { x = 2, y = 0 },
	cost = 7,
	config = { extra = { odds = 3 } },
	loc_vars = function(self, info_queue, card)
        n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ena2')
		return { vars = { n, d } }
	end,
    credit = {
        art = "stickieanimates",
        code = "base4",
        concept = "base4"
    },
	calculate = function(self, card, context)
		if context.individual and context.other_card:get_id() == 12 and SMODS.pseudorandom_probability(card, pseudoseed('collage_sunflower'), 1, card.ability.extra.odds, 'collage_sunflower') then
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    card = card,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                local cardd = create_card('art', G.consumeables, false, nil, true, true, nil, 'art')
                                if cardd.config.center.key ~= 'c_artb_art_blend' and
                                cardd.config.center.key ~= 'c_artb_art_glitter' and
                                cardd.config.center.key ~= 'c_artb_art_scissors' and -- heavy bias for these 5 cards
                                cardd.config.center.key ~= 'c_artb_art_imitation' and
                                cardd.config.center.key ~= 'c_artb_art_auction'
                                then
                                    cardd:remove()
                                    cardd = create_card('art', G.consumeables, false, nil, true, true, nil, 'art')
                                end
                                G.consumeables:emplace(cardd)
                                cardd:start_materialize()
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                    end
                }
            end
        end
	end
}

SMODS.Joker{
	key = "deepfried",
    loc_txt = {
        name = 'Deep-Fried Joker',
        text = {
            {"{C:white,X:mult}X#1#{} Mult"},
            {"Each {C:attention}Poker Hand{} has",
            "{C:planet}Level 1{} base {C:chips}Chips"}
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 5, y = 0 },
	cost = 7,
    credit = {
        art = "WarpedCloset",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmultbefore } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.modify_hand then
            return {
                chips = G.GAME.hands[context.scoring_name].s_chips - hand_chips
            }
        end
	end
}

--[[SMODS.Joker{
	key = "oldnotebook",
    loc_txt = {
        name = 'That One Empty Notebook',
        text = {
            "Redo",
            "every {C:attention}Boss Blind",
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 1,
	atlas = "collagexvisjokers",
	pos = { x = 5, y = 0 },
	cost = 6,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 3, xmultbefore = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmultbefore } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        if context.initial_scoring_step then
            return {
                xmult = card.ability.extra.xmultbefore
            }
        end
	end
}]]

SMODS.Joker{
	key = "harken",
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 0, y = 2 },
	cost = 9,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "Monachrome"
    },
	config = { extra = { xmult = 1, xmult_mod = 0.2, active = false, destroyed_something = false } },
	loc_vars = function(self, info_queue, card)
		return { key = card.ability.extra.active and "j_collage_vis_harken" or "j_collage_vis_harken_inactive", set = "Joker", vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
    update = function(self, card, dt)
        if card.ability.extra.active then
            card.children.center:set_sprite_pos({x = 1, y = 2})
        else
            card.children.center:set_sprite_pos({x = 0, y = 2})
        end
    end,
	calculate = function(self, card, context)
        if context.cards_destroyed or context.remove_playing_cards then
            card.ability.extra.xmult = card.ability.extra.xmult + #context.removed * card.ability.extra.xmult_mod
            card.ability.extra.destroyed_something = true
            if not card.ability.extra.active then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        card.ability.extra.active = true
                        play_sound('collage_vis_harken', 1, 0.75)
                        return true
                    end})
                )
            end
            return {
                message = localize('k_upgrade_ex')
            }
        end
		if context.joker_main and card.ability.extra.active then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.main_eval then
            if card.ability.extra.destroyed_something then
                card.ability.extra.destroyed_something = false
                if not card.ability.extra.active then
                    card.ability.extra.active = true
                    play_sound('collage_vis_harken')
                end
            else
                if card.ability.extra.active then
                    card.ability.extra.active = false
                    return {
                        message = "Dampened..."
                    }
                end
            end
        end
	end
}

SMODS.Joker{
	key = "joker_smokers",
    loc_txt = {
        name = "Joker Smokers",
        text = {
            "When score {C:red,E:1}Catches Fire{},",
            "the next {C:attention}#1#{} hands give",
            "{C:money}$#2#{} when played",
            "{C:inactive}(#3#)"
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 1,
	atlas = "collagexvisjokers",
	pos = { x = 1, y = 1 },
	cost = 6,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { hands = 3, dollars = 3, left = 0, primed = false, thisturn = false } },
	loc_vars = function(self, info_queue, card)
        local left = ""
        if card.ability.extra.left == 0 then
            left = "Need a light..."
        else
            left = card.ability.extra.left .. " hands left"
        end
		return { vars = { card.ability.extra.hands, card.ability.extra.dollars, left } }
	end,
	calculate = function(self, card, context)
        if not card.ability.extra.thisturn and context.ccc_fire and card.ability.extra.left < card.ability.extra.hands --[[and (context.before or context.after or context.final_scoring_step or context.initial_scoring_step)]] and not context.blueprint then
            if card.ability.extra.left == 0 then
                card.ability.extra.left = 3
                card.ability.extra.primed = true
                return {
                    message = "Thanks.",
                }
            else
                card.ability.extra.left = 3
                return {
                    message = "Relit!"
                }
            end
        elseif context.ccc_fire then
            card.ability.extra.thisturn = true
        end

        if context.joker_main then
            if card.ability.extra.left > 0 and card.ability.extra.primed then
                card.ability.extra.left = card.ability.extra.left - 1
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end

        if context.after then
            card.ability.extra.thisturn = false
            if card.ability.extra.left > 0 then
                card.ability.extra.primed = true
            elseif card.ability.extra.primed then
                card.ability.extra.primed = false
                return {
                    message = "Need a light..."
                }
            end
        end
	end
}

SMODS.Joker{
	key = "mafioso",
    loc_txt = {
        name = "Mafioso",
        text = {
            {"Pay off your",
            "balance each hand,",
            "{C:money}$#1#{} at a time",
            "{C:inactive}({C:money}$#2#{C:inactive} remaining)"},
            {"Balances {C:purple}#3#%{} of",
            "{C:mult}Mult{} and {C:chips}Chips"},
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 4, y = 1 },
	cost = 2,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { balance = 80, payment = 2, balance_percent = 50 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.payment, card.ability.extra.balance, card.ability.extra.balance_percent } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            card.ability.extra.balance = card.ability.extra.balance - card.ability.extra.payment
            if card.ability.extra.payment > 0 and card.ability.extra.balance <= 0 then
                card.ability.extra.balance = 0
                card.ability.extra.payment = 0
                return {
                    message = "Debt-free!",
                    aij_balance_percent = card.ability.extra.balance_percent/100
                }
            end
            return {
                dollars = card.ability.extra.payment > 0 and -card.ability.extra.payment or nil,
                aij_balance_percent = card.ability.extra.balance_percent/100
            }
        end
	end
}

SMODS.Joker{
	key = "am",
    loc_txt = {
        name = "Hatred",
        text = {
            "If played hand is",
            "exactly {C:attention}5 Face Cards,",
            "each {C:attention}numbered{} card held",
            "in hand gives {C:white,X:mult}X#1#{} Mult",
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 0, y = 1 },
	cost = 8,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4 & Monachrome"
    },
	config = { extra = { xmult = 1.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmultbefore } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local faces = 0
            for key, value in pairs(G.play.cards) do
                if value:is_face() then
                    faces = faces + 1
                else
                    return
                end
            end

            if faces == 5 and not context.other_card:is_face() and context.other_card:get_id() ~= 14 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
	end
}

SMODS.Joker{
	key = "octodad",
    loc_txt = {
        name = "Dad Joker",
        text = {
            "Each {C:attention}2{}, {C:attention}4{}, and {C:attention}8{}",
            "held in hand gives",
            "{C:white,X:mult}X#1#{} Mult",
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 2,
	atlas = "collagexvisjokers",
	pos = { x = 3, y = 1 },
	cost = 7,
    credit = {
        art = "stickieanimates",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 1.25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmultbefore } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round and (context.other_card:get_id() == 2 or context.other_card:get_id() == 4 or context.other_card:get_id() == 8) then
            local sound = math.random(2, 15)
            if sound == 2 then sound = 1 end
            return {
                xmult = card.ability.extra.xmult,
                func = function ()
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                            --play_sound("collage_vis_dad"..sound, 1, 0.4)
                            return true
                        end
                    }))
                end
            }
        end
	end
}

--[[SMODS.Joker{
	key = "missingtexture",
    loc_txt = {
        name = "go install cs and come back",
        text = {
            {"When blind is selected,",
            "{C:attention}permanently copy{} the ability",
            "of the {C:attention}Joker{} to the right"},
            {"Destroyed if copied Joker",
            "is ever removed"}
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 3,
	atlas = "collagexvisjokers",
	pos = { x = 5, y = 0 },
	cost = 7,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 3, xmultbefore = 0.5 } },
	loc_vars = function(self, info_queue, card)
        if card.area == G.jokers and G.jokers.cards[#G.jokers.cards] ~= card and G.jokers.cards[#G.jokers.cards].config.center.blueprint_compat then
            card.ability.blueprint_compat = ' '..localize('k_compatible')..' '
            card.ability.bubble_colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
        else
            card.ability.blueprint_compat = ' '..localize('k_incompatible')..' '
            card.ability.bubble_colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
        end
        return {main_end = (card.area and card.area == G.jokers) and {
            {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "m", colour = card.ability.bubble_colour, r = 0.05, padding = 0.06}, nodes={
                    {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
                }}
            }}}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
	end
}]]

SMODS.Joker{
	key = "slenderman",
    loc_txt = {
        name = "8 Jokes",
        text = {
            "Every 8 {C:blue}hands{} or",
            "{C:red}discards{}, this Joker gives",
            "{C:white,X:mult}X#1#{} Mult next hand",
            "{C:inactive}(#2#)"
        }
    },
	unlocked = true,
    discovered = false, 
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	rarity = 2,
	atlas = "collagexvisjokers",
	pos = { x = 2, y = 1 },
	cost = 7,
    credit = {
        art = "Monachrome",
        code = "base4",
        concept = "base4"
    },
	config = { extra = { xmult = 4, timer = 8 } },
	loc_vars = function(self, info_queue, card)
        local string = "Active next hand!"
        if card.ability.extra.timer > 1 then
            string = card.ability.extra.timer .. " left"
        end
		return { vars = { card.ability.extra.xmult, string } }
	end,
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.timer <= 1 then
            card.ability.extra.timer = 8
            return {
                xmult = card.ability.extra.xmult
            }
        elseif context.joker_main or context.pre_discard then
            card.ability.extra.timer = card.ability.extra.timer - 1
            if card.ability.extra.timer == 1 then
                juice_card_until(card, function() return card.ability.extra.timer > 1 end)
                return {
                    message = "Active!"
                }
            end
        end
	end
}