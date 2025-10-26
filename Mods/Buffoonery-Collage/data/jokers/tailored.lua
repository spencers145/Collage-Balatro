SMODS.Joker {
    key = "tailored",
    name = "Tailored Suit",
    atlas = 'tailoratlas',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { 
			init_xmult = 4, xmult = 1, tsuit = '-', percent = 0, suit_counts = {}, suit = 'Default',
		    pos_override = { x = 0, y = 0 } -- default like normal pos
		},
    },
	sprite = {
		['Default'] = 0,
		['Diamonds'] = 1,
		['Hearts'] = 2,
		['Spades'] =3,
		['Clubs'] = 4,
		['Fleurons'] = 5,
		['Halberds'] = 6,
		['Stars'] = 7,
		['Crowns'] = 8,
	},
    loc_txt = {set = 'Joker', key = 'j_buf_tailored'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.init_xmult, card.ability.extra.xmult, card.ability.extra.tsuit}
        }
    end,
	-------- THANKS, FLOWIRE! --------
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				return true
			end
		}))
	end,
	update = function(self, card, context)
		if G.playing_cards then -- prevents a crash when looking at this joker's page in the collection
			for k in pairs(card.ability.extra.suit_counts) do -- Count occurrences of each suit
				card.ability.extra.suit_counts[k] = nil
			end
			for k, v in ipairs(G.playing_cards) do
				local suit = SMODS.Suits[v.base.suit].key
				if suit then
					card.ability.extra.suit_counts[suit] = (card.ability.extra.suit_counts[suit] or 0) + 1
				end
			end
			
			card.ability.extra.pos_override.x = 0
			card.ability.extra.percent = 0
			local leng = 0 -- Calculate percentages
			for _ in pairs(card.ability.extra.suit_counts) do -- manually counts the length of the suit_counts table
				leng = leng + 1
			end
			for suit, count in pairs(card.ability.extra.suit_counts) do
				local percentage = (count / #G.playing_cards)
				if percentage == card.ability.extra.percent then -- If there are 2 or more cards with the same percentage, the text/sprite will revert to default
					card.ability.extra.tsuit = '-'
					card.ability.extra.pos_override.x = 0
				elseif percentage > card.ability.extra.percent then
					card.ability.extra.percent = percentage
					if card.ability.extra.percent == 1/leng then  -- If all suits have the same amount of cards, it'll not say a predominant suit
						card.ability.extra.tsuit = '-'
					else
						-- card.ability.extra.tsuit = suit
						local underscore_pos = string.find(suit, "_")  -- Checks for mod prefixes in suit keys and removes them from printed string
						if underscore_pos then
							card.ability.extra.suit = string.sub(suit, underscore_pos + 1)
						else
							card.ability.extra.suit = suit
						end
						card.ability.extra.tsuit = localize('buf_'..card.ability.extra.suit)
						card.ability.extra.pos_override.x = card.config.center.sprite[card.ability.extra.suit]
					end
				end
			end
		
			card.children.center:set_sprite_pos(card.ability.extra.pos_override)
			card.ability.extra.xmult = card.ability.extra.percent * card.ability.extra.init_xmult -- Apply percentage to xmult
		else
			card.ability.extra.xmult = 1  -- Shows X1 xmult as current in the collection, alluding to the fact that the initial deck is (likely) uniform
		end
	end, 
    calculate = function(self, card, context)
		if context.joker_main then
			return {
                xmult = card.ability.extra.xmult
            }
		end
    end
}