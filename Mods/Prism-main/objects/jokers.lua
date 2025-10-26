SMODS.Atlas {
    key = 'jokers',
    path = "jokers.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'crossmodjokers',
    path = "compat/jokers.png",
    px = 71,
    py = 95
}

function G.PRISM.Joker(table)
	if table.dependency or table.dependency == nil then
		SMODS.Joker(table)
	end
end
G.PRISM.Joker({
	key = "polydactyly",
	atlas = "jokers",
	pos = {x=2,y=2},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(1)
		SMODS.change_discard_limit(1)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1)
		SMODS.change_discard_limit(-1)
	end,
})
G.PRISM.Joker({
	key = "racecar",
	atlas = "jokers",
	pos = {x=3,y=7},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, mult = 0,chips_gain = 3, mult_gain = 1}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.chips_gain, center.ability.extra.mult_gain, center.ability.extra.chips, center.ability.extra.mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return{
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint then
			local mod = G.GAME.current_round.hands_left
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain * mod
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain * mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.FILTER,
				card = card
			}
		end
	end
})
G.PRISM.Joker({
	key = "motherboard",
	atlas = "jokers",
	pos = {x=1,y=4},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {chips = 0, extra = 2},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra, center.ability.chips} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return{
			chips = card.ability.chips
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.other_card.ability.set ~= 'Enhanced' and not context.other_card.seal and not context.other_card.edition then
				card.ability.chips = card.ability.chips + card.ability.extra
				return {
					focus = card,
					colour = G.C.CHIPS,
					message = localize{type = 'variable', key = 'a_prism_chips', vars = {card.ability.extra}},
					card = card,
				}
			else
				card.ability.chips = math.max(card.ability.chips - card.ability.extra,0)
				return {
					focus = card,
					colour = G.C.CHIPS,
					message = localize{type = 'variable', key = 'a_prism_chips_minus', vars = {card.ability.extra}},
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "sculptor",
	atlas = "jokers",
	pos = {x=1,y=3},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 4},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return {
		vars = {center.ability.extra}
		}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_stone') or SMODS.has_enhancement(v,'m_sarc_luminice') or SMODS.has_enhancement(v,'m_vis_brick') or SMODS.has_enhancement(v,'m_artb_marble') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			if SMODS.has_enhancement(context.other_card,'m_stone') or SMODS.has_enhancement(context.other_card,'m_sarc_luminice') or SMODS.has_enhancement(context.other_card,'m_vis_brick') or SMODS.has_enhancement(context.other_card,'m_artb_marble') then
            	context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    card = card
                }
			end
        end
    end
})
G.PRISM.Joker({
	key = "day",
	atlas = "jokers",
	pos = {x=2,y=7},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1,trigger = false},
	yes_pool_flag = "day_can_spawn",
	loc_vars = function(self, info_queue, center)
		if not center.fake_card then
			info_queue[#info_queue + 1] = G.P_CENTERS.j_prism_night
			info_queue[#info_queue + 1] = PB_UTIL.suit_tooltip('light')
		end
	end,
	calculate = function(self, card, context)
		if context.before then
			local right_suits, all_cards = 0, 0
			for k, v in ipairs(G.play.cards) do
				all_cards = all_cards + 1
				if PB_UTIL.is_suit(card, 'light') then
					right_suits = right_suits + 1
				end
			end
			if right_suits == all_cards then 
				card.ability.trigger = true
			end
		end
		if context.after and card.ability.trigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.j_prism_night)
					return true
				end
			}))
			return {
				message = localize('k_sunset'),
				card = card
			}
		end
		if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.night_can_spawn = false
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.night_can_spawn = true
	end
})
G.PRISM.Joker({
	key = "night",
	atlas = "jokers",
	pos = {x=2,y=8},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1,trigger = false},
	yes_pool_flag = "night_can_spawn",
	loc_vars = function(self, info_queue, center)
		if not center.fake_card then
			info_queue[#info_queue + 1] = G.P_CENTERS.j_prism_day
			info_queue[#info_queue + 1] = PB_UTIL.suit_tooltip('dark')
		end
	end,
	calculate = function(self, card, context)
		if context.before then
			local right_suits, all_cards = 0, 0
			for k, v in ipairs(G.play.cards) do
				all_cards = all_cards + 1
				if PB_UTIL.is_suit(v, 'dark') then
					right_suits = right_suits + 1
				end
			end
			if right_suits == all_cards then 
				card.ability.trigger = true
			end
		end
		if context.after and card.ability.trigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.j_prism_day)
					return true
				end
			}))
			return {
				message = localize('k_sunrise'),
				card = card
			}
		end
		if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.day_can_spawn = false
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.day_can_spawn = true
	end
})
G.PRISM.Joker({
	key = "whiskey",
	atlas = "jokers",
	pos = {x=2,y=3},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {required = 4,current = 0,done = false},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = 'tag_double', set = 'Tag'}
		return { vars = {center.ability.required,center.ability.current} }
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and not context.blueprint then
            if context.other_card:get_id() == 11 then
                card.ability.current = card.ability.current + 1
				if card.ability.current >= card.ability.required and not card.ability.done then
					card.ability.current = 0
					card.ability.done = true
					G.E_MANAGER:add_event(Event({
						func = (function()
							add_tag(Tag('tag_double'))
							play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
							play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						   return true
					   end)
					}))
				elseif card.ability.current > card.ability.required and card.ability.done then
					card.ability.current = card.ability.required
					return nil 
				end
				return {
					message = (card.ability.current == 0) and localize('k_plus_double') or (card.ability.current..'/'..card.ability.required),
					colour = G.C.FILTER,
					focus = card,
					card = card
				}
            end
        end
		if context.setting_blind and not context.blueprint then
			card.ability.done = false
		end
    end
})
G.PRISM.Joker({
	key = "solo_joker",
	atlas = "jokers",
	pos = {x=1,y=14},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 3, trigger = false},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra} }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
			if #context.full_hand == 1 then card.ability.trigger = true else card.ability.trigger = false end
		end
        if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
    end
})
G.PRISM.Joker({
	key = "economics",
	atlas = "jokers",
	pos = {x=1,y=8},
	rarity = 3,
	cost = 1,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {x_mult = 1,gain = 0.1,dollars = 2}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.gain,center.ability.extra.dollars,center.ability.extra.x_mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = to_number(to_big(card.ability.extra.x_mult)),
			}
		end
		if context.setting_blind and not context.blueprint then
			local x_mult_gain = card.ability.extra.gain*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars)
			ease_dollars(-G.GAME.dollars, true)
			if to_big(x_mult_gain) > to_big(0) then 
				card.ability.extra.x_mult = card.ability.extra.x_mult + to_number(to_big(x_mult_gain))
				return {
					focus = card,
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "elf",
	atlas = "jokers",
	pos = {x=1,y=13},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 2.5, active = false}},
	loc_vars = function(self, info_queue, center)
		local active = center.ability.extra.active
		return {
			vars = {center.ability.extra.x_mult},
			main_end = (center.area and center.area == G.jokers) and {{
				n = G.UIT.C,
				config = {
					align = "bm",
					minh = 0.4
				},
				nodes = {{
					n = G.UIT.C,
					config = {
						ref_table = center,
						align = "m", 
						colour = active and G.C.GREEN or G.C.RED,
						r = 0.05, 
						padding = 0.06,
					},
					nodes = {{
						n = G.UIT.T,
						config = {
							text = ' '..localize(active and 'k_active' or 'k_inactive')..' ',
							colour = G.C.UI.TEXT_LIGHT,
							scale = 0.32*0.9
						}
					}}
				}}
			}}
		}
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set  == 'Myth' and not context.blueprint and card.ability.extra.active == false then
            card.ability.extra.active = true
			return {
				colour = G.C.GREEN,
				message = localize('k_active_ex')
			}
        end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint and card.ability.extra.active then
			card.ability.extra.active = false
			return {
				colour = G.C.RED,
				message = localize('k_inactive_ex')
			}
		end
		if context.joker_main and card.ability.extra.active then
			return {
				xmult = card.ability.extra.x_mult,
				card = card
			}
		end
    end
})

--[[G.PRISM.Joker({
	key = "vaquero",
	atlas = "jokers",
	pos = {x=1,y=2},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 1.75}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return {
		vars = {center.ability.extra.x_mult}
		}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_wild') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if SMODS.has_enhancement(context.other_card,'m_wild') then
                return {
                    xmult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})]]
G.PRISM.Joker({
	key = "murano",
	atlas = "jokers",
	pos = {x=2,y=9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {odds = 3}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		return { vars = {
			"" .. (G.GAME and G.GAME.probabilities.normal or 1), 
			center.ability.extra.odds
		}}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_glass') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
			local trigger = false
            for k, v in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(v,'m_glass') and not v.edition and not v.debuff then 
					if pseudorandom('murano') < G.GAME.probabilities.normal/card.ability.extra.odds then
						trigger = true
						local edition = poll_edition('bismuth', nil, nil, true, {
							'e_foil',
							'e_holo',
							'e_polychrome'
					    })
                        v:set_edition(edition)
						G.E_MANAGER:add_event(Event({
							func = function()
								v:juice_up()
								return true
							end
						}))
					end
				end
			end
			if trigger then
				return {
					message = localize('k_edition_ex'),
                    colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
    end
	
})

G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "amethyst",
	atlas = "jokers",
	pos = {x=1,y=7},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {x_mult = 1, extra = 0.15},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_prism_crystal
		return {vars = {center.ability.x_mult,center.ability.extra}}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_prism_crystal') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			return {
				xmult = card.ability.x_mult
			}
		end
		if context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint then
			if SMODS.has_enhancement(context.other_card,'m_prism_crystal') then
				card.ability.x_mult = card.ability.x_mult + card.ability.extra
				return {
					focus = card,
					colour = G.C.RED,
					message = localize('k_upgrade_ex'),
					card = card,
				}
			end
        end
    end
	
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "minstrel",
	atlas = "jokers",
	pos = {x=1,y=0},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blind.boss and not (context.blueprint_card or card).getting_sliced then
			G.PRISM.create_card('Myth',G.consumeables, nil, nil, nil, nil, nil, 'minst', function(new_card)
				play_sound("timpani")
				card:juice_up(0.3, 0.5)
			end)
			return {}
		end
	end
})
G.PRISM.Joker({
	key = "whale",
	atlas = "jokers",
	pos = {x=3,y=9},
	soul_pos = {x=3,y=10},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {planets = {},levels = 0}},
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.levels}}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not card.ability.extra.planets[context.consumeable.config.center_key] then
			card.ability.extra.planets[context.consumeable.config.center_key] = true
			card.ability.extra.levels = card.ability.extra.levels + 1
			return {
				card = card,
				message = localize('k_upgrade_ex')
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and G.GAME.blind.boss then
			local _hand, _tally = nil, 0
			for _, v in ipairs(G.handlist) do
				if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
					_hand = v
					_tally = G.GAME.hands[v].played
				end
			end
			local levels = card.ability.extra.levels
			card.ability.extra.planets = {}
			card.ability.extra.levels = 0
			if levels > 0 then
				return {
					level_up = levels,
					level_up_hand = _hand,
					card = card
				}
			end
			return {}
		end
	end
})
--[[ G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "schrodinger",
	atlas = "jokers",
	pos = {x=2,y=12},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 0},
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_prism_double') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card.config.center == G.P_CENTERS.m_prism_double then
				card.ability.extra = card.ability.extra + 1
				return {
					message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
					card = card
				}
		  	else
				card.ability.extra = 0
			end
		end
		if context.after and not context.blueprint then
		  	card.ability.extra = 0
		end
	end
}) ]]
G.PRISM.Joker({
	key = "reverse_card",
	atlas = "jokers",
	pos = {x=1,y=5},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_ortalab_greyscale
	end,
	add_to_deck = function(self, card)
		card:set_edition("e_ortalab_greyscale")
	end

})

G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "romantic",
	atlas = "jokers",
	pos = {x=2,y=13},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local myth = G.GAME.last_myth and G.P_CENTERS[G.GAME.last_myth] or nil
		local last_myth = myth and localize{type = 'name_text', key = myth.key, set = myth.set} or localize('k_none')
		local colour = not myth and G.C.RED or G.C.GREEN
		return {
			main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = ' '..last_myth..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                    }}
                }}
            }
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and not context.before and not context.after and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			local hearts = 0
			local spades = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Hearts") then hearts = hearts + 1 end
				if context.scoring_hand[i]:is_suit("Spades") then spades = spades + 1 end
			end
			if hearts >= 1 and spades >= 1 and G.GAME.last_myth then
				G.PRISM.create_card('Myth',G.consumeables, nil, nil, nil, nil, G.GAME.last_myth, 'return', function(new_card)
					play_sound("timpani")
					card:juice_up(0.3, 0.5)
				end)
				return {}
			end
		end
	end
})
G.PRISM.Joker({
	key = "pie",
	atlas = "jokers",
	pos = {x=2,y=1},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {index = 1,x_mult = 3.14}},
	loc_vars = function(self, info_queue, center)
		local rank = string.sub(G.PRISM.PI,center.ability.extra.index,center.ability.extra.index)
		if rank == "1" then rank = "Ace" end
		if rank == "0" then rank = "10" end
		return{ vars = {localize(rank,'ranks'),
		center.ability.extra.x_mult,
		string.sub(G.PRISM.PI,center.ability.extra.index + 1,center.ability.extra.index + 5)}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			local rank = string.sub(G.PRISM.PI,card.ability.extra.index,card.ability.extra.index)
			if rank == "1" then rank = "Ace" end
			if rank == "0" then rank = "10" end
			if context.other_card.config.card.value == rank then
				if not context.blueprint then
					card.ability.extra.index = card.ability.extra.index + 1
					if card.ability.extra.index > G.PRISM.PI:len() then card.ability.extra.index = 1 end
				end
				return {
					xmult = card.ability.extra.x_mult,
					card = card
				}
			end
        end
    end
	
})
G.PRISM.Joker({
	key = "plasma_lamp",
	atlas = "jokers",
	pos = {x=1,y=9},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {poker_hand_1 = 'High Card',poker_hand_2 = 'Three of a Kind',reset = false},
	loc_vars = function(self, info_queue, center)
		return {vars = {localize(center.ability.poker_hand_1, 'poker_hands'),localize(center.ability.poker_hand_2, 'poker_hands')}}
	end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.reset = false
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.poker_hand_1 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
		_poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible and k ~= card.ability.poker_hand_1 then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and ((context.end_of_round and not context.blueprint) or (context.after and card.ability.reset)) then
			card.ability.reset = false
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.poker_hand_1 and k ~= card.ability.poker_hand_2 then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.poker_hand_1 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
			_poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.poker_hand_1 and k ~= card.ability.poker_hand_2 then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
			return {
				message = localize('k_reset')
			}
		end
		if context.joker_main then
			if context.scoring_name == card.ability.poker_hand_1 or context.scoring_name == card.ability.poker_hand_2 then
				local tot = hand_chips + mult
				hand_chips = math.floor(tot/2)
				mult = math.floor(tot/2)
				update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
				card.ability.reset = true
				return {
					message = localize("k_balanced"),
					colour = { 0.8, 0.45, 0.85, 1 },
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "razor_blade",
	atlas = "jokers",
	pos = {x=0,y=10},
	rarity = 3,
	cost = 6,
	pixel_size = { w = 47, h = 91},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 0.3},
	loc_vars = function(self, info_queue, center)
		local x_mult = 1
		for k, v in pairs(G.GAME.prism_start_deck_ranks or {}) do
			local is_present = false
			for _k, _v in pairs(G.playing_cards or {}) do
				if not is_present and _v:get_id() == v then is_present = true end
			end
			if not is_present then
				x_mult = x_mult + center.ability.extra
			end
		end
		return {vars = {center.ability.extra, x_mult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local x_mult = 1
			for k, v in pairs(G.GAME.prism_start_deck_ranks or {}) do
				local is_present = false
				for _k, _v in pairs(G.playing_cards or {}) do
					if not is_present and _v:get_id() == v then is_present = true end
				end
				if not is_present then
					x_mult = x_mult + card.ability.extra
				end
			end
			return {
				xmult = x_mult
			}
		end
	end,
})
G.PRISM.Joker({
	key = "swiss",
	atlas = "jokers",
	pos = {x=2,y=14},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 8, mult = 2, x_mult = 0.05,odds = 2}},
	loc_vars = function(self, info_queue, center)
		return {
		vars = {center.ability.extra.chips,center.ability.extra.mult,center.ability.extra.x_mult,G.GAME.probabilities.normal,center.ability.extra.odds}
		}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			--if pseudorandom('swiss') < G.GAME.probabilities.normal / card.ability.extra.odds then
				local poll = pseudorandom('swiss_poll')
				local color = nil
				if poll < 1/3 then
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
					color = G.C.CHIPS
				elseif poll < 2/3 then
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
					color = G.C.MULT
				else
					context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
					context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.x_mult
					color = G.C.MULT
				end
                return {
                    message = localize('k_upgrade_ex'),
					colour = color,
                    card = card
                }
			--end
        end
    end
	
})
G.PRISM.Joker({
	key = "hypercube",
	atlas = "jokers",
	pos = {x=2,y=10},
	soul_pos = {x=2,y=11},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {e_mult = 1.33},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.e_mult} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			local hands = evaluate_poker_hand(G.hand.cards)
      		local amount = #hands["Four of a Kind"]
			if amount > 0 then
				return {
					emult = card.ability.e_mult
				}
			end
		end
	end
}) 

G.PRISM.Joker({
	key = "prism",
	atlas = "jokers",
	pos = {x=0,y=14},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
})

local orig_is_suit = Card.is_suit
function Card.is_suit(self, suit, bypass_debuff, flush_calc)
	if next(find_joker('j_prism_prism')) then
		if not (self.debuff and not bypass_debuff) and G.PRISM.is_numbered(self) then
            return true
		end
	end
    return orig_is_suit(self, suit, bypass_debuff, flush_calc)
end
--[[
G.PRISM.Joker({
	key = "harlequin",
	atlas = "jokers",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 0, y = 5 },
	rarity = 4,
	cost = 20,
	unlocked = false,
	unlock_condition = {hidden = true},
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = { extra = { bonus = 0.1, x_mult = 1,suits = {}}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.bonus,center.ability.extra.x_mult} }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			card.ability.extra.suits = {}
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
		local upgrade = false
		if context.cardarea == G.play and context.individual and not context.blueprint then
			local suits = G.PRISM.get_suits({context.other_card})
			for k,v in pairs(suits) do
				if not card.ability.extra.suits[k] and v > 0 then
					card.ability.extra.suits[k] = true
					card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.bonus
					upgrade = true
				end
			end
			if upgrade then
				return {
					focus = card,
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
					card = card,
				}
			end
		end
	end,
	
})]]

--[[G.PRISM.Joker({
	key = "rigoletto",
	atlas = "jokers",
	pos = { x = 0, y = 7 },
	soul_pos = { x = 0, y = 8 },
	rarity = 4,
	cost = 20,
	unlocked = false,
	unlock_condition = {hidden = true},
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = 1, hand_size = 0},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra,center.ability.hand_size} }
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.hand_size)
	end,
	calculate = function(self, card, context)
		if (context.cardarea == G.jokers and context.before) or context.discard and context.other_card == context.full_hand[1] and not context.blueprint  then
			card.ability.hand_size = card.ability.hand_size + card.ability.extra
			G.hand:change_size(card.ability.extra)
			return {
				message = localize('k_upgrade_ex'),
				card = card,
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint  then
			G.hand:change_size(-card.ability.hand_size)
			card.ability.hand_size = 0
			return {
				card = card,
				message = localize('k_reset')
			}
		end
	end,
})]]

--[[ SMODS.Joker {
	dependency = G.PRISM.compat.finity,
    key = "roseclub",
    atlas = 'crossmodjokers',
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 1, y = 0 },
    cost = 10,
	soul_pos = { x = 1, y = 1 },
	calculate = function(self, card, context)
	end
} ]]