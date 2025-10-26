SMODS.Joker {
    key = "gfondue",
    name = "Gold Fondue",
    atlas = 'buf_jokers',
    pos = {
        x = 4,
        y = 2,
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	no_pool_flag = 'gfondue_licked',
    config = {
        extra = { dollars = 1, used_up = false },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_gfondue'},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_sarc_strawberry
		return {
			vars = {card.ability.extra.dollars}
		}
    end,
	
    calculate = function(self, card, context)
		if context.first_hand_drawn then
			local eval = function() return G.GAME.current_round.hands_played == 0 end
			juice_card_until(card, eval, true)
		end

		if context.individual and context.other_card.area == G.play then
			return {
				focus = context.other_card,
				dollars = card.ability.extra.dollars
			}
		end

		if G.GAME.current_round.hands_played == 0 then
			if context.modify_scoring_hand and not card.ability.extra.used_up then
				local did_the_thing = false
				local used_up = {}
				local pool = {}
				for i = 1, math.min(3, #context.scoring_hand), 1 do
					pool = {}
					for key, other_card in pairs(context.scoring_hand) do
						if other_card.area == G.play then
							local used_up_already = false
							for key, value in pairs(used_up) do
								if value == other_card then
									used_up_already = true
									break
								end
							end
							if not used_up_already then
								table.insert(pool, other_card)
							end
						end
					end

					print(#pool .. " is pool size")
					print(#used_up .. " used up")
					local chosen_card = pseudorandom_element(pool, pseudoseed('gfondue_strawberry'))
					
					if chosen_card then
						did_the_thing = true
						chosen_card:set_ability(G.P_CENTERS.m_sarc_strawberry)
						table.insert(used_up, chosen_card)
					end
				end
				
				if did_the_thing then card.ability.extra.used_up = true end
			end
			if context.after and not context.blueprint and card.ability.extra.used_up then
				expire_card(card, localize('buf_gfondue_licked'), G.C.FILTER) -- custom function (see Buffoonery.lua)
				G.GAME.pool_flags.gfondue_licked = true
			end
		end
    end,
}