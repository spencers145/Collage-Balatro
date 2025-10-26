SMODS.Joker {
    key = "dorkshire",
    name = "Dorkshire Tea",
    atlas = 'buf_jokers',
    pos = {
        x = 4,
        y = 1,
    },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    loc_txt = {set = 'Joker', key = 'j_buf_dorkshire'},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'porc_info'}
		if buf.compat.unstable then
            return {
				key = self.key .. '_alt', 
			}
		end 
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint then
			local tcards = {}
			local check = false
			for k, v in ipairs(context.scoring_hand) do
				if (v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 10 or 
				SMODS.Ranks[v.base.value].key == 'unstb_12' or SMODS.Ranks[v.base.value].key == 'unstb_13' or
				SMODS.Ranks[v.base.value].key == 'unstb_21' or SMODS.Ranks[v.base.value].key == 'unstb_25')
				and not (v.config.center == G.P_CENTERS.m_buf_porcelain or v.config.center == G.P_CENTERS.m_buf_porcelain_g) then -- will not overwrite Royal Porcelain
					check = true
					tcards[#tcards+1] = v
					v:set_ability(G.P_CENTERS.m_buf_porcelain, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			if check then SMODS.calculate_effect({message = localize('buf_tea'), colour = G.C.GREEN}, card) end
        end
    end
}