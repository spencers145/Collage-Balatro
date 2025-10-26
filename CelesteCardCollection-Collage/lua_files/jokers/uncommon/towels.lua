-- region Huge Mess: Towels

local towels = {
	name = "ccc_Huge Mess: Towels",
	key = "towels",
	config = { extra = { chips = 0, chips_scale = 7 } },
	pos = { x = 0, y = 3 },
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
    description = "When played hand contains a Flush, gains +7 Chips for each card held in hand that shares the same suit"
}

towels.calculate = function(self, card, context)
	if context.before and context.poker_hands ~= nil and next(context.poker_hands['Flush']) and not context.blueprint then
		local suits = {}
		local used_suits = {}
		for i = 1, #context.scoring_hand do
			if context.scoring_hand[i].ability.name ~= 'Wild Card' then
				if not suits[context.scoring_hand[i].base.suit] then
					suits[context.scoring_hand[i].base.suit] = 1
					used_suits[#used_suits + 1] = context.scoring_hand[i].base.suit
				else
					suits[context.scoring_hand[i].base.suit] = suits[context.scoring_hand[i].base.suit] + 1
				end
			end
		end
		local value = 0
		if #used_suits ~= 0 then
			for i = 1, #used_suits do
				if suits[used_suits[i]] > value then
					towels_flush_suit = used_suits[i]
					value = suits[used_suits[i]]
				end
			end
		else
			towels_flush_suit = 'Wild'
		end
	end

	if context.individual and context.poker_hands ~= nil and next(context.poker_hands['Flush']) and not context.blueprint then
		if context.cardarea == G.hand then
			if context.other_card:is_suit(towels_flush_suit, true) or towels_flush_suit == 'Wild' then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_scale
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
					card = card
				}
			end
		end
	end
	if context.joker_main then
		if card.ability.extra.chips ~= 0 then
			return {
				message = localize {
					type = 'variable',
					key = 'a_chips',
					vars = { card.ability.extra.chips }
				},
				chip_mod = card.ability.extra.chips
			}
		end
	end
end

function towels.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.chips, card.ability.extra.chips_scale } }
end

return towels
-- endregion Huge Mess: Towels