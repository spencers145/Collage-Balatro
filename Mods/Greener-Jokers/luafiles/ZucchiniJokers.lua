SMODS.Atlas {
	-- defines where the joker images are pulled from
	key = "ZucchinisVariousJokers",
	path = "ZucchinisVariousJokers.png",
	px = 71,
	py = 95
}


--for zucchini legendary
SMODS.optional_features.post_trigger = true
SMODS.get_optional_features()

-- nonsense line i dont care about that jokerguy told me to add thank you jokerguy! (talisman compatibility)
-- everything should be talisman compatible! i dont usually play with talisman though so idk the only thing it seemed like i needed to fix was Peninsula
to_big = to_big or function(x) return x end
-- initializes the food jokers just in case nothing else does (i dont really think this is actually needed since i'm not doing anything with the food pool, but i get scared and i do want to have my cross compatibility)
if not SMODS.ObjectType.Food then
	SMODS.ObjectType({
		key = "Food",
		default = "j_popcorn",
		cards = {
			["j_gros_michel"] = true,
			["j_egg"] = true,
			["j_ice_cream"] = true,
			["j_cavendish"] = true,
			["j_turtle_bean"] = true,
			["j_diet_cola"] = true,
			["j_popcorn"] = true,
			["j_ramen"] = true,
			["j_selzer"] = true,
		},
		inject = function(self)
			SMODS.ObjectType.inject(self)
		end,
	})
end
-- TUNA
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'tuna',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'Tuna',
		text = {
			'{C:chips}+#1#{} Chips',
			'Loses {C:money}$#2#{} of {C:attention}sell value{}',
			'at end of round',
			'{C:green,s:0.8}Art by NoahCrawfish{}'
		}
	},

	config = { extra = { chips = 60, price = 1 } },
	-- loc_vars gives your loc_text variables to work with, in the format of #n#, n being the variable in order.
	-- #1# is the first variable in vars, #2# the second, #3# the third, and so on.
	-- It's also where you'd add to the info_queue, which is where things like the negative tooltip are.
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.price } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 1 },
	-- Cost of card in shop.
	cost = 3,
	-- The functioning part of the joker, looks at context to decide what step of scoring the game is on, and then gives a 'return' value if something activates.
	calculate = function(self, card, context)
		if context.joker_main then
			-- give chips
			return {
				chips = card.ability.extra.chips
			}
		end
		-- lower sell value and say EW! or something
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra_value = card.ability.extra_value - card.ability.extra.price
			card:set_cost()
			return {
				message = "Yuck!",
			}
		end
	end
}
-- WHALE
SMODS.Joker {
	-- How the code refers to the joker.
	key = 'whale',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc_text is the actual name and description that show in-game for the card.
	loc_txt = {
		name = 'The Whale',
		text = {
			{'{C:attention}+#1#{} hand size'},
			{'{C:green}#2# in #3#{} chance to {C:red}decrease{}',
			'level of played poker hand'}
		}
	},

	config = { extra = { h_size = 3, numerator = 1, denominator = 4 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_whale') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { card.ability.extra.h_size, numerator, denominator } }
	end,

	rarity = 3,


	atlas = 'ZucchinisVariousJokers',

	pos = { x = 1, y = 1 },

	cost = 8,
	-- does the hand size portion
	add_to_deck = function(self, card, from_debuff)
		G.hand:change_size(card.ability.extra.h_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.extra.h_size)
	end,


	calculate = function(self, card, context)
		if context.before and context.main_eval and SMODS.pseudorandom_probability(card, 'znm_whale', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_whale') then
			if to_big(G.GAME.hands[context.scoring_name].level) > to_big(1) then
				if not context.check then
					return {
						level_up = -1,
						message = "Delicious...",
						colour = G.C.UI.TEXT_DARK
					}
				end
			end
		end
	end
}
--[[ 50 BALL
SMODS.Joker {
	key = '50ball',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = '50 Ball',
		text = {
			'This Joker gains {C:chips}+#2#{} Chips',
			'when a {C:tarot}Tarot{} card is used during a {C:attention}Blind{},',
			'resets when {C:attention}Boss Blind{} is defeated',
			'{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips){}',
		}
	},
	-- put all variables in here
	config = { extra = { chips = 0, chip_gain = 50 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 0 },
	-- Cost of card in shop.
	cost = 5,

	calculate = function(self, card, context)
		-- function that adds chips
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Tarot' and G.GAME.blind.in_blind then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.CHIPS,
			}
		end
		-- scoring
		if context.joker_main then
			return {
				chip_mod = card.ability.extra.chips,
				message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
			}
		end
		-- reset at end of round
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if G.GAME.blind.boss then
				card.ability.extra.chips = 0
				return {
					message = localize('k_reset')
				}
			end
		end
	end
}]]
--[[ COIN ON A STRING
SMODS.Joker {
	key = 'coinstring',
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Coin-on-a-String',
		text = {
			'{C:green}Rerolls{} are free, when rerolling,',
			'{C:green}#1# in #2#{} chance this',
			'Joker destroys itself and sets money to {C:money}$0{}'
		}
	},
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 13, rerolls = 999 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_coinstring') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 1 },
	-- Cost of card in shop.
	cost = 6,
	-- free rerolls! do not worry about it
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_free_rerolls(card.ability.extra.rerolls)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_free_rerolls(-card.ability.extra.rerolls)
	end,
	calculate = function(self, card, context)
		-- occasionally take all the money teehee
		if context.reroll_shop and not context.blueprint and SMODS.pseudorandom_probability(card, 'znm_coinstring', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_coinstring') then
			ease_dollars(-G.GAME.dollars, true)

			-- This part plays the animation.
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					-- This part destroys the card.
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true;
						end
					}))
					return true
				end
			}))
			return {
				message = "Caught!",
			}
		end
	end
}]]
--[[ DIZZY
SMODS.Joker {
	key = 'dizzy',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Dizzy',
		text = {
			'Retrigger all played cards',
			'if played hand contains',
			'{C:attention}#1#{} or fewer cards',
			'{C:green,s:0.8}Art by Worldwaker2{}'
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 1 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { repetitions = 1, size = 4 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.size } }
	end,

	-- checks if the player has not played a 5 card hand, like half joker
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and #context.full_hand <= card.ability.extra.size then
			return {
				repetitions = card.ability.extra.repetitions
			}
		end
	end
}]]

--[[ PLASTIC BAG
SMODS.Joker {
	key = 'plasticbag',
	blueprint_compat = true,
	-- i dont WANT this to be true but eternal is so buggy
	eternal_compat = true,
	perishable_compat = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Plastic Bag',
		text = {
			'{C:mult}+#1#{} Mult',
			'{C:green}#2# in #3#{} chance to become {C:attention}Eternal{}',
			'at end of round'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 15, numerator = 1, denominator = 6, } },

	loc_vars = function(self, info_queue, card)
		if not card.ability.eternal then
			info_queue[#info_queue + 1] = { key = 'eternal', set = 'Other' }
		end
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_plasticbag') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { card.ability.extra.mult, numerator, denominator, } }
	end,
	-- this code allows it to actually turn eternal while not allowing it to appear naturally eternal


	-- mult
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not card.ability.eternal then
			if SMODS.pseudorandom_probability(card, 'znm_plasticbag', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_plasticbag') then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.0,
					func = function()
						card:juice_up(0.3, 0.5)
						play_sound('tarot1')
						-- this makes it so the joker is able to be made eternal, it doesn't have innate eternal compatibility because i didnt want it to sometimes appear in the shop already eternal
						-- i get maybe this isnt super in line with vanilla behavior but cmonnnn its lame
						--self.eternal_compat = true
						card:set_eternal(true)
						--self.eternal_compat = false
						return true
					end
				}))

				return {
					message = "Eternal!"
				}
			else
				return {
					message = localize('k_safe_ex')
				}
			end
		end
	end
}
-- LANDLORD
SMODS.Joker {
	key = 'landlord',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Landlord',
		text = {
			'{C:chips}+#1#{} Chips',
			'{C:green}#2# in #3#{} chance to',
			'make a random Joker {C:attention}Rental{}',
			'when {C:attention}Blind{} is selected'
		}
	},
	rarity = 3,


	atlas = 'ZucchinisVariousJokers',

	pos = { x = 9, y = 0 },

	cost = 8,

	config = { extra = { chips = 200, numerator = 1, denominator = 2, joker_to_rental = 0, rentable_jokers = 0 } },

	loc_vars = function(self, info_queue, card)
		-- displays the rental tag in the same way that golden ticket explains what gold cards are
		info_queue[#info_queue + 1] = { key = 'rental', set = 'Other', vars = { G.GAME.rental_rate or 1 } }

		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_landlord') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { card.ability.extra.chips, numerator, denominator, } }
	end,
	calculate = function(self, card, context)
		-- chips
		if context.joker_main then
			return {
				chips = card.ability.extra.chips
			}
		end
		-- madness esque code which checks for all non-itself non-rental jokers and creates an array of possible candidates
		if context.setting_blind and not context.blueprint and SMODS.pseudorandom_probability(card, 'znm_landlord', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_landlord') then
			rentable_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.rental then
					rentable_jokers[#rentable_jokers + 1] =
						G.jokers.cards[i]
				end
				-- makes sure if theres no valid targets that it won't try to do things anyways, because that causes a crash. picks a joker to make rental
				if #rentable_jokers > 0 then
					joker_to_rental = pseudorandom_element(rentable_jokers, pseudoseed('znm_landlord'))
				end
			end
			-- makes the joker rental
			if #rentable_jokers > 0 then
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.0,
					func = (function()
						joker_to_rental:set_rental(true)
						joker_to_rental:juice_up()

						return true
					end)
				}))







				return {
					message = "Rent Increase!"
				}
			end
		end
	end


}

-- MAGNETIC JOKER
SMODS.Joker {
	key = 'magneticjoker',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Magnetic Joker',
		text = {
			'If first hand contains {C:attention}1{} card',
			'and no discards have been used,',
			'turn played card into a {C:attention}Steel{} card'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = {} },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
		return
	end,



	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function()
				return G.GAME.current_round.hands_played == 0 and
					G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES
			end
			juice_card_until(card, eval, true)
		end
		if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 and #context.full_hand == 1 then
			context.full_hand[1]:set_ability('m_steel', nil, true)
		end
	end
}]]
-- HONEYPOT
SMODS.Joker {
	key = 'honeypot',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Honey Pot',
		text = {
			'This Joker gains {C:mult}+#2#{} Mult',
			'when a {C:attention}Gold{} card is held in hand',
			'at end of round',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}',
			'{C:green,s:0.8}Art by dewdrop{}'
		}
	},
	rarity = 2,
	discovered = false,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 3 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,

	-- makes it gated behind having a gold card
	-- actually might be against this?
	--[[
	in_pool = function(self, args)
		if G.deck and G.deck.cards then
			for j = 1, #G.deck.cards do
				if G.deck.cards[j].config.center.key == 'm_gold' then
					return true
				end
			end
		end
	end,
	]] --
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		-- thanks somethingcom515 for the context here
		if context.individual and context.end_of_round and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, "m_gold") and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				-- card eval whatever whatever makes it so it displays the upgrade text on the joker (card) instead of the individual gold cards
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize('k_upgrade_ex'),
					colour = G.C.MONEY
				}),

			}
		end
	end

}
-- HOUSE OF CARDS
SMODS.Joker {
	key = 'houseofcards',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'House of Cards',
		text = {
			{'This Joker gains {X:mult,C:white} X#2# {} Mult',
			'if played hand contains a {C:attention}Full House{}',
			'{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult){}'},
			{'{C:attention}Resets{} if played hand is a {C:attention}High Card{}'},
			
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { Xmult = 1, Xmult_gain = 0.2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
	end,

	-- mult
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult
			}
		end
		-- scale on playing a full house
		if context.before and context.main_eval and not context.blueprint and (next(context.poker_hands['Full House'])) then
			card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.RED
			}
		end
		-- reset sometimes! get scared
		if context.before and context.main_eval and not context.blueprint and context.scoring_name == 'High Card' then
			card.ability.extra.Xmult = 1
			return {
				message = localize('k_reset')
			}
		end
	end


}

--[[SMODS.Joker {
	key = 'recyclingbin',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Recycling Bin',
		text = {
			'Gives {C:money}$#1#{}',
			'when a {C:attention}playing card{}',
			'is added to your deck'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 0 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { dollars = 4 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,


	calculate = function(self, card, context)
		if context.playing_card_added then
			for i = 1, #context.cards do
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
				-- one day ill understand what the dollar buffer does but whatever it does it made this stop looking wonky
				return {
					dollars = card.ability.extra.dollars,
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								G.GAME.dollar_buffer = 0
								return true
							end
						}))
					end
				}
			end
		end
	end
}
]]



SMODS.Joker {
	key = 'panicbutton',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Panic Button',
		text = {
			'On {C:green}rerolling{} the shop,',
			'{C:attention}destroy{} a random card',
			'in your deck',
			'{C:green,s:0.8}Art & Concept by NoahCrawfish{}'
		}
	},
	-- put all variables in here
	config = { colours = { suitcolor = G.C.FILTER } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				colours = {
					card.ability.colours.suitcolor
				}
			}
		}
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 1 },
	-- Cost of card in shop.
	cost = 7,


	calculate = function(self, card, context)
		if context.reroll_shop and #G.playing_cards > 0 then
			local znm_card_to_destroy = {}
			znm_card_to_destroy = pseudorandom_element(G.playing_cards, pseudoseed('znm_panicbutton'))

			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					SMODS.destroy_cards(znm_card_to_destroy)
					return true
				end
			}))

			-- picks a suit color

			if znm_card_to_destroy:is_suit('Spades') then
				card.ability.colours.suitcolor = G.C.SUITS.Spades
			elseif znm_card_to_destroy:is_suit('Clubs') then
				card.ability.colours.suitcolor = G.C.SUITS.Clubs
			elseif znm_card_to_destroy:is_suit('Hearts') then
				card.ability.colours.suitcolor = G.C.SUITS.Hearts
			elseif znm_card_to_destroy:is_suit('Diamonds') then
				card.ability.colours.suitcolor = G.C.SUITS.Diamonds
			else
				card.ability.colours.suitcolor = G.C.FILTER
			end

			if not SMODS.has_no_rank(znm_card_to_destroy) then
				return {
					message = localize(znm_card_to_destroy.base.value, "ranks"),
					colour = card.ability.colours.suitcolor

				}
			else
				return {
					message = "No Rank",

					colour = G.C.FILTER
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'coralreef',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Coral Reef',
		text = {
			{
				'This Joker gains {C:mult}+#2#{} Mult',
				'if poker hand contains a {C:attention}debuffed{} card',
				'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}'
			},
			{
				'Permanently {C:attention}debuffs{} a random card',
				'when {C:attention}Blind{} is selected',
				'{C:green,s:0.8}Art by Worldwaker2{}'
			}
		}
	},
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 3 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 1 },
	-- Cost of card in shop.
	cost = 6,


	calculate = function(self, card, context)
		-- creates a list of eligible cards to debuff for this blind (meaning ones which are not already debuffed)
		if context.setting_blind then
			local znm_card_to_debuff = {}
			local znm_undebuffed_cards = {}
			for i = 1, #G.playing_cards do
				if G.playing_cards[i] and not G.playing_cards[i].debuff then
					znm_undebuffed_cards[#znm_undebuffed_cards + 1] =
						G.playing_cards[i]
				end
			end

			if #znm_undebuffed_cards > 0 then
				-- picks a random card out of previously established eligible set and debuffs it permanently
				znm_card_to_debuff = pseudorandom_element(znm_undebuffed_cards, pseudoseed('znm_coralreef'))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						-- thanks to somethingcom515 for getting this to work, i have 0 idea what the source part does
						SMODS.debuff_card(znm_card_to_debuff, true, "source")
						return true
					end
				}))
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.before and context.cardarea == G.jokers and not context.blueprint then
			-- extra code to work with the challenge dizzy diving

			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i].debuff then
					if G.GAME.modifiers.znm_evilreef then
						ease_dollars(-G.GAME.dollars, true)
					end
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
					return {
						message = localize('k_upgrade_ex'),
					}
				end
			end
		end
	end
}

--[[ ETCHASKETCH
SMODS.Joker {
	key = 'etchasketch',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Etch-a-sketch',
		text = {
			'Randomizes {C:attention}rank{} and {C:attention}suit{}',
			'of all playing cards in {C:attention}full deck{}',
			'when sold',
			'{C:green,s:0.8}Concept by Xolimono{}'

		}
	},
	-- put all variables in here
	config = { extra = {} },

	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,
	-- Sets rarity. 1 common, 2 uncommon, 3 rare, 4 legendary.
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 2 },
	-- Cost of card in shop.
	cost = 9,


	calculate = function(self, card, context)
		if context.selling_self then
			local eval = function() return not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)

			for i = 1, #G.playing_cards do
				local _suit = pseudorandom_element(SMODS.Suits, pseudoseed('znm_clicker'))
				local _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('znm_clicker'))
				G.E_MANAGER:add_event(Event({
					func = function()
						local _card = G.playing_cards[i]
						assert(SMODS.change_base(_card, _suit.key))
						assert(SMODS.change_base(_card, nil, _rank.key))

						return true
					end
				}))
			end
			return {
				message = "Shake!"
			}
		end
	end
}]]
-- COTTON CANDY
SMODS.Joker {
	key = 'cottoncandy',
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Cotton Candy',
		text = {
			{'{C:attention}+#1#{} Joker slots'},
			{'Disappears in {C:attention}2{} rounds',
			'{C:inactive}({C:attention}#2#{C:inactive} rounds remaining){}',
			'{C:green,s:0.8}Art & Concept by tobyaaa{}'}
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 9, y = 1 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { slots = 2, invis_rounds = 2 } },

	loc_vars = function(self, info_queue, card)
		local slotsleft
		if card.ability.extra.invis_rounds > 1 then
			slotsleft = 'rounds'
		else
			slotsleft = 'round'
		end
		return {
			vars = { card.ability.extra.slots, card.ability.extra.invis_rounds, slotsleft }
		}
	end,
	--for use with stuff like paperback's jokers that depend on food jokers
	pools = {
		Food = true
	},
	-- gives and takes joker slots when card is added and removed
	add_to_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,

	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.invis_rounds = card.ability.extra.invis_rounds - 1
			if card.ability.extra.invis_rounds == 1 then
				return {
					message = "1 Remaining",
					colour = G.C.DARK_EDITION
				}
			end
			-- invisible joker esque code that gives text for 1 round left, and destroys itself alongside text at 0
			if card.ability.extra.invis_rounds == 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = "Yum yum yum!",
					colour = G.C.DARK_EDITION
				}
			end
		end
	end
}

--[[
SMODS.Joker {
	key = 'merchant',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Merchant',
		text = {
			'Adds {C:attention}#1#{} additional {C:attention}Booster Packs{}',
			'when entering the shop',
			'destroys itself when shop is {C:attention}rerolled{}'


		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 1 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { booster_packs = 2, } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.booster_packs } }
	end,
	-- gives and takes shop slots

	calculate = function(self, card, context)
		if context.starting_shop then
			SMODS.add_booster_to_shop()
			SMODS.add_booster_to_shop()
		end
		--rerolling takes this away
		if context.reroll_shop and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					-- This part destroys the card.
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true;
						end
					}))
					return true
				end
			}))
			return {
				message = "Goodbye!",
			}
		end
	end
}
]]

SMODS.Joker {
	key = 'stepladder',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Step Ladder',
		text = {
			'{C:mult}+#1#{} Mult if a {C:attention}Small Straight{}',
			'is held in hand',
			'{C:inactive}(ex: {C:attention}2 3 4{C:inactive}){}',
			'{C:green,s:0.8}Code by Aurora Aquir{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 2 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 25 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,


	calculate = function(self, card, context)
		local step_ladder_mult = false
		-- checks cards next to it to see if they form a "small straight", which is a made up hand i made up in my mind palace
		if context.joker_main then
			local values = {}
			
			-- base4: we need to precompute the values list, or the algorithm becomes order-dependent.
			-- i discovered this on accident. if you place an ace after a 2 and 3 (to the right),
			-- then it fails to find the ace 2 3 straight unless you use this modified code.
			for i = 1, #G.hand.cards do
				local value = G.hand.cards[i]:get_id()
				values[value] = true
			end
			-- this code bit is by aurora aquir, i originally had something else but this is wayyy less obtuse, thank you actual coders!
			for i = 1, #G.hand.cards do
				local value = G.hand.cards[i]:get_id()
				if (values[value - 2] and values[value - 1])
					or (values[value - 1] and values[value + 1])
					or (values[value + 1] and values[value + 2])
					-- this is a special edge case i add for ace 2 3 small straights
					or (values[value + 1] and values[value + 12]) then
					step_ladder_mult = true
				end
			end

			if step_ladder_mult == true then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end
}

--[[SMODS.Joker {
	key = 'sackboy',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Sackboy',
		text = {
			'{C:chips}+#1#{} Chips if poker hand is',
			'{C:attention}different{} from previous poker hand',
			'{C:inactive}(Currently {C:attention}#2#{}{C:inactive}){}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { chips = 80, } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, localize(G.GAME.sackboy_hand or "High Card", 'poker_hands') } }
	end,


	calculate = function(self, card, context)
		if context.joker_main then
			if context.scoring_name ~= G.GAME.sackboy_hand then
				return {
					chips = card.ability.extra.chips
				}
			end
		end
	end
}

-- used for sackboy for some weird functionality, thanks somethingcom515!
local smodsoldcalccontext = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
	local g = smodsoldcalccontext(context, return_table)
	if context.after then
		G.GAME.sackboy_hand = context.scoring_name
	end
	return g
end]]

-- code by vitellary because i did like 5 attempts and they all made Weird cards
-- first we store the original function as a variable so we can use it later
local discardRef = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
	discardRef(e, hook) -- call the original code immediately
	if #SMODS.find_card("j_znm_bulldozer") > 0 and #G.hand.highlighted == 1 then
		-- just gonna create our own table cuz we don't need to use highlighting at all for this
		local full_cards = {}
		for _, v in ipairs(G.hand.cards) do
			if not v.highlighted then
				table.insert(full_cards, v)
			end
		end

		-- calculate discard effects on the full hand, with hook = true so that it treats it the same way The Hook works (eg. won't count as first discard)
		SMODS.calculate_context({ pre_discard = true, full_hand = full_cards, hook = true })

		-- now do individual card effects
		local destroyed = {}
		for i, v in ipairs(full_cards) do
			v:calculate_seal({ discard = true })
			local effects = {}
			SMODS.calculate_context(
				{ discard = true, other_card = v, full_hand = full_cards, ignore_other_debuff = true },
				effects)
			-- i be copying from the source code idk what this does
			SMODS.trigger_effects(effects)
			-- this is for checking if we just destroyed anything
			for _, eval in pairs(effects) do
				if type(eval) == 'table' then
					for key, eval2 in pairs(eval) do
						if key == 'remove' or (type(eval2) == 'table' and eval2.remove) then removed = true end
					end
				end
			end
			if removed then -- destroy it
				table.insert(destroyed, v)
				if SMODS.shatters(v) then
					v:shatter()
				else
					v:start_dissolve()
				end
			else
				v.ability.discarded = true
				if next(find_joker('ccc_Climbing Gear')) then
					draw_card(G.hand, G.deck, i * 100 / #full_cards, 'down', false, v)
					G.deck:shuffle('nr' .. G.GAME.round_resets.ante)
				else
					draw_card(G.hand, G.discard, i * 100 / #full_cards, 'down', false, v)
				end
			end
		end

		-- destroyed cards effects
		if #destroyed > 0 then
			SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed })
		end
	end
end


SMODS.Joker {
	key = 'bulldozer',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Bulldozer',
		text = {
			'If discard contains {C:attention}1{} card,',
			'discards your {C:attention}entire{} hand',
			'{C:green,s:0.8}Code by Vitellary{}'

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = {} },
	loc_vars = function(self, info_queue, card)
		return { vars = {} }
	end,


}



SMODS.Joker {
	key = 'maskmaker',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Mask Maker',
		text = {
			{'This Joker gains {C:mult}+#2#{} Mult',
			'for every {C:attention}face{} card {C:attention}discarded{}',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}'},
			{'{C:attention}Resets{} at end of round'}
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 3 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,


	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
		if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_face() then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				delay = 0.3,
				message = localize('k_upgrade_ex'),
				card = card,
				colour = G.C.MULT
			}
		end
		if context.end_of_round and context.main_eval then
			card.ability.extra.mult = 0
			return {
				message = localize('k_reset')
			}
		end
	end


}

SMODS.Joker {
	key = 'crazyeights',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Crazy 8s',
		text = {
			'If poker hand contains an {C:attention}8{},',
			'turn a random card held in hand {C:attention}Wild{}'

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 1 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return { vars = {} }
	end,


	calculate = function(self, card, context)
		local znm_crazy8bool = false
		local znm_crazy8wildlist = {}
		local znm_crazy8cardtowild = {}
		if context.before and context.main_eval then
			for _, v in pairs(context.scoring_hand) do
				if v:get_id() == 8 then
					znm_crazy8bool = true
					break
				end
			end
			if znm_crazy8bool then
				for i = 1, #G.hand.cards do
					if not SMODS.has_enhancement(G.hand.cards[i], 'm_wild') then
						znm_crazy8wildlist[#znm_crazy8wildlist + 1] =
							G.hand.cards[i]
					end
				end
			end
			if #znm_crazy8wildlist > 0 then
				-- picks a random card out of previously established eligible set and makes it wild
				znm_crazy8cardtowild = pseudorandom_element(znm_crazy8wildlist, pseudoseed('znm_crazyeights'))



				znm_crazy8cardtowild:set_ability('m_wild')

				return {
					message = "Wild!"
				}
			end
		end
	end


}

SMODS.Joker {
	key = 'pinhead',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Pinhead',
		text = {
			'Each {C:attention}10{} or {C:attention}5{} held in hand',
			'gives {C:mult}+#1#{} Mult',
			'{C:green,s:0.8}Art by NoahCrawfish{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 2 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 3 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,


	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 10 then
			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED
				}
			else
				return {
					mult = card.ability.extra.mult
				}
			end
		end
		-- i feel like this is really stupid and could just be one context but it doesnt work for some reason?? so it's staying two contexts until further notice
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 5 then
			if context.other_card.debuff then
				return {
					message = localize('k_debuffed'),
					colour = G.C.RED
				}
			else
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end


}

SMODS.Joker {
	key = 'peninsula',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Peninsula',
		text = {
			'This Joker gains {C:mult}+#2#{} Mult',
			'if {C:attention}Blind{} is selected with enough',
			'{C:money}money{} held to have {C:attention}max interest{}',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 0 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,


	calculate = function(self, card, context)
		if context.setting_blind and to_big(G.GAME.dollars) >= to_big(G.GAME.interest_cap) and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.RED
			}
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end


}

--[[SMODS.Joker {
	key = 'bluemoon',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Blue Moon',
		text = {
			'{C:green}#1# in #2#{} chance to create',
			'a {C:tarot}Tarot{} card',
			'when a {C:planet}Planet{} card is used',
			'{C:inactive}(Must have room){}'


		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 1 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 3 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_bluemoon') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator, } }
	end,


	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Planet' and SMODS.pseudorandom_probability(card, 'znm_bluemoon', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_bluemoon') and
			#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					SMODS.add_card {
						set = 'Tarot',
						key_append = 'Znm_bluemoon' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
					}
					G.GAME.consumeable_buffer = 0
					return true
				end)
			}))
			return {
				message = localize('k_plus_tarot'),
				colour = G.C.PURPLE,
			}
		end
	end


}]]

-- CANDLE
SMODS.Joker {
	key = 'candle',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Candle',
		text = {

			'This Joker gains {X:mult,C:white} X#3# {} Mult',
			'if {C:attention}discarded{} poker hand contains',
			'a {C:attention}#2#{} or {C:attention}#4#{}',
			'{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult){}'
		}


	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 0 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { Xmult = 1, candle_hand = 'Straight', Xmult_gain = 0.2, candle_hand2 = 'Three of a Kind' } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, localize(card.ability.extra.candle_hand, 'poker_hands'), card.ability.extra.Xmult_gain, localize(card.ability.extra.candle_hand2, 'poker_hands') } }
	end,


	calculate = function(self, card, context)
		if context.pre_discard and not context.blueprint and not context.hook then
			local _, _, znm_candle_check, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
			if next(znm_candle_check[card.ability.extra.candle_hand]) or next(znm_candle_check[card.ability.extra.candle_hand2]) then
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				}
			end
		end

		if context.joker_main and card.ability.extra.Xmult > 1 then
			return {
				Xmult = card.ability.extra.Xmult
			}
		end
	end


}

--[[ AW SHUCKS
SMODS.Joker {
	key = 'awshucks',
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Aw Shucks!',
		text = {
			'{C:attention}+#1#{} consumable #2#',
			'{C:attention}-1{} consumable slot per round played',
			'{C:green,s:0.8}Art by NoahCrawfish{}'


		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 0 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { consumables_limit = 5 } },

	loc_vars = function(self, info_queue, card)
		local shucksleft
		if card.ability.extra.consumables_limit > 1 then
			shucksleft = 'slots'
		else
			shucksleft = 'slot'
		end
		return {
			vars = { card.ability.extra.consumables_limit, shucksleft }
		}
	end,
	--for use with stuff like paperback's jokers that depend on food jokers
	pools = {
		Food = true
	},

	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit +
					card.ability.extra.consumables_limit
				return true
			end
		}))
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.consumeables.config.card_limit = G.consumeables.config.card_limit -
					card.ability.extra.consumables_limit
				return true
			end
		}))
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.consumables_limit = card.ability.extra.consumables_limit - 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
					return true
				end
			}))

			if card.ability.extra.consumables_limit == 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = "Eaten!",
					colour = G.C.ATTENTION
				}
			end
			return {
				message = "-1",
				colour = G.C.ATTENTION
			}
		end
	end


}
]]



-- SPIDERWEB
SMODS.Joker {
	key = 'bugcave',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Bug Cave',
		text = {
			{
				'{X:mult,C:white}X#1#{} Mult',
			},
			{
				'If played hand is a',
				'{C:attention}#2#{}, {C:attention}#3#{}, or {C:attention}#5#{},',
				'hand will {C:red}not{} score'
			}

		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { Xmult = 3, znm_poker_hand1 = 'High Card', znm_poker_hand2 = 'Pair', mult = 0, znm_poker_hand3 = "Two Pair" } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult, localize(card.ability.extra.znm_poker_hand1, 'poker_hands'), localize(card.ability.extra.znm_poker_hand2, 'poker_hands'), card.ability.extra.multx, localize(card.ability.extra.znm_poker_hand3, 'poker_hands') } }
	end,



	calculate = function(self, card, context)
		if context.debuff_hand then
			if context.scoring_name == card.ability.extra.znm_poker_hand1 or context.scoring_name == card.ability.extra.znm_poker_hand2 or context.scoring_name == card.ability.extra.znm_poker_hand3 then
				return {
					debuff = true,
				}
			end
		end

		if context.joker_main then
			return {
				Xmult = card.ability.extra.Xmult
			}
		end
	end


}

-- EALU
SMODS.Joker {
	key = 'ealu',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Éalú',
		text = {
			'This Joker gains {C:mult}+#2#{} Mult',
			'on {C:attention}final hand{} of round',
			'{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult){}',
			'{C:green,s:0.8}Concept by NoahCrawfish{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 2 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 5 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,

	calculate = function(self, card, context)
		if context.before and context.main_eval and G.GAME.current_round.hands_left == 0 and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MULT,
			}
		end
		-- scoring
		if context.joker_main and card.ability.extra.mult > 0 then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}


--[[ BULLETTRAIN
SMODS.Joker {
	key = 'bullettrain',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Bullet Train',
		text = {
			'If played hand contains a {C:attention}#2#{},',
			'every played {C:attention}card{} permanently',
			'gains {C:mult}+#1#{} Mult when scored'


		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 9, y = 2 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { mult = 2, type = 'Straight' } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands') } }
	end,

	-- looks at if hand contains a straight, does some hiker magic
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and next(context.poker_hands[card.ability.extra.type]) then
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
			context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
			return {
				extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
				card = card
			}
		end
	end


}
-- PYRAMID SCHEME
SMODS.Joker {
	key = 'pyramidscheme',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Pyramid Scheme',
		text = {

			'{C:green}#1# in #2#{} chance for each',
			'played {C:attention}3{} to create a',
			'random {C:attention}Joker{} when scored',
			'{C:inactive}(Must have room){}'


		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 3 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 3 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_pyramidscheme') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator, } }
	end,

	calculate = function(self, card, context)
		if G.GAME.modifiers.znm_pyramid then
			card.ability.extra.denominator = 2
		end
		if context.individual and context.cardarea == G.play and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit and context.other_card:get_id() == 3
			and SMODS.pseudorandom_probability(card, 'znm_pyramidscheme', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_pyramidscheme') then
			G.GAME.joker_buffer = G.GAME.joker_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.0,
				func = function()
					SMODS.add_card {
						set = 'Joker',

						key_append = 'znm_pyramidscheme' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
					}
					G.GAME.joker_buffer = 0

					return true
				end
			}))
			return {
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = "+1 Joker",
					colour = G.C.ATTENTION
				}),

			}
		end
	end


}]]

-- STRAWBERRY JAM
SMODS.Joker {
	key = 'strawberryjam',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Strawberry Jam',
		text = {
			'In {C:attention}2{} rounds,',
			'sell to turn up to {C:attention}#1#{} cards',
			'in hand into {C:strawberry}Strawberry Cards',
			'{C:inactive}({C:attention}#2#{C:inactive} rounds remaining){}',
			'{C:green,s:0.8}Art by NoahCrawfish{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 3 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { limit = 5, sj_rounds = 2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.limit, card.ability.extra.sj_rounds } }
	end,


	calculate = function(self, card, context)
		-- code copied from sarc lol
		if context.selling_self and (card.ability.extra.sj_rounds <= 0) then
			local unenhanced = 0
			local enhanced_list = {}
			for i = 1,#G.hand.cards do
				if SMODS.has_enhancement(G.hand.cards[i], 'c_base') then
					unenhanced = unenhanced+1
				else
					table.insert(enhanced_list, i)
				end
			end
			local num_targets = math.min(unenhanced, card.ability.extra.limit)
			local random_indexes = SARC.get_rand_hand_index(num_targets, enhanced_list)
			for _,v in ipairs(random_indexes) do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						blocking = true,
						delay = 0.2,
						func = function()
							play_sound('tarot1',(math.random(9,11)/10))
							G.hand.cards[v]:juice_up()
							G.hand.cards[v]:set_ability(G.P_CENTERS.m_sarc_strawberry)
							return true
						end
					}))
			
			end
		end



		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.sj_rounds = card.ability.extra.sj_rounds - 1
			if card.ability.extra.sj_rounds <= 0 then
				local eval = function(card) return not card.REMOVED end
				juice_card_until(card, eval, true)
				return {
					message = localize('k_active_ex')
				}
			end
		end
	end
}

--[[SMODS.Joker {
	key = 'brokenrecord',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Broken Record',
		text = {
			'Retrigger all scoring {C:attention}#2#s{} twice,',
			'rank changes at end of round'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 3 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { repetitions = 2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, localize((G.GAME.current_round.znm_brokenrecord_rank or {}).rank or 'Ace', 'ranks') } }
	end,

	-- checks if the player played the correct rank, and then retriggers the cards
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card:get_id() == G.GAME.current_round.znm_brokenrecord_rank.id then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
		end
	end
}
-- changes broken record rank globally at end of round
local function reset_znm_brokenrecord_rank()
	G.GAME.current_round.znm_brokenrecord_rank = { rank = 'Ace' }
	local valid_record_cards = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
			valid_record_cards[#valid_record_cards + 1] = playing_card
		end
	end
	local record_card = pseudorandom_element(valid_record_cards,
		pseudoseed('znm_brokenrecord' .. G.GAME.round_resets.ante))
	if record_card then
		G.GAME.current_round.znm_brokenrecord_rank.rank = record_card.base.value
		G.GAME.current_round.znm_brokenrecord_rank.id = record_card.base.id
	end
end

SMODS.Joker {
	key = 'oilbarrel',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Oil Barrel',
		text = {
			'Scored {C:attention}Mult Cards{} give {X:mult,C:white} X#1# {} Mult,',
			'{C:money}-$#2#{} when a {C:attention}Mult Card{} is scored',
			'{C:green,s:0.8}Art by {C:attention,s:0.8}the_orang_man{}'

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 3 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { Xmult = 2, dollars = 1 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		return { vars = { card.ability.extra.Xmult, card.ability.extra.dollars } }
	end,

	in_pool = function(self, args)
		if G.deck and G.deck.cards then
			for j = 1, #G.deck.cards do
				if G.deck.cards[j].config.center.key == 'm_mult' then
					return true
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_mult') then
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.dollars
			return {
				dollars = -card.ability.extra.dollars,
				extra = {
					Xmult = card.ability.extra.Xmult
				}
			}
		end
	end
}]]
--[[SMODS.Joker {
	key = 'mayhemjoker',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Mayhem "Joker"',
		text = {
			'Scored {C:attention}9s{}, {C:attention}Aces{}, and {C:attention}4s{}',
			'give either {C:mult}+#2#{} Mult or {C:chips}+#1#{} Chips,',
			'chosen at random'

		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 4 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { chips = 40, mult = 7, odds = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and
			(context.other_card:get_id() == 9 or context.other_card:get_id() == 14 or context.other_card:get_id() == 4) then
			-- uses 1 instead of the usual probability thing so that it doesn't turn into exclusively a chips joker with oops all 6s
			if pseudorandom('znm_scraggly1') < 1 / card.ability.extra.odds then
				return {
					chips = card.ability.extra.chips,

				}
			else
				return {
					mult = card.ability.extra.mult

				}
			end
		end
	end
}]]







SMODS.Joker {
	key = 'fireworks',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Fireworks',
		text = {
			'Retrigger the first played',
			'{C:chips}Bonus Card{} or {C:mult}Mult Card{}',
			'{C:attention}2{} times'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 4 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { repetitions = 1 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		return { vars = { card.ability.extra.repetitions } }
	end,
	-- gates it behind mult or bonus cards
	in_pool = function(self, args)
		if G.deck and G.deck.cards then
			for j = 1, #G.deck.cards do
				if G.deck.cards[j].config.center.key == 'm_bonus' or G.deck.cards[j].config.center.key == 'm_mult' then
					return true
				end
			end
		end
	end,

	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, "m_mult") or SMODS.has_enhancement(context.other_card, "m_bonus")) then
            local is_first = false
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], "m_mult") or SMODS.has_enhancement(context.scoring_hand[i], "m_bonus") then
                    is_first = context.scoring_hand[i] == context.other_card
                    break
                end
            end
            if is_first then
                return {
                    repetitions = 2
                }
            end
        end

		--[[if context.repetition and context.cardarea == G.play then
			if SMODS.has_enhancement(context.other_card, 'm_bonus') or SMODS.has_enhancement(context.other_card, 'm_mult') then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
		end]]
	end
}

SMODS.Joker {
	key = 'fireeater',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Fire Eater',
		text = {
			{'This Joker gains {C:mult}+#2#{} Mult',
			'for each scored {C:attention}#3#{}',
			'during a {C:attention}Boss Blind,',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}'},
			{'Rank changes at','end of round'},
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 4 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 4 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, localize((G.GAME.current_round.znm_liontamer_rank or {}).rank or 'Ace', 'ranks') } }
	end,

	-- checks if the player played the correct rank, and then adds mult
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and not context.blueprint and G.GAME.blind.boss then
			if context.other_card:get_id() == G.GAME.current_round.znm_liontamer_rank.id then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
				return {
					message = localize('k_upgrade_ex'),
				}
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult,
				focus = card,
			}
		end
	end
}





local function reset_znm_liontamer_rank()
	G.GAME.current_round.znm_liontamer_rank = { rank = 'Ace' }
	local valid_tamer_cards = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_rank(playing_card) then
			valid_tamer_cards[#valid_tamer_cards + 1] = playing_card
		end
	end
	local tamer_card = pseudorandom_element(valid_tamer_cards, pseudoseed('znm_liontamer' .. G.GAME.round_resets.ante))
	if tamer_card then
		G.GAME.current_round.znm_liontamer_rank.rank = tamer_card.base.value
		G.GAME.current_round.znm_liontamer_rank.id = tamer_card.base.id
	end
end


SMODS.Joker {
	key = 'solarpanels',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Solar Panel',
		text = {
			'Copies the abilities of',
			'{C:attention}Joker{} to the left and right',
			'once every {C:attention}4{} hands',
			'{C:inactive}(#2#){}',
			'{C:green,s:0.8}Art by NoahCrawfish{}'

		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 4 },
	-- Cost of card in shop.
	cost = 10,
	-- put all variables in here

	config = { extra = { every = 3, solarpanels_remaining = 3 } },
	loc_vars = function(self, info_queue, card)
		if card.area and card.area == G.jokers then
			local other_joker
			local other_joker2
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i - 1] end
			end
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker2 = G.jokers.cards[i + 1] end
			end
			local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
			local compatible2 = other_joker2 and other_joker2 ~= card and other_joker2.config.center.blueprint_compat
			main_end = {
				{
					n = G.UIT.C,
					config = { align = "bm", minh = 0.4 },
					nodes = {
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						},
						{
							n = G.UIT.C,
							config = { ref_table = card, align = "m", colour = compatible2 and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
							nodes = {
								{ n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible2 and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
							}
						}
					}
				}
			}
		end



		return {
			main_end = main_end,
			vars = {

				card.ability.extra.every + 1,
				localize { type = 'variable', key = (card.ability.extra.solarpanels_remaining == 0 and 'loyalty_active' or 'loyalty_inactive'), vars = { card.ability.extra.solarpanels_remaining } }
			}
		}
	end,





	calculate = function(self, card, context)
		if context.after then
			card.ability.extra.solarpanels_remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) %
				(card.ability.extra.every + 1)
			if not context.blueprint then
				if card.ability.extra.solarpanels_remaining == 0 then
					return {
						message = "Active"
					}
				end
			end
		end

		-- the retriggering

		if card.ability.extra.solarpanels_remaining == 0 then
			local other_joker = nil
			local other_joker2 = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i + 1]
					other_joker2 = G.jokers.cards[i - 1]
				end
			end

			local other_jokertrigger = SMODS.blueprint_effect(card, other_joker, context)
			local other_joker2trigger = SMODS.blueprint_effect(card, other_joker2, context)
			-- this code makes sure the joker can still work even if it just retriggers one
			local merge = {}
			if type(other_jokertrigger) == "table" and next(other_jokertrigger) then
				table.insert(merge,
					other_jokertrigger)
			end
			if type(other_joker2trigger) == "table" and next(other_joker2trigger) then
				table.insert(merge,
					other_joker2trigger)
			end
			return SMODS.merge_effects(merge)
		end
	end



}







--[[SMODS.Joker {
	key = 'slothfuljoker',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Slothful Joker',
		text = {
			'{C:mult}+#1#{} Mult if played hand',
			'does {C:red}not{} contain any {V:1}#2#s{},',
			'suit changes every round'



		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 3 },
	-- Cost of card in shop.
	cost = 3,
	-- put all variables in here
	config = { extra = { mult = 8, znm_slothfulbool = true } },

	loc_vars = function(self, info_queue, card)
		local suit = (G.GAME.current_round.znm_slothful_suit or {}).suit or 'Spades'
		return { vars = { card.ability.extra.mult, localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
	end,


	calculate = function(self, card, context)
		if context.before and context.main_eval then
			card.ability.extra.znm_slothfulbool = true
			for _, v in pairs(context.scoring_hand) do
				if v:is_suit(G.GAME.current_round.znm_slothful_suit.suit) then
					card.ability.extra.znm_slothfulbool = false
				end
			end
		end

		if context.joker_main then
			if card.ability.extra.znm_slothfulbool then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end




}


local function reset_znm_slothful_suit()
	G.GAME.current_round.znm_slothful_suit = { suit = 'Spades' }
	local valid_slothful_cards = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(playing_card) then
			valid_slothful_cards[#valid_slothful_cards + 1] = playing_card
		end
	end
	local slothful_card = pseudorandom_element(valid_slothful_cards,
		pseudoseed('znm_slothfuljoker' .. G.GAME.round_resets.ante))
	if slothful_card then
		G.GAME.current_round.znm_slothful_suit.suit = slothful_card.base.suit
	end
end




SMODS.Joker {
	key = 'shaman',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Shaman',
		text = {
			'If a {C:attention}consumable{} is held,',
			'{C:attention}destroy{} a random consumable and give',
			'a random card in poker hand an {C:dark_edition}Edition{}',
			'when hand is played'
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 9, y = 3 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = {} },

	loc_vars = function(self, info_queue, card)
		-- makes the editions appear on the side so you can see what the eligible ones are in a concise way
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		return { vars = { card.ability.extra.repetitions } }
	end,



	calculate = function(self, card, context)
		local znm_shamanlist = {}
		local znm_shamancard = {}
		local znm_shamanedition = poll_edition('znm_shaman', nil, true, true,
			{ 'e_polychrome', 'e_holo', 'e_foil' })
		local znm_canshaman = false
		if context.before and context.main_eval and G.consumeables.cards[1] then
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i] and not context.scoring_hand[i].edition and not context.scoring_hand[i].debuff then
					znm_shamanlist[#znm_shamanlist + 1] =
						context.scoring_hand[i]
				end
			end


			znm_shamancard = pseudorandom_element(znm_shamanlist, pseudoseed('znm_shaman'))

			local znm_shamanconsumable = pseudorandom_element(G.consumeables.cards, pseudoseed('znm_shaman'))
			if znm_shamanconsumable ~= nil and znm_shamancard ~= nil then
				znm_canshaman = true
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						znm_shamanconsumable:juice_up(0.3, 0.4)
						znm_shamanconsumable:start_dissolve()
						znm_shamanconsumable = nil
						delay(0.2)

						return true
					end
				}))

				if znm_canshaman then
					znm_shamancard:set_edition(znm_shamanedition, true)
				end

				return {
					message = "Magic!"
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'runestone',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Rune Stone',
		text = {
			'Scored {C:attention}Stone Cards{} have a',
			'{C:green}#1# in #2#{} chance to create a {C:spectral}Spectral Card{}',
			'and are {C:attention}destroyed{} after scoring'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 4 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 2 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone

		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_runestone') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator, } }
	end,
	in_pool = function(self, args)
		if G.deck and G.deck.cards then
			for j = 1, #G.deck.cards do
				if G.deck.cards[j].config.center.key == 'm_stone' then
					return true
				end
			end
		end
	end,


	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and
			#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			if (context.other_card.ability.effect == 'Stone Card') and SMODS.pseudorandom_probability(card, 'znm_runestone', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_runestone') then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				return {
					extra = {
						message = localize('k_plus_spectral'),
						message_card = card,
						func = function() -- This is for timing purposes, everything here runs after the message
							G.E_MANAGER:add_event(Event({
								func = (function()
									SMODS.add_card {
										set = 'Spectral',
										key_append = 'znm_runestone' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
									}
									G.GAME.consumeable_buffer = 0
									return true
								end)
							}))
						end
					},
				}
			end
		end

		if context.after and context.main_eval and not context.blueprint then
			local znm_cards_to_destroy = {}
			for _, v in pairs(context.scoring_hand) do
				if v.ability.effect == 'Stone Card' then
					znm_cards_to_destroy[#znm_cards_to_destroy + 1] = v
				end
			end
			-- in case you dont play a stone card, I forgot about this initially but if i dont add this clause it crashes
			if #znm_cards_to_destroy > 0 then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function()
						SMODS.destroy_cards(znm_cards_to_destroy)
						return true
					end
				}))
			end
		end
	end
}]]

SMODS.Joker {
	key = 'walkoffame',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Walk of Fame',
		text = {
			'{C:attention}Face{} cards held in hand at end of round',
			'have a {C:green}#1# in #2#{} chance to gain a random {C:attention}seal{}'

		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 4 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 2 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_walkoffame') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator, } }
	end,



	calculate = function(self, card, context)
		if context.individual and context.end_of_round and context.cardarea == G.hand then
			local other_card = context.other_card
			-- a decent bit of the flair of this is taken from sunsetquasar's Divine Light teehee, do NOT ask me to tell you what the triple nil is subbing in for
			local seal = SMODS.poll_seal({ key = "seed", guaranteed = true })
			if other_card:is_face() and not other_card.seal and not other_card.debuff and SMODS.pseudorandom_probability(card, 'znm_walkoffame', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_walkoffame') then
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					delay = 0.4,
					card:juice_up(),
					other_card:set_seal(seal, false, true),
					card_eval_status_text(other_card, 'extra', nil, nil, nil,
						{ message = 'Famous!', colour = G.C.SPECTRAL, instant = true })
				}))
			end
		end
	end
}

--[[SMODS.Joker {
	key = 'shrimps',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Shrimps',
		text = {
			'At end of round, earn {C:money}$#1#{} for',
			'each {C:attention}Joker{} card',
			'and {C:attention}destroy{} a random {C:attention}Joker{}',
			'{C:inactive}(Currently {C:money}$#2#{C:inactive}){}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 3 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { dollars = 3, hasshrimped = 0 } },

	loc_vars = function(self, info_queue, card)
		-- math.max is making sure it never displays as a negative number (this is possible by finding it with no other jokers)
		-- its not possible anymore because i changed it !
		return { vars = { card.ability.extra.dollars, math.max(card.ability.extra.dollars * ((G.jokers and #G.jokers.cards or 0) + card.ability.extra.hasshrimped), 0) } }
	end,


	-- abstract joker esque calculation
	calc_dollar_bonus = function(self, card)
		local joker_tally = 0
		for i = 1, #G.jokers.cards do
			joker_tally = joker_tally + 1
		end
		if card.ability.extra.hasshrimped == 1 then
			joker_tally = joker_tally + 1
		end
		return joker_tally > 0 and card.ability.extra.dollars * joker_tally or nil
	end,
	calculate = function(self, card, context)
		-- pretty much completely yoinked from madness
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			local destructable_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then
					destructable_jokers[#destructable_jokers + 1] =
						G.jokers.cards[i]
				end
			end
			local joker_to_destroy = pseudorandom_element(destructable_jokers, pseudoseed('znm_shrimps'))

			if joker_to_destroy then
				joker_to_destroy.getting_sliced = true
				-- seeing if i can jank the right timing together
				--delay(1)
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						card.ability.extra.hasshrimped = 1
						return true
					end
				}))
				return { message = "Shrimps!" }
			end
		end
		if context.starting_shop then
			--sets the extra value hackfix back to 0
			card.ability.extra.hasshrimped = 0
		end
	end
}



SMODS.Joker {
	key = 'blueberries',
	blueprint_compat = true,
	eternal_compat = false,

	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Blueberries',
		text = {
			'Cards in poker hand are either',
			'{C:attention}duplicated{} into your hand or {C:attention}destroyed{},',
			'chosen at {C:attention}random{}, lasts {C:attention}#3#{} rounds',
			'{C:inactive}({C:attention}#1#{C:inactive} rounds remaining){}',

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 3 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { rounds = 3, odds = 2, roundstotal = 3 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.rounds, card.ability.extra.odds, card.ability.extra.roundstotal } }
	end,
	--for use with stuff like paperback's jokers that depend on food jokers
	pools = {
		Food = true
	},


	calculate = function(self, card, context)
		local znm_blueberryduplicatelist = {}
		local znm_blueberrydestroylist = {}
		-- this is for turnover of the century
		if (G.GAME.modifiers.znm_foreverberry) and not card.ability.eternal then
			self.eternal_compat = true
			card:set_eternal(true)
		end
		if not (G.GAME.modifiers.znm_foreverberry) then
			self.eternal_compat = false
		end


		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			--turnover of the century override code
			if not ((G.GAME.modifiers.znm_foreverberry) and card.ability.extra.rounds == 3) then
				card.ability.extra.rounds = card.ability.extra.rounds - 1
			else
				card.ability.extra.rounds = 914
				card.ability.extra.roundstotal = 914
				return {
					message = '"Hello!"',
					colour = G.C.SECONDARY_SET.Spectral
				}
			end
			if card.ability.extra.rounds == 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = "Eaten!",
					colour = G.C.BLUE
				}
			end
			return {
				message = "-1",
				colour = G.C.BLUE
			}
		end
		-- the actual blueberries function, duplicates some cards and the ones that arent duplicated are destroyed, unaffected by oops
		if context.before and context.main_eval then
			for i = 1, #context.scoring_hand do
				if pseudorandom('znm_blueberries') < 1 / card.ability.extra.odds then
					znm_blueberryduplicatelist[#znm_blueberryduplicatelist + 1] =
						context.scoring_hand[i]
				else
					znm_blueberrydestroylist[#znm_blueberrydestroylist + 1] =
						context.scoring_hand[i]
				end
			end

			if #znm_blueberrydestroylist > 0 then
				for i = 1, #znm_blueberrydestroylist do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.0,
						func = function()
							SMODS.destroy_cards(znm_blueberrydestroylist[i])
							return true
						end
					}))
				end
			end

			if #znm_blueberryduplicatelist > 0 then
				for i = 1, #znm_blueberryduplicatelist do
					G.playing_card = (G.playing_card and G.playing_card + 1) or 1
					local copy_card = copy_card(znm_blueberryduplicatelist[i], nil, nil, G.playing_card)
					copy_card:add_to_deck()
					G.deck.config.card_limit = G.deck.config.card_limit + 1
					table.insert(G.playing_cards, copy_card)
					G.hand:emplace(copy_card)
					copy_card.states.visible = nil
					-- this line is to make hologram and recycling bin work
					playing_card_joker_effects({ true })
					G.E_MANAGER:add_event(Event({
						func = function()
							copy_card:start_materialize()
							return true
						end
					}))
				end
			end
		end
	end
}

-- fountain
SMODS.Joker {
	key = 'thefountain',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'The Fountain',
		text = {
			'If {C:attention}Blind{} is selected',
			'with at least {C:money}$#1#{},',
			'create a {C:dark_edition}Negative{} joker',
			'and set money to {C:money}$0{}',
			'{C:green,s:0.8}Art by DanTKO{}'

		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 4 },
	-- Cost of card in shop.
	cost = 9,
	-- put all variables in here
	config = { extra = { fountain_threshold = 35 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		return { vars = { card.ability.extra.fountain_threshold } }
	end,



	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit + 1 then
			if to_big(G.GAME.dollars) >= to_big(card.ability.extra.fountain_threshold) then
				G.E_MANAGER:add_event(Event({
					func = function()
						SMODS.add_card { set = "Joker", edition = "e_negative" }


						return true
					end
				}))

				ease_dollars(-G.GAME.dollars, true)
			end
		end
	end
}]]
-- spam email
SMODS.Joker {
	key = 'spamemail',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Spam Email',
		text = {
			{'Earn {C:money}$#1#{} when a booster',
			'pack is opened'},
			{'Increases by {C:money}$#2#{}',
			'each pack opened',
			'{C:inactive}(Resets at end of shop){}'}
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 0 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { base = 2, money = 2, more_money = 1 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.more_money, } }
	end,



	calculate = function(self, card, context)
		
		local messages = {
			"Link Clicked!",
			"Jokers For You!",
			"Get Yours Today!",
			"Sale Ending Soon!",
			"Don't Miss Out!",
			"Don't Forget!",
			"Limited Time!",
			"Buy One Get One!",
			"Sign Up Today!",
			"Up to 30% Off!"
		}

		if context.open_booster then
			card.ability.extra.money = card.ability.extra.money + card.ability.extra.more_money
			return {
				dollars = card.ability.extra.money - card.ability.extra.more_money,
				message = pseudorandom_element(messages, pseudoseed('spamemailfunnymessage'))
			}
		end

		if context.ending_shop then
			card.ability.extra.money = card.ability.extra.base
			return {
				message = "Spam Deleted!"
			}
		end
	end
}

--ARROW ACE
SMODS.Joker {
	key = 'arrowace',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Arrow Ace',
		text = {
			'If previous played hand is a single {C:attention}Ace{},',
			'quadruple all {C:attention}listed {C:green,E:1,S:1.1}probabilities{}',
			'until next hand is finished scoring',
			'{C:inactive}(ex: {C:green}1 in 5{C:inactive} -> {C:green}4 in 5{C:inactive})',
			'{C:inactive}(#3#){}',
			'{C:green,s:0.8}Art & Concept by Worldwaker2{}'

		}
	},
	rarity = 2,
	discovered = false,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 4 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { probabilitymod = 4, handsleft = 0, doprobability = false } },

	loc_vars = function(self, info_queue, card)
		local activeness = {}
		if card.ability.extra.doprobability then
			activeness = 'Active'
		else
			activeness = 'Inactive'
		end

		return { vars = { card.ability.extra.probabilitymod, card.ability.extra.handsleft, activeness, card.ability.extra.doprobability } }
	end,
	-- this is in case it's sold while it's active so it correctly divides the probabilities



	calculate = function(self, card, context)
		-- makes sure you can't activate it twice because ummm oops! all sixes

		if context.after and context.main_eval and not context.blueprint then
			if #context.full_hand == 1 and context.scoring_hand[1]:get_id() == 14 and not context.scoring_hand[1].debuff then
				card.ability.extra.handsleft = 1
				if not card.ability.extra.doprobability then
					card.ability.extra.doprobability = true
				end
				return {
					message = "Active!"
				}
			else
				card.ability.extra.handsleft = card.ability.extra.handsleft - 1
			end
		end

		if context.mod_probability and not context.blueprint and card.ability.extra.handsleft < 1 and card.ability.extra.doprobability then
			card.ability.extra.doprobability = false
		end

		if context.mod_probability and not context.blueprint and card.ability.extra.doprobability then
			return {
				numerator = context.numerator * card.ability.extra.probabilitymod
			}
		end
	end
}

--[[ THREES MCGEE
SMODS.Joker {
	key = 'threemcgee',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'Threes McGee',
		text = {
			'At end of round,',
			'{C:money}$#1#{} for every discarded {C:attention}3{}, {C:attention}6{} or {C:attention}9{} this round,',
			'{C:red}-$#2#{} for every scored {C:attention}3{}, {C:attention}6{} or {C:attention}9{} this round',
			'{C:inactive}(Currently {C:money}$#5#{C:inactive}){}',
			'{C:green,s:0.8}Art and Concept by gooseberry{}'

		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 3 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { td = 1, tp = 2, threediscards = 0, threeplays = 0, dollars = 1 } },

	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.td, card.ability.extra.tp, card.ability.extra.threediscards, card.ability.extra
				.threeplays,

				math.max(
					card.ability.extra.dollars *
					((card.ability.extra.threediscards * card.ability.extra.td) - (card.ability.extra.threeplays * card.ability.extra.tp)),
					0) }
		}
	end,

	calc_dollar_bonus = function(self, card)
		local threetally = 0
		threetally = (card.ability.extra.threediscards * card.ability.extra.td) -
			(card.ability.extra.threeplays * card.ability.extra.tp)

		return threetally > 0 and threetally or nil
	end,

	calculate = function(self, card, context)
		if context.discard and not context.blueprint and not context.other_card.debuff and
			(context.other_card:get_id() == (3) or context.other_card:get_id() == (6) or context.other_card:get_id() == (9)) then
			card.ability.extra.threediscards = card.ability.extra.threediscards + 1
			return {
				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize('k_upgrade_ex'),
					colour = G.C.ATTENTION
				}),
			}
		end

		if context.individual and context.cardarea == G.play and not context.blueprint then
			if (context.other_card:get_id() == 3) or (context.other_card:get_id() == 6) or (context.other_card:get_id() == 9) then
				card.ability.extra.threeplays = card.ability.extra.threeplays + 1

				return {
					card_eval_status_text(card, 'extra', nil, nil, nil, {
						message = 'Downgrade!',
						colour = G.C.RED
					}),
				}
			end
		end
		if context.starting_shop then
			card.ability.extra.threediscards = 0
			card.ability.extra.threeplays = 0
		end
	end
}]]
-- STAINED GLASS

SMODS.Joker {
	key = 'stainedglass',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Stained Glass',
		text = {
			'Adds a {C:attention}Glass{} card with an {C:dark_edition}Edition{}',
			'to your deck when a',
			'card with {C:diamonds}Diamond{} suit is {C:attention}destroyed{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 9, y = 4 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { colours = { suitcolor = G.C.FILTER } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		return {
			vars = {
				colours = {
					card.ability.colours.suitcolor
				}
			}
		}
	end,



	calculate = function(self, card, context)
		if context.remove_playing_cards then
			-- pretty much canio + marble joker lol
			local diamond_cards = 0
			for _, removed_card in ipairs(context.removed) do
				if removed_card:is_suit('Diamonds') then diamond_cards = diamond_cards + 1 end
			end
			local glass_card
			local glass_data
			-- run through the "create a glass card" loop once for each diamond card destroyed in that instance
			if diamond_cards > 0 then
				for i = 1, diamond_cards do
					local znm_glassedition = poll_edition('znm_stainedglass', nil, true, true,
						{ 'e_polychrome', 'e_holo', 'e_foil' })
					glass_card = SMODS.add_card { set = "Base", enhancement = "m_glass", edition = znm_glassedition, area = G.deck }
					SMODS.calculate_context({ playing_card_added = true, cards = { glass_card } })
				end
			end
		end
	end
}
--VOLCANO
SMODS.Joker {
	key = 'volcano',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Volcano',
		text = {
			'This Joker gains {X:mult,C:white} X#2# {} Mult',
			'if a {C:attention}Joker{} is sold',
			'during a {C:attention}Blind{}',
			'{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult){}',
			'{C:green,s:0.8}Art by Worldwaker2{}'
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 3 },
	-- Cost of card in shop.
	cost = 10,
	-- put all variables in here
	config = { extra = { xmult = 1, xmult_gain = 0.25 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
	end,



	calculate = function(self, card, context)
		-- this context is pretty much identical to verdant leaf funny enough
		if context.selling_card and context.card.ability.set == 'Joker' and not context.blueprint and G.GAME.blind.in_blind then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.RED
			}
		end

		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}
--[[MY FRIEND NYAN
SMODS.Joker {
	key = 'ppnyan',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	-- loc text is the in game description
	loc_txt = {
		name = 'My Friend Nyan',
		text = {
			'{X:mult,C:white}X#1#{} Mult if a {C:attention}Two Pair{}',
			'is held in hand',
			'{C:green,s:0.8}Art, Likeness & Crawfish Management by Nyan{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 4 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { xmult = 3 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
	end,



	calculate = function(self, card, context)
		if context.joker_main then
			local _, _, pokerhands, _ = G.FUNCS.get_poker_hand_info(G.hand.cards)
			if next(pokerhands['Two Pair']) then
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
	end
}]]

SMODS.Joker {
	key = 'pickuptwo',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Pickup 2',
		text = {
			'Gain {C:blue}+#1#{} hand if discard',
			'contains 2 {C:attention}Wild Cards{}',
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 5 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { hands = 1, wildreq = 2 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return { vars = { card.ability.extra.hands, card.ability.extra.wildreq } }
	end,

	in_pool = function(self, args) -- gating it silly style
		for _, playing_card in ipairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(playing_card, 'm_wild') then
				return true
			end
		end
		return false
	end,

	calculate = function(self, card, context)
		if context.discard and context.other_card == context.full_hand[#context.full_hand] then
			local wild_cards = 0

			for _, discarded_card in ipairs(context.full_hand) do
				if (SMODS.has_enhancement(discarded_card, 'm_wild') and not discarded_card.debuff) then
					wild_cards = wild_cards + 1
				end
			end

			if wild_cards >= card.ability.extra.wildreq then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_hands_played(card.ability.extra.hands)
						SMODS.calculate_effect(
							{ message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
							context.blueprint_card or card)
						colour = G.C.BLUE
						return true
					end
				}))
				return nil, true -- This is for Joker retrigger purposes
			end
		end
	end
}


--[[SMODS.Joker {
	key = 'idolswap',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	-- loc text is the in game description
	loc_txt = {
		name = 'Idol Swap',
		text = {
			'This Joker gives {X:mult,C:white}X#1#{} Mult for',
			'each {C:money}$1{} of {C:attention}sell value{} on the {C:attention}leftmost{} Joker,',
			"then {C:attention}halves{} that Joker's sell value",
			'{C:inactive,s:0.8}(Rounded down){}',
			'{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult){}',
			'{C:green,s:0.8}Concept by Tobyaaa{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 5 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { xmult = 1, tobyaaaxmult = 1 } },

	loc_vars = function(self, info_queue, card)
		if card.area and card.area == G.jokers then
			return { vars = { card.ability.extra.xmult, card.ability.extra.xmult * G.jokers.cards[1].sell_cost } }
		else
			return { vars = { card.ability.extra.xmult, card.ability.extra.xmult } }
		end
	end,



	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			card.ability.extra.tobyaaaxmult = G.jokers.cards[1].sell_cost
			G.jokers.cards[1].sell_cost = math.max(1, math.ceil(G.jokers.cards[1].sell_cost / 2))
			G.jokers.cards[1].ability.extra_value = math.max(1, math.floor(G.jokers.cards[1].ability.extra_value / 2))
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.tobyaaaxmult
			}
		end
	end
}

SMODS.Joker {
	key = 'ferrets',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	-- loc text is the in game description
	loc_txt = {
		name = 'Ferrets',
		text = {
			'{C:green}#1# in #2#{} chance to {C:attention}randomize{}',
			'rank of each {C:attention{}discarded{} card',

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 5 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { numerator = 1, denominator = 3 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_ferrets') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { numerator, denominator, } }
	end,



	calculate = function(self, card, context)
		if context.discard and SMODS.pseudorandom_probability(card, 'znm_ferrets', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_ferrets') then
			local rank = pseudorandom_element(SMODS.Ranks, pseudoseed('znm_clicker'))
			G.E_MANAGER:add_event(Event({
				func = function()
					assert(SMODS.change_base(context.other_card, nil, rank.key))

					return true
				end
			}))
			return {
				message = "!"
			}
		end
	end
}]]

SMODS.Joker {
	key = 'combinationlock',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Combination Lock',
		text = {
			'Earn {C:money}$#1#{} if ranks',
			'in {C:attention}poker hand{} add up to',
			'{C:attention}#2#{}, number changes each round',
			'{C:inactive,s:0.8}(Number chosen between 20 and 35){}',
			'{C:green,s:0.8}Concept by Bissy{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 5 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { dollars = 5 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, (G.GAME.current_round.znm_combinationlocknum or 30) } }
	end,



	calculate = function(self, card, context)
		local combinationbool = false
		local nomnum = 0
		if context.before and context.main_eval then
			for _, v in pairs(context.scoring_hand) do
				nomnum = nomnum + v.base.nominal
			end
			if nomnum == G.GAME.current_round.znm_combinationlocknum then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
				return {
					dollars = card.ability.extra.dollars,
					func = function() -- This is for timing purposes, it runs after the dollar manipulation
						G.E_MANAGER:add_event(Event({
							func = function()
								G.GAME.dollar_buffer = 0
								return true
							end
						}))
					end
				}
			end
		end
	end
}

local function reset_znm_combinationlock_num()
	--testing number
	G.GAME.current_round.znm_combinationlocknum = 914
	G.GAME.current_round.znm_combinationlocknum = pseudorandom('znm_combinationlock', 20, 35, G.GAME.round_resets.ante)
end


SMODS.Joker {
	key = 'ouijaboard',
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Ouija Board',
		text = {
			'If played hand is a single',
			'{C:attention}#1# of {V:1}#2#{},',
			'add a {C:purple}Purple Seal{} to played card',
			'{s:0.8}Card changes every round'


		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 5 },
	soul_pos = { x = 4, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_SEALS['Purple']
		local ob_card = G.GAME.current_round.znm_ouijaboard_card or { rank = 'Ace', suit = 'Spades' }
		return { vars = { localize(ob_card.rank, 'ranks'), localize(ob_card.suit, 'suits_plural'), colours = { G.C.SUITS[ob_card.suit] } } }
	end,



	calculate = function(self, card, context)
		if context.before and context.main_eval and #context.full_hand == 1 and not context.blueprint and context.full_hand[1]:get_id() == G.GAME.current_round.znm_ouijaboard_card.id and
			context.full_hand[1]:is_suit(G.GAME.current_round.znm_ouijaboard_card.suit) then
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.1,
				func = function()
					context.full_hand[1]:set_seal('Purple', nil, true)
					return true
				end
			}))
		end
	end
}

--function for setting the card idol style
local function reset_znm_ouijaboard_card()
	G.GAME.current_round.znm_ouijaboard_card = { rank = 'Ace', suit = 'Spades' }
	local valid_ob_cards = {}
	for _, playing_card in ipairs(G.playing_cards) do
		if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
			valid_ob_cards[#valid_ob_cards + 1] = playing_card
		end
	end
	local ob_card = pseudorandom_element(valid_ob_cards, 'znm_ouijaboard' .. G.GAME.round_resets.ante)
	if ob_card then
		G.GAME.current_round.znm_ouijaboard_card.rank = ob_card.base.value
		G.GAME.current_round.znm_ouijaboard_card.suit = ob_card.base.suit
		G.GAME.current_round.znm_ouijaboard_card.id = ob_card.base.id
	end
end

SMODS.Joker {
	key = 'norm',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Norm',
		text = {
			'Gain {C:blue}+#1#{} hands when {C:attention}Blind{} is selected',
			'Earn no {C:attention}interest{}',
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 5 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { hands = 2, is_changed = false } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hands, card.ability.extra.xmult_gain } }
	end,
	add_to_deck = function(self, card, from_debuff)
		if not G.GAME.modifiers.no_interest then
			G.GAME.modifiers.no_interest = true
			card.ability.extra.is_changed = true
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		if card.ability.extra.is_changed then
			G.GAME.modifiers.no_interest = false
		end
	end,
	calculate = function(self, card, context)
		--burgelar joker ohhh you know
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_hands_played(card.ability.extra.hands)
					SMODS.calculate_effect(
						{ message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
						context.blueprint_card or card)
					return true
				end
			}))
			return nil, true -- This is for Joker retrigger purposes
		end
	end

}

--[[SMODS.Joker {
	key = 'scrapbook',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	-- loc text is the in game description
	loc_txt = {
		name = 'Scrapbook',
		text = {
			'{C:mult}+#1#{} Mult for each {C:attention}Lucky Card{}',
			'in your {C:attention}full deck{}',
			'{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}',
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 5 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { mult_gain = 5 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

		local lucky_tally = 0
		if G.playing_cards then
			for _, playing_card in ipairs(G.playing_cards) do
				if SMODS.has_enhancement(playing_card, 'm_lucky') then lucky_tally = lucky_tally + 1 end
			end
		end
		return { vars = { card.ability.extra.mult_gain, ((card.ability.extra.mult_gain * lucky_tally) or 0) } }
	end,
	in_pool = function(self, args) -- makes sure it won't appear if you have 0 lucky cards
		for _, playing_card in ipairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(playing_card, 'm_lucky') then
				return true
			end
		end
		return false
	end,



	calculate = function(self, card, context)
		if context.joker_main then
			local lucky_tally = 0
			if G.playing_cards then
				for _, playing_card in ipairs(G.playing_cards) do
					if SMODS.has_enhancement(playing_card, 'm_lucky') then lucky_tally = lucky_tally + 1 end
				end

				return {
					mult = card.ability.extra.mult_gain * lucky_tally
				}
			end
		end
	end
}]]

SMODS.Joker {
	key = 'landfill',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Landfill',
		text = {
			{'{C:red}+#2#{} discard each round'},
			{'If no {C:attention}discards{} are remaining',
			'and at least {C:money}$#1#{} is held,',
			'gain {C:red}+1{} discard and lose {C:money}$#1#{}',
			'{C:green,s:0.8}Concept by Bissy{}'}
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 5 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { discardcost = 4, discardsgained = 1 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.discardcost, card.ability.extra.discardsgained } }
	end,

	add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discardsgained
		ease_discard(card.ability.extra.discardsgained)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discardsgained
		ease_discard(-card.ability.extra.discardsgained)
	end,



	calculate = function(self, card, context)
		if to_big(G.GAME.current_round.discards_left) == to_big(0) and to_big(G.GAME.dollars) >= to_big(card.ability.extra.discardcost) then
			G.GAME.current_round.discards_left = G.GAME.current_round.discards_left + card.ability.extra.discardsgained
			G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.discardcost
			return {
				dollars = -card.ability.extra.discardcost,
				func = function() -- This is for timing purposes, it runs after the dollar manipulation
					G.E_MANAGER:add_event(Event({
						func = function()
							G.GAME.dollar_buffer = 0
							return true
						end
					}))
				end
			}
		end
	end
}

--[[SMODS.Joker {
	key = 'jokerpotion',
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,

	-- loc text is the in game description
	loc_txt = {
		name = 'Joker Potion',
		text = {
			'When {C:attention}Blind{} is selected',
			'destroy a random {C:attention}Joker{} and',
			'make a random {C:attention}Joker{} {C:dark_edition}Polychrome{}',
			'Lasts {C:attention}#1#{} rounds',
			'{C:inactive}({C:attention}#2#{C:inactive} rounds remaining){}',

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 5 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { rounds = 3, rounds_remaining = 3 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		return { vars = { card.ability.extra.rounds, card.ability.extra.rounds_remaining } }
	end,
	pools = {
		Food = true
	},



	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			local destructable_jokers = {}
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
					destructable_jokers[#destructable_jokers + 1] =
						G.jokers.cards[i]
				end
			end
			local joker_to_destroy = pseudorandom_element(destructable_jokers, 'znm_jokerpotion')

			if joker_to_destroy then
				joker_to_destroy.getting_sliced = true
				G.E_MANAGER:add_event(Event({
					func = function()
						(context.blueprint_card or card):juice_up(0.8, 0.8)
						joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
						return true
					end
				}))
			end



			local edition = 'e_polychrome'
			local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
			local better_editionless_jokers = {}
			for i = #editionless_jokers, 1, -1 do
				if editionless_jokers[i] ~= card and not G.jokers.cards[i].getting_sliced then
					better_editionless_jokers[#better_editionless_jokers + 1] = editionless_jokers[i]
				end
			end

			local eligible_card = pseudorandom_element(better_editionless_jokers, 'znm_jokerpotion')
			if eligible_card then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',

					func = function()
						eligible_card:set_edition(edition, true)
						return true
					end
				}))

				return {
					message = "Glurp!",
					colour = G.C.EDITION
				}
			end
		end


		-- destroy after 3 rounds
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.rounds_remaining = card.ability.extra.rounds_remaining - 1


			if card.ability.extra.rounds_remaining == 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = "Drank!",
					colour = G.C.EDITION
				}
			end
			return {
				message = "-1",
				colour = G.C.EDITION
			}
		end
	end
}]]

SMODS.Joker {
	key = 'lightswitch',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Light Switch',
		text = {

			'Switches between {C:mult}+#2#{} Mult and {C:mult}+#3#{} Mult',
			'when using a {C:attention}consumable{}',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}',
			'{C:green,s:0.8}Concept by Freeka{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 6 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { mult = 12, multactive = 12, multinactive = 0, isactive = true, pos_override = { x = 1, y = 6 } } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.multactive, card.ability.extra.multinactive, } }
	end,
	-- taken from CCC
	afterload = function(self, card, card_table, other_card)
		card.children.center:set_sprite_pos(card_table.ability.extra.pos_override)
	end,


	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint then
			if card.ability.extra.mult == card.ability.extra.multactive then
				card.ability.extra.mult = card.ability.extra.multinactive
				card.ability.extra.pos_override.x = 1



				return {
					message = "Nighty night...",
					colour = G.C.UI.TEXT_DARK,
					G.E_MANAGER:add_event(Event({

						delay = 0.3,
						blockable = false,
						func = function()
							card.children.center:set_sprite_pos(card.ability.extra.pos_override)
							return true;
						end
					}))

				}
			else
				card.ability.extra.mult = card.ability.extra.multactive
				card.ability.extra.pos_override.x = 0

				card.children.center:set_sprite_pos(card.ability.extra.pos_override)

				return {
					message = "Wakey wakey!",
					colour = G.C.RED,
					G.E_MANAGER:add_event(Event({

						delay = 0.3,
						blockable = false,
						func = function()
							-- yoinked from CCC's Core Switch
							card.children.center:set_sprite_pos(card.ability.extra.pos_override)
							return true;
						end
					}))

				}
			end
		end
		if context.joker_main then
			if card.ability.extra.isactive then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'gnome',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Gnome',
		text = {
			'Selling a {C:attention}Joker{}',
			'creates a {C:tarot}Wheel of Fortune{}',
			'{C:inactive}(Must have room){}',
			'{C:green,s:0.8}Concept by Crispybag{}'

		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 4, y = 7 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = {  } },

	loc_vars = function(self, info_queue, card)
		
		info_queue[#info_queue + 1] = G.P_CENTERS.c_wheel_of_fortune
		return { vars = {  } }
	end,


	calculate = function(self, card, context)
		if context.selling_card and context.card.ability.set == 'Joker' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.0,
				func = (function()
					SMODS.add_card {
						key = 'c_wheel_of_fortune',
					}
					G.GAME.consumeable_buffer = 0
					return true
				end)
			}))
			return {
				message = localize('k_plus_tarot'),
				colour = G.C.PURPLE,
			}
		end 
	end
}
SMODS.Joker {
	key = 'highstriker',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'High Striker',
		text = {
			'{X:mult,C:white}X#1#{} Mult for the next {C:attention}2{} rounds',
			'if played hand is a {C:attention}Straight Flush{}',
			'{C:inactive}(#2#){}',
			'{C:green,s:0.8}Art by Worldwaker2{}'
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 6 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { xmult = 4, roundsleft = 0 } },

	loc_vars = function(self, info_queue, card)
		local remaining
		if card.ability.extra.roundsleft == 2 then
			remaining = 'Active for 2 more rounds'
		elseif card.ability.extra.roundsleft == 1 then
			remaining = 'Active for 1 more round'
		else
			remaining = 'Inactive'
		end
		return {
			vars = { card.ability.extra.xmult, remaining }
		}
	end,


	calculate = function(self, card, context)
		if context.before and next(context.poker_hands['Straight Flush']) then
			card.ability.extra.roundsleft = 2
			return {
				message = 'Active!',
				colour = G.C.ZucchinisVariousJokersRED
			}
		end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.roundsleft = card.ability.extra.roundsleft - 1
			if card.ability.extra.roundsleft == 0 then
				return {
					message = "Inactive!",
				}
			end
		end
		if context.joker_main and card.ability.extra.roundsleft > 0 then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}


SMODS.Joker {
	key = 'comet',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,


	-- loc text is the in game description
	loc_txt = {
		name = 'Comet',
		text = {
			'This Joker gains {C:mult}+#2#{} Mult',
			'if played hand is not your {C:attention}most played{} hand',
			'{C:inactive}(Currently {C:mult}+#1# {C:inactive}Mult){}',
			'{C:green,s:0.8}Art by NoahCrawfish{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 3, y = 6 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 0, mult_gain = 1 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,


	calculate = function(self, card, context)
		-- this code is pretty much identical to obelisk, funny enough i didnt realize how similarly this functioned although i think it plays differently enough that it's fine
		if context.before and context.main_eval and not context.blueprint then
			local reset = true
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for handname, values in pairs(G.GAME.hands) do
				if handname ~= context.scoring_name and values.played >= play_more_than and SMODS.is_poker_hand_visible(handname) then
					reset = false
					break
				end
			end
			if not reset then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
				return {
					message = localize('k_upgrade_ex'),
				}
			end
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}
SMODS.Joker {
	key = 'funguy',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Fun Guy',
		text = {
			'First played card',
			'of each {C:attention}suit{} gives',
			'{C:mult}+#1#{} Mult when scored'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 8, y = 6 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 5 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,


	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local is_first_spade = false
			local is_first_heart = false
			local is_first_club = false
			local is_first_diamond = false
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Spades') then
					is_first_spade = context.scoring_hand[i] == context.other_card
					break
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Hearts') then
					is_first_heart = context.scoring_hand[i] == context.other_card
					break
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Clubs') then
					is_first_club = context.scoring_hand[i] == context.other_card
					break
				end
			end
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Diamonds') then
					is_first_diamonds = context.scoring_hand[i] == context.other_card
					break
				end
			end
			if is_first_spade or is_first_heart or is_first_club or is_first_diamond then
				return {
					mult = card.ability.extra.mult
				}
			end
		end
	end
}


SMODS.Joker {
	key = 'canyon',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Grand Canyon',
		text = {
			'{C:attention}6s{}, {C:attention}7s{}, {C:attention}8s{}, and {C:attention}9s{}',
			'give {X:mult,C:white} X#1# {} Mult when scored,',
			'with a {C:green}#2# in #3#{} chance',
			'to be {C:attention}destroyed{} after scoring',
			'{C:green,s:0.8}Art by Crispybag{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 7 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { xmult = 1.35, numerator = 1, denominator = 4 } },

	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.numerator,
			card.ability.extra.denominator, 'znm_canyon') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
		return { vars = { card.ability.extra.xmult, numerator, denominator, } }
	end,

	calculate = function(self, card, context)
		local znm_canyondestroylist = {}
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 6 or context.other_card:get_id() == 7 or context.other_card:get_id() == 8 or context.other_card:get_id() == 9 then
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
		if context.before and context.main_eval then
			for i, v in pairs(context.scoring_hand) do
				if SMODS.pseudorandom_probability(card, 'znm_canyon', card.ability.extra.numerator, card.ability.extra.denominator, 'znm_canyon') and (v:get_id() == 6 or v:get_id() == 7 or v:get_id() == 8 or v:get_id() == 9) then
					znm_canyondestroylist[#znm_canyondestroylist + 1] =
						context.scoring_hand[i]
				end
			end
			if #znm_canyondestroylist > 0 then
				for i = 1, #znm_canyondestroylist do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.0,
						func = function()
							SMODS.destroy_cards(znm_canyondestroylist[i])
							return true
						end
					}))
				end
			end
		end
	end

}

SMODS.Joker {
	key = 'carnivalcannon',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	-- loc text is the in game description
	loc_txt = {
		name = 'Carnival Cannon',
		text = {
			'Played cards give',
			'{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips when scored',
			'if {C:attention}poker hand{} has been played',
			'{C:attention}#3#{} or less times this run',
			'{C:green,s:0.8}Art by Worldwaker2{}'
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 7, y = 7 },
	-- Cost of card in shop.
	cost = 5,
	-- put all variables in here
	config = { extra = { mult = 5, chips = 25, maxtimes = 3 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.maxtimes } }
	end,

	calculate = function(self, card, context)
		-- looking at that obelisk again :eyes:

		if context.individual and context.cardarea == G.play and G.GAME.hands[context.scoring_name].played <= card.ability.extra.maxtimes then
			-- uses 1 instead of the usual probability thing so that it doesn't turn into exclusively a chips joker with oops all 6s

			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult

			}
		end
	end

}

SMODS.Joker {
	key = 'bosssauce',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Boss Sauce',
		text = {
			{'{C:red}+#1#{} #2#',
			'each round'},
			{'Reduces by',
			'{C:red}1{} every round'}
		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 6 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { discards = 3 } },

	loc_vars = function(self, info_queue, card)
		local discardsleft
		if card.ability.extra.discards > 1 then
			discardsleft = 'discards'
		else
			discardsleft = 'discard'
		end
		return {
			vars = { card.ability.extra.discards, discardsleft }
		}
	end,
	-- puts it in the food pool for specifically paperback but probably other stuff too
	pools = {
		Food = true
	},

	add_to_deck = function(self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
				ease_discard(card.ability.extra.discards)

				return true
			end
		}))
	end,
	remove_from_deck = function(self, card, from_debuff)
		-- an extra clause is added here to not give a weird +0 when the card gets removed, it technically works without it it just looks a bit clunky
		if card.ability.extra.discards ~= 0 then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
					ease_discard(-card.ability.extra.discards)
					return true
				end
			}))
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if card.ability.extra.discards ~= 0 then
				card.ability.extra.discards = card.ability.extra.discards - 1
				G.GAME.round_resets.discards = G.GAME.round_resets.discards - 1
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					ease_discard(-1)
					return true
				end
			}))

			if card.ability.extra.discards == 0 then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
				return {
					message = "Drank!",
					colour = G.C.RED
				}
			end
			return {
				message = "-1",
				colour = G.C.RED
			}
		end
	end


}




--[[SMODS.Joker {
	key = 'missingposter',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	
	-- loc text is the in game description
	loc_txt = {
		name = 'Missing Poster',
		text = {
			'{X:mult,C:white}X#1#{} Mult',
			'self destructs if a',
			'{C:attention}Voucher{} is purchased',
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 0, y = 7 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { xmult = 2 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,

	calculate = function(self, card, context)
		if context.buying_card and context.card.ability.set == 'Voucher' and not context.blueprint then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					-- This part destroys the card.
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true;
						end
					}))
					return true
				end
			}))
			return {
				message = "!!",
			}
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end

}]]

SMODS.Joker {
	key = 'minesweeper',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Minesweeper',
		text = {

			{'A random rank each round',
			'gives {X:mult,C:white}X#2#{} Mult when scored, but',
			'{C:attention}adjacent{} ranks give {X:mult,C:white} X#1# {} Mult when scored'},
			{'{C:attention}Discard{} the rank to reveal it',
			'{C:inactive}(Currently {C:attention}#3#{C:inactive}){}'}

		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 1, y = 7 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { xmult = 2, evilxmult = 0.5, hasdiscarded = false } },

	loc_vars = function(self, info_queue, card)
		if card.ability.extra.hasdiscarded then
			return { vars = { card.ability.extra.xmult, card.ability.extra.evilxmult, localize((G.GAME.current_round.znm_minesweeper_rank or {}).rank or 'Ace', 'ranks') } }
		else
			return { vars = { card.ability.extra.xmult, card.ability.extra.evilxmult, 'Undiscovered' } }
		end
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == G.GAME.current_round.znm_minesweeper_rank.id then
				return {
					xmult = card.ability.extra.evilxmult
				}
			end
			if (context.other_card:get_id() == G.GAME.current_round.znm_minesweeper_rank.id + 1) or (context.other_card:get_id() == G.GAME.current_round.znm_minesweeper_rank.id - 1) then
				return {
					xmult = card.ability.extra.xmult
				}
			end
			-- extra clause for aces and twos i wonder wistfully at dusk if theres a better way to handle this
			if G.GAME.current_round.znm_minesweeper_rank.rank == '2' then
				if context.other_card:get_id() == 14 then
					return {
						xmult = card.ability.extra.xmult
					}
				end
			end
			if G.GAME.current_round.znm_minesweeper_rank.rank == 'Ace' then
				if context.other_card:get_id() == 2 then
					return {
						xmult = card.ability.extra.xmult
					}
				end
			end
		end
		if context.discard and context.other_card:get_id() == G.GAME.current_round.znm_minesweeper_rank.id and not card.ability.extra.hasdiscarded and not context.blueprint then
			card.ability.extra.hasdiscarded = true
			return {
				message = localize((G.GAME.current_round.znm_minesweeper_rank or {}).rank or 'Ace', 'ranks'),
				colour = G.C.RED
			}
		end

		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra.hasdiscarded = false
		end
	end

}

local function reset_znm_minesweeper_rank()
	-- thanks so much N' for the help! Selects a random rank independently of player's deck
	local random_rank = pseudorandom_element(SMODS.Ranks, 'znm_minesweeper')
	G.GAME.current_round.znm_minesweeper_rank = {}
	G.GAME.current_round.znm_minesweeper_rank.rank = random_rank.key
	G.GAME.current_round.znm_minesweeper_rank.id = random_rank.id
end

SMODS.Joker {
	key = 'paranoidjoker',
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Paranoid Joker',
		text = {
			{'{C:mult}+#1#{} Mult'},
			{'{C:attention}Self destructs{} if hand is played',
			'with a {C:attention}7{} or {C:attention}4{} held in hand',
			'{C:green,s:0.8}Concept by Crispybag{}'}


		}
	},
	rarity = 1,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 7 },
	-- Cost of card in shop.
	cost = 4,
	-- put all variables in here
	config = { extra = { mult = 13, goodbye = false } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end

		if context.individual and context.cardarea == G.hand and not context.end_of_round and (context.other_card:get_id() == 4 or context.other_card:get_id() == 7) and not context.other_card.debuff and not context.blueprint then
			card.ability.extra.goodbye = true
		end
		if context.after and context.main_eval and not context.blueprint and card.ability.extra.goodbye then
			-- This part plays the animation.
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					-- This part destroys the card.
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true;
						end
					}))
					return true
				end
			}))
			return {
				message = "Scared!",
			}
		end
	end

}


SMODS.Joker {
	key = 'hungryhungryjimbos',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Hungry Hungry Jimbos',
		text = {
			'If there are more than {C:attention}#2#{} cards',
			'of a rank in your {C:attention}full deck{},',
			'that rank gives {C:mult}+#1#{} Mult when scored',
			'{C:green,s:0.8}Art by GlerG{}'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 5, y = 6 },
	-- Cost of card in shop.
	cost = 7,
	-- put all variables in here
	config = { extra = { mult = 8, morethan = 4 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.morethan } }
	end,

	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			-- get the rank of the scored card
			local hungrycard = context.other_card:get_id()
			local hungrytally = 0
			if G.playing_cards then
				-- check how many instances of that rank exist in the deck
				for _, playing_card in ipairs(G.playing_cards) do
					if playing_card:get_id() == hungrycard then hungrytally = hungrytally + 1 end
				end
			end
			-- check if that number is greater than 4

			if hungrytally > card.ability.extra.morethan then
				return {

					mult = card.ability.extra.mult

				}
			end
		end
	end

}

SMODS.Joker {
	key = 'operation',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	discovered = false,

	-- loc text is the in game description
	loc_txt = {
		name = 'Operation',
		text = {
			'This Joker gains {X:mult,C:white} X#2# {} Mult',
			'for each {C:attention}consecutive{} discard',
			'containing only {V:1}#3#s{} and {V:2}#4#s{}',
			'{C:inactive,s:0.8}(switches to #5#s and #6#s next round){}',
			'{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult){}'
		}
	},
	rarity = 3,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 2, y = 6 },
	-- Cost of card in shop.
	cost = 8,
	-- put all variables in here
	config = { extra = { xmult = 1, xmult_gain = 0.1 } },

	loc_vars = function(self, info_queue, card)
		-- its sooo clunky but you gotta trust the process its the beautiful way to do things
		if G.GAME.current_round.znm_operation_polarity and G.GAME.current_round.znm_operation_polarity.suit == 'Hearts' then
			return {
				vars = {
					card.ability.extra.xmult,
					card.ability.extra.xmult_gain,
					localize('Hearts', 'suits_singular'),
					localize('Diamonds', 'suits_singular'),
					localize('Spades', 'suits_singular'),
					localize('Clubs', 'suits_singular'),
					colours = { G.C.SUITS['Hearts'], G.C.SUITS['Diamonds'], G.C.SUITS['Spades'], G.C.SUITS['Clubs'] }
				}
			}
		else
			return {
				vars = {
					card.ability.extra.xmult,
					card.ability.extra.xmult_gain,
					localize('Spades', 'suits_singular'),
					localize('Clubs', 'suits_singular'),
					localize('Hearts', 'suits_singular'),
					localize('Diamonds', 'suits_singular'),
					colours = { G.C.SUITS['Spades'], G.C.SUITS['Clubs'], G.C.SUITS['Hearts'], G.C.SUITS['Diamonds'] }
				}
			}
		end
	end,

	calculate = function(self, card, context)
		if context.pre_discard then
			local suit_tally = 0
			for _, v in pairs(context.full_hand) do
				if G.GAME.current_round.znm_operation_polarity.suit == 'Hearts' then
					if v:is_suit('Hearts') or v:is_suit('Diamonds') or v.debuff then
						suit_tally = suit_tally + 1
					end
				else
					if v:is_suit('Spades') or v:is_suit('Clubs') or v.debuff then
						suit_tally = suit_tally + 1
					end
				end
			end

			if suit_tally == #context.full_hand then
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				}
			else
				card.ability.extra.xmult = 1
				return {
					message = localize('k_reset')
				}
			end
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end

}

local function reset_znm_operation_polarity()
	-- this code is the worst way i could have done it but i started with ancient joker code and i realized i could just frankenstein it into this and i think thats beautiful
	-- please do not look at how the operation code runs
	G.GAME.current_round.znm_operation_polarity = G.GAME.current_round.znm_operation_polarity or { suit = 'Spades' }
	local operation_suits = {}
	for k, v in ipairs({ 'Spades', 'Hearts', }) do
		if v ~= G.GAME.current_round.znm_operation_polarity.suit then operation_suits[#operation_suits + 1] = v end
	end
	local operation_polarity = pseudorandom_element(operation_suits, 'znm_operation' .. G.GAME.round_resets.ante)
	G.GAME.current_round.znm_operation_polarity.suit = operation_polarity
end

SMODS.Joker {
	key = 'wateringcan',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	discovered = false,
	
	-- loc text is the in game description
	loc_txt = {
		name = 'Watering Can',
		text = {
			'Played {C:attention}Bonus Cards{}',
			'permanently gain {C:money}$#1#{}',
			'when scored'
		}
	},
	rarity = 2,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 6, y = 7 },
	-- Cost of card in shop.
	cost = 6,
	-- put all variables in here
	config = { extra = { permamoney = 1 } },

	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		return { vars = { card.ability.extra.permamoney } }
	end,
	in_pool = function(self, args)
		if G.deck and G.deck.cards then
			for j = 1, #G.deck.cards do
				if G.deck.cards[j].config.center.key == 'm_bonus' then
					return true
				end
			end
		end
	end,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_bonus') then
			--  context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars or 0
			context.other_card.ability.perma_p_dollars = context.other_card.ability.perma_p_dollars +
				card.ability.extra.permamoney
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.MONEY,
				card = card,
				focus = context.other_card,
			}
		end
	end

}

--[[SMODS.Joker {
	key = 'railroad',
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,

	-- loc text is the in game description
	loc_txt = {
		name = 'Railroad',
		text = {
			'{C:chips}+#1#{} Chips',
			'for each {C:blue}Common{} {C:attention}Joker{} card',
			'{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips){}',
		}
	},
	rarity = 1,


	atlas = 'ZucchinisVariousJokers',

	pos = { x = 3, y = 7 },

	cost = 5,

	config = { extra = { chips = 25 } },

	loc_vars = function(self, info_queue, card)

		local common_count = 0
		if G.jokers then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_rarity("Common") then common_count = common_count + 1 end
			end
		
		return { vars = { card.ability.extra.chips, ((card.ability.extra.chips * common_count) or 0) } }
	else
		return { vars = { card.ability.extra.chips,  0 } }
	end
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			local common_count = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i]:is_rarity("Common") then
					common_count = common_count + 1
				end
			end
			return  {chips = card.ability.extra.chips * common_count}
		end
	end

}]]

SMODS.Joker {
	key = 'zucchini',
	blueprint_compat = true,
	eternal_compat = true,
	discovered = false,
	perishable_compat = false,
	
	-- loc text is the in game description
	loc_txt = {
		name = 'Zucchini',
		text = {
			'This Joker gains {X:mult,C:white}X#2#{} Mult when',
			'leftmost {C:attention}Joker{} triggers',
			'{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult){}'

		}
	},
	rarity = 4,

	-- Which atlas key to pull from.
	atlas = 'ZucchinisVariousJokers',
	-- This card's position on the atlas, starting at {x=0,y=0} for the very top left.
	pos = { x = 9, y = 5 },
	soul_pos = { x = 9, y = 6 },
	-- Cost of card in shop.
	cost = 20,
	-- put all variables in here
	config = { extra = { xmult = 1, xmult_gain = 0.1 } },

	loc_vars = function(self, info_queue, card)
		return { vars = { (card.ability.extra.xmult or 1), (card.ability.extra.xmult_gain or 0.1) } }
	end,



	calculate = function(self, card, context)
		if context.post_trigger
			and context.other_card.area == G.jokers and context.other_card == G.jokers.cards[1] and context.other_card ~= card and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain

			return {

				card_eval_status_text(card, 'extra', nil, nil, nil, {
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT
				}),

			}
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}
























-- resets values
function SMODS.current_mod.reset_game_globals(run_start)
	--reset_znm_brokenrecord_rank() -- for Broken Record
	reset_znm_liontamer_rank()   -- for Lion Tamer
	--reset_znm_slothful_suit()    -- for Slothful Joker
	reset_znm_ouijaboard_card()  -- for Ouija Board
	reset_znm_combinationlock_num() -- For Combination Lock
	reset_znm_minesweeper_rank() -- for Minesweeper
	reset_znm_operation_polarity() -- for Operation
end
