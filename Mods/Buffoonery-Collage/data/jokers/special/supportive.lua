SMODS.Joker {
    key = "supportive",
    name = "Supportive Joker",
    atlas = 'buf_special',
    pos = {
        x = 4,
        y = 0,
    },
    rarity = "buf_spc",
    cost = 6,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	in_pool = false,
    config = {
        extra = { xchips = 2.5, trank = {}, tsuit = {}, scry = false },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_supportive'},
    loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		if card.ability.extra.scry == true then -- This variable controls wether to show the deck preview text
			return {
				key = self.key .. '_alt',
				vars = {card.ability.extra.trank[1], card.ability.extra.trank[2], card.ability.extra.trank[3], card.ability.extra.tsuit[1], card.ability.extra.tsuit[2], card.ability.extra.tsuit[3], card.ability.extra.xchips}
			}
		else
			return { vars = { card.ability.extra.xchips } }
		end
    end,
	update = function(self, card, dt)
		if G.deck then
			for i = 1, 3 do
				local _card = G.deck.cards[#G.deck.cards-(i-1)]
				local underscore_pos = string.find(SMODS.Suits[_card.base.suit].key, "_")  -- Checks for mod prefixes in SUIT keys and removes them from printed string (tsuit)
				if underscore_pos then
					card.ability.extra.tsuit[i] = localize('buf_'..string.sub(SMODS.Suits[_card.base.suit].key, underscore_pos + 1))
				else
					card.ability.extra.tsuit[i] =  localize('buf_'..SMODS.Suits[_card.base.suit].key)
				end
				local key = SMODS.Ranks[_card.base.value].key
				local tkey = localize('buf_'..key)
				card.ability.extra.trank[i] =  ((tkey ~= 'ERROR' and tkey) or key) .. localize('buf_of')
				local underscore_pos2 = string.find(card.ability.extra.trank[i], "_") -- Checks for mod prefixes in RANK keys and removes them from printed string (trank)
				if underscore_pos2 then
					local langkey = 'buf_'..string.sub(((tkey ~= 'ERROR' and tkey) or key), underscore_pos2 + 1)
					card.ability.extra.trank[i] = localize(langkey) .. localize('buf_of')
				end
			end
		end
	end,
	add_to_deck = function(self, card, context)
		if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
			card.ability.extra.scry = true -- Deck preview only availiable during the round
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.scry = true
		end
        if context.joker_main then
			return {
				xchips = card.ability.extra.xchips
			}
        end
		if context.end_of_round then
			card.ability.extra.scry = false
		end
    end,
	
	-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
		else
			SMODS.Joker.super.inject(self)
		end
	end
}