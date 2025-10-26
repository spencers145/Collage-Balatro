SMODS.Joker({
	name = "Blacklist",
	key = "blacklist",
	atlas = "jokers",
	pos = {x = 9, y = 3},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {dollars = 2, banlist_poker_hand_1 = 'High Card', banlist_poker_hand_2 = 'Pair'}},
	artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, localize(card.ability.extra.banlist_poker_hand_1, 'poker_hands'), localize(card.ability.extra.banlist_poker_hand_2, 'poker_hands')}}
    end,
	set_ability = function(self, card, initial, delay_sprites)
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.extra.banlist_poker_hand_1 = pseudorandom_element(_poker_hands, pseudoseed('blacklist1'))
		card.ability.extra.banlist_poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('blacklist2'))
		if card.ability.extra.banlist_poker_hand_1 == card.ability.extra.banlist_poker_hand_2 then
			while card.ability.extra.banlist_poker_hand_1 == card.ability.extra.banlist_poker_hand_2 do
				card.ability.extra.banlist_poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('blacklist2'))
			end
		end
	end,
    calculate = function(self, card, context)
		if context.before then
			if context.scoring_name ~= card.ability.extra.banlist_poker_hand_1 and context.scoring_name ~= card.ability.extra.banlist_poker_hand_2 then
				G.E_MANAGER:add_event(Event({
					func = function()
						self:set_ability(card)
						return true
					end
				}))
				return {
					dollars = card.ability.extra.dollars,
					colour = G.C.MONEY
				}
			end
		end
    end
})