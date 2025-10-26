SMODS.Joker({
	key = "stonehenge",
	atlas = "jokers",
	pos = {x=3,y=1},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	artist_credits = {'gappie'},
    calculate_most_played = function(self)
        local _handname, _played, _order = 'High Card', -1, 100
        for k, v in pairs(G.GAME.hands) do
            if v.played > _played or (v.played == _played and _order > v.order) then 
                _played = v.played
                _handname = k
            end
        end
        return _handname
    end,
	hand_contains_no_rank = function(self, hand)
		for _, card in pairs(hand) do
			if card.config.center.no_rank or SMODS.has_enhancement(card, 'm_stone') then return true end
		end
		return false
	end,
	in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards) do
            if SMODS.has_no_rank(card) then return true end
        end
        return false
    end,
})

local ortalab_evaluate_poker_hand = evaluate_poker_hand
function evaluate_poker_hand(hand)
	if next(SMODS.find_card('j_ortalab_stonehenge')) then
		table.sort(hand, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
		local new_hand = {hand[1]}
		for i=2, #hand do
			if hand[i].config.center.no_rank or SMODS.has_enhancement(hand[i], 'm_stone') then
				new_hand[i] = Ortalab.find_card_to_left_with_rank(hand, i)
			else
				new_hand[i] = hand[i]
			end
		end
		return ortalab_evaluate_poker_hand(new_hand)
	end
	return ortalab_evaluate_poker_hand(hand)
end

function Ortalab.find_card_to_left_with_rank(hand, index)
	for i=index, 1, -1 do
		if not (hand[i].config.center.no_rank or SMODS.has_enhancement(hand[i], 'm_stone')) then return hand[i] end
	end
	return hand[index]
end

local ortalab_align_cards = CardArea.align_cards
function CardArea:align_cards()
	ortalab_align_cards(self)
	if next(SMODS.find_card('j_ortalab_stonehenge')) and self.config.type == 'hand' and not (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) then
		for k, card in ipairs(self.cards) do
            if card.highlighted and card.states.drag.is then
				self:parse_highlighted()
				return
			end
		end
	end
end