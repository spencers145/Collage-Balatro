SMODS.Joker{
	key = 'moralsupport',
	atlas = 'roffers',
	rarity = 1,
	cost = 1,
	blueprint_compat = false,
	discovered = false,
	pos = { x = 2, y = 7 },
	config = { extra = {} },
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.slots}}
	end,
	calculate = function(self,card,context)
		if context.setting_blind and G.GAME.blind:get_type() == 'Boss' then
			local rand = pseudorandom('moralsupport')
			local msgindex = math.floor(rand * 4) + 1 -- message indices 1-5
			return {
				message = localize('k_roff_buddy_msg' .. msgindex)
			}
		end
	end,
	add_to_deck = function (self, card, from_debuff) --joker slot size change is hardcoded so that main channel doesn't mess with it
		G.jokers:change_size(1)
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.jokers:change_size(-1)
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
