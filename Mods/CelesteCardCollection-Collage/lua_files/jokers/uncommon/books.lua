
-- region Huge Mess: Books

local books = {
	name = "ccc_Huge Mess: Books",
	key = "books",
	config = { extra = { xmult = 1, xmult_scale = 0.17 } },
	pos = { x = 2, y = 3 },
	rarity = 2,
	cost = 7,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "toneblock",
		code = "toneblock",
		concept = "Bred"
	},
	description = "When played hand contains a Straight, gains +0.14 XMult for each card in hand that extends the straight sequence."
}

-- i need to rework the logic here at some point

books.calculate = function(self, card, context)
	if context.before and not context.blueprint then
		card.books_rank_array = {}
		card.books_card_array_length = 0
		card.books_pair_amounts = 0
		card.books_card_pair_candidate = 0
		card.books_scoring_straight_array = {}
		card.books_scoring_pair = false
		card.books_highest_rank_found = false
		card.books_lowest_rank_found = false
		card.books_additional_sequence_cards = 0
		card.books_straight_border_high = 0
		card.books_straight_border_low = 0
		card.books_ace_high_scored = false
		card.books_ace_high_scored_in_hand = false
		card.books_ace_low_scored = false
		card.books_skipped_ranks = false
		card.books_allowed_skipped_ranks = {}
		card.books_repeat_non_shortcut = true
		card.books_ranks_used = {}
		card.books_vip_cards = {}
	end

	if context.before and context.poker_hands ~= nil and (next(context.poker_hands['Straight'])) and not context.blueprint then
		for i = 1, #G.hand.cards do
			card.books_card_array_length = card.books_card_array_length + 1
			card.books_rank_array[card.books_card_array_length] = G.hand.cards[i]:get_id()
			table.sort(card.books_rank_array)
		end
		for i = 1, #context.scoring_hand do
			card.books_scoring_straight_array[i] = context.scoring_hand[i]:get_id()
		end
		table.sort(card.books_scoring_straight_array)

		if not next(find_joker('Four Fingers')) then
			if not next(find_joker('Shortcut')) then
				if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
					if card.books_scoring_straight_array[1] == 2 then
						card.books_ace_low_scored = true
						card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
						table.sort(card.books_scoring_straight_array)
					else
						card.books_ace_high_scored = true
					end
				end
			else
				if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
					if card.books_scoring_straight_array[1] == 2 or card.books_scoring_straight_array[1] == 3 then
						card.books_ace_low_scored = true
						card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
						table.sort(card.books_scoring_straight_array)
					else
						card.books_ace_high_scored = true
					end
				end
			end
		end

		if next(find_joker('Four Fingers')) then -- things get a whole lot more complicated, that's what :(
			for i = 1, (#card.books_scoring_straight_array - 1) do
				if card.books_scoring_straight_array[i] == card.books_scoring_straight_array[i + 1] then
					card.books_scoring_pair = true
				end
			end
			if card.books_scoring_pair ~= true then
				if not next(find_joker('Shortcut')) then
					if card.books_scoring_straight_array[1] ~= card.books_scoring_straight_array[2] - 1 then
						table.remove(card.books_scoring_straight_array, 1)
					end
					if card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 1 then
						if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
							if card.books_scoring_straight_array[1] == 2 then
								card.books_ace_low_scored = true
								card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
								table.sort(card.books_scoring_straight_array)
								if card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 1 then
									card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
								end
							else
								card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
							end
						else
							card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
						end
					end
					if card.books_ace_low_scored == false and card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
						card.books_ace_high_scored = true
					end
				else
					if (card.books_scoring_straight_array[1] ~= card.books_scoring_straight_array[2] - 1) and (card.books_scoring_straight_array[1] ~= card.books_scoring_straight_array[2] - 2) then
						table.remove(card.books_scoring_straight_array, 1)
					end
					if (card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 1) and (card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 2) then
						if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
							if card.books_scoring_straight_array[1] == 2 or card.books_scoring_straight_array[1] == 3 then
								card.books_ace_low_scored = true
								card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
								table.sort(card.books_scoring_straight_array)
								if (card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 1) and (card.books_scoring_straight_array[#card.books_scoring_straight_array] ~= card.books_scoring_straight_array[#card.books_scoring_straight_array - 1] + 2) then
									card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
								end
							else
								card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
							end
						else
							card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
						end
					end
					if card.books_ace_low_scored == false and card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
						card.books_ace_high_scored = true
					end
				end
			else
				if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
					if card.books_scoring_straight_array[1] == 2 then
						card.books_ace_low_scored = true
						card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
						table.sort(card.books_scoring_straight_array)
					else
						card.books_ace_high_scored = true
					end
				end
				if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 then
					if card.books_scoring_straight_array[1] == 2 or card.books_scoring_straight_array[1] == 3 then
						card.books_ace_low_scored = true
						card.books_scoring_straight_array[#card.books_scoring_straight_array] = 1
						table.sort(card.books_scoring_straight_array)
					else
						card.books_ace_high_scored = true
					end
				end
			end
			if card.books_scoring_straight_array[#card.books_scoring_straight_array] == 14 and card.books_ace_low_scored == true then -- have to check if the player played another fucking ace in a low ace straight for whatever reason
				card.books_scoring_straight_array[#card.books_scoring_straight_array] = nil
			end
		end

		-- now we have an accurate books_scoring_straight_array! woo i sure hope there aren't any other problems!

		if next(find_joker('Shortcut')) then
			if (card.books_scoring_straight_array[#card.books_scoring_straight_array] - card.books_scoring_straight_array[1]) > (#card.books_scoring_straight_array - 1) then
				card.books_skipped_ranks = true
				for i = 1, (#card.books_scoring_straight_array - 1) do
					if card.books_scoring_straight_array[i] == (card.books_scoring_straight_array[i + 1] - 2) then
						card.books_allowed_skipped_ranks[#card.books_allowed_skipped_ranks + 1] = card
						.books_scoring_straight_array[i] + 1
					end
				end
			end
		end

		card.books_straight_border_low = card.books_scoring_straight_array[1]
		card.books_straight_border_high = card.books_scoring_straight_array[#card.books_scoring_straight_array]

		if not next(find_joker('Shortcut')) then
			while card.books_highest_rank_found == false do
				card.books_highest_rank_found = true
				for i = 1, card.books_card_array_length do
					if card.books_rank_array[i] == card.books_straight_border_high + 1 then
						if card.books_rank_array[i] == 14 and card.books_ace_high_scored == false then
							card.books_ace_high_scored = true
							card.books_ace_high_scored_in_hand = true
							card.books_straight_border_high = card.books_rank_array[i]
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
						end
						if card.books_rank_array[i] ~= 14 then
							card.books_highest_rank_found = false
							card.books_straight_border_high = card.books_rank_array[i]
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
						end
					end
				end
			end
			while card.books_lowest_rank_found == false do
				card.books_lowest_rank_found = true
				for i = 1, card.books_card_array_length do
					if card.books_rank_array[i] == card.books_straight_border_low - 1 then
						if card.books_rank_array[i] ~= 14 then
							card.books_lowest_rank_found = false
							card.books_straight_border_low = card.books_rank_array[i]
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
						end
					end
				end
				if card.books_straight_border_low - 1 == 1 then
					if card.books_rank_array[#card.books_rank_array] == 14 and card.books_ace_low_scored == false then
						if card.books_ace_high_scored_in_hand == true then
							if card.books_rank_array[#card.books_rank_array - 1] == 14 then
								card.books_ace_low_scored = true
								card.books_straight_border_low = 1
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = 1
							end
						else
							card.books_ace_low_scored = true
							card.books_straight_border_low = 1
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_ranks_used[#card.books_ranks_used + 1] = 1
						end
					end
				end
			end
		else
			while card.books_highest_rank_found == false do
				card.books_highest_rank_found = true
				while card.books_repeat_non_shortcut == true do
					card.books_repeat_non_shortcut = false
					for i = 1, card.books_card_array_length do
						if card.books_rank_array[i] == card.books_straight_border_high + 1 then
							if card.books_rank_array[i] == 14 and card.books_ace_high_scored == false then
								card.books_ace_high_scored = true
								card.books_ace_high_scored_in_hand = true
								card.books_straight_border_high = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
							if card.books_rank_array[i] ~= 14 then
								card.books_highest_rank_found = false
								card.books_repeat_non_shortcut = true
								card.books_straight_border_high = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
						end
					end
				end
				for i = 1, card.books_card_array_length do
					if card.books_repeat_non_shortcut == false then
						if card.books_rank_array[i] == (card.books_straight_border_high + 2) then
							if card.books_rank_array[i] == 14 and card.books_ace_high_scored == false then
								card.books_ace_high_scored = true
								card.books_ace_high_scored_in_hand = true
								card.books_straight_border_high = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
							if card.books_rank_array[i] ~= 14 then
								card.books_highest_rank_found = false
								card.books_repeat_non_shortcut = true
								card.books_straight_border_high = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
						end
					end
				end
			end
			card.books_repeat_non_shortcut = true
			while card.books_lowest_rank_found == false do
				card.books_lowest_rank_found = true
				while card.books_repeat_non_shortcut == true do
					card.books_repeat_non_shortcut = false
					for i = 1, card.books_card_array_length do
						if card.books_rank_array[i] == card.books_straight_border_low - 1 then
							if card.books_rank_array[i] ~= 14 then
								card.books_lowest_rank_found = false
								card.books_repeat_non_shortcut = true
								card.books_straight_border_low = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
						end
					end
					if card.books_straight_border_low - 1 == 1 then
						if card.books_rank_array[#card.books_rank_array] == 14 and card.books_ace_low_scored == false then
							if card.books_ace_high_scored_in_hand == true then
								if card.books_rank_array[#card.books_rank_array - 1] == 14 then
									card.books_ace_low_scored = true
									card.books_straight_border_low = 1
									card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
									card.books_ranks_used[#card.books_ranks_used + 1] = 1
								end
							else
								card.books_ace_low_scored = true
								card.books_straight_border_low = 1
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = 1
							end
						end
					end
				end
				for i = 1, card.books_card_array_length do
					if card.books_repeat_non_shortcut == false then
						if card.books_rank_array[i] == card.books_straight_border_low - 2 then
							if card.books_rank_array[i] ~= 14 then
								card.books_lowest_rank_found = false
								card.books_repeat_non_shortcut = true
								card.books_straight_border_low = card.books_rank_array[i]
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[i]
							end
						end
					end
				end
				if card.books_straight_border_low - 1 == 1 then
					if card.books_rank_array[#card.books_rank_array] == 14 and card.books_ace_low_scored == false then
						if card.books_ace_high_scored_in_hand == true then
							if card.books_rank_array[#card.books_rank_array - 1] == 14 then
								card.books_ace_low_scored = true
								card.books_straight_border_low = 1
								card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
								card.books_ranks_used[#card.books_ranks_used + 1] = 1
							end
						else
							card.books_ace_low_scored = true
							card.books_straight_border_low = 1
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_ranks_used[#card.books_ranks_used + 1] = 1
						end
					end
				end
			end
			if card.books_skipped_ranks == true then
				for i = 1, #card.books_allowed_skipped_ranks do
					for v = 1, #card.books_rank_array do
						if card.books_rank_array[v] == card.books_allowed_skipped_ranks[i] then
							card.books_additional_sequence_cards = card.books_additional_sequence_cards + 1
							card.books_allowed_skipped_ranks[i] = 0
							card.books_ranks_used[#card.books_ranks_used + 1] = card.books_rank_array[v]
						end
					end
				end
			end
		end
	end

	if context.individual and context.poker_hands ~= nil and next(context.poker_hands['Straight']) and not context.blueprint then -- there is totally a better way to do this... it's fine... i think
		if context.cardarea == G.hand then
			local triggered = false
			for i = 1, #card.books_ranks_used do
				if (context.other_card:get_id() == card.books_ranks_used[i]) or (context.other_card:get_id() == 14 and card.books_ranks_used[i] == 1) then
					table.remove(card.books_ranks_used, i)
					card.books_vip_cards[#card.books_vip_cards + 1] = context.other_card
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_scale
					triggered = true
					return {
						message = localize('k_upgrade_ex'),
						colour = G.C.MULT,
						card = card
					}
				end
			end
			if triggered == false then
				for k = 1, #card.books_vip_cards do
					if context.other_card == card.books_vip_cards[k] then
						card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_scale
						return {
							message = localize('k_upgrade_ex'),
							colour = G.C.MULT,
							card = card
						}
					end
				end
			end
		end
	end
	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				mult_mod = card.ability.extra.xmult
			}
		end
	end
end

function books.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_scale } }
end

-- endregion Huge Mess: Books

return books