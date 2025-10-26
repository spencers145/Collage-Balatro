-- region Huge Mess: Chests

local chests = {
	name = "ccc_Huge Mess: Chests",
	key = "chests",
	config = { extra = { mult = 0, mult_scale = 1 } },
	pos = { x = 1, y = 3 },
	rarity = 3,
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
    description = "When played hand contains a Three of a Kind, gains +3 Mult for each possible Pair held in hand."
}

chests.calculate = function(self, card, context)
	if context.before and (context.poker_hands ~= nil and next(context.poker_hands['Three of a Kind'])) and not context.blueprint then
		local used_rank = context.scoring_hand[1] and context.scoring_hand[1]:get_id() or nil
		local rank_counters = {}
		for i, v in ipairs(context.scoring_hand) do
			local num = tostring(v:get_id())
			rank_counters[num] = rank_counters[num] and rank_counters[num] + 1 or 1
		end
		local most = 0
		for k, v in pairs(rank_counters) do
			if v > most then
				used_rank = tonumber(k)
				most = v
			end
		end
		card.boxes_rank_array = {}
		card.boxes_card_array_length = 0
		card.boxes_pair_amounts = 0
		card.boxes_card_pair_candidate = 0
		
		for k, v in pairs(G.hand.cards) do
			card.boxes_card_array_length = card.boxes_card_array_length + 1
			card.boxes_rank_array[card.boxes_card_array_length] = v:get_id()
		end
		
		for v = 1, 13 do
			card.boxes_card_pair_candidate = 0
			for i = 1, card.boxes_card_array_length do
				if card.boxes_rank_array[i] == v + 1 then
					card.boxes_card_pair_candidate = card.boxes_card_pair_candidate + 1
				end
			end
			if used_rank and used_rank == v + 1 then 
				card.boxes_card_pair_candidate = 0
			end
			card.boxes_pair_amounts = card.boxes_pair_amounts +
			((card.boxes_card_pair_candidate - 1) * (card.boxes_card_pair_candidate)) / 2
		end
		
		if card.boxes_pair_amounts > 0 then
			card.ability.extra.mult = card.ability.extra.mult + (card.boxes_pair_amounts) * card.ability.extra.mult_scale
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Upgrade!", colour = G.C.MULT })
		end
	end

	if context.joker_main then
		if card.ability.extra.mult ~= 0 then
			return {
				message = localize {
					type = 'variable',
					key = 'a_mult',
					vars = { card.ability.extra.mult }
				},
				mult_mod = card.ability.extra.mult
			}
		end
	end
end

function chests.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.mult, card.ability.extra.mult_scale } }
end

return chests
-- endregion Huge Mess: Chests