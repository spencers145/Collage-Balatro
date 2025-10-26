SMODS.Joker {
    key = "porcelainj",
    name = "Porcelain Joker",
    atlas = 'buf_jokers',
    pos = {
        x = 4,
        y = 0,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	in_pool = function()
        local condition = false
        if G.playing_cards then
            for k, v in pairs(G.playing_cards) do
                if v.config.center == G.P_CENTERS.m_buf_porcelain or v.config.center == G.P_CENTERS.m_buf_porcelain_g then condition = true break end
            end
        end
        return condition
    end,
    config = {
        extra = { Xchip = 1, Xchip_gain = 0.75, tally = 0 },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_porcelainj'},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'porc_info'}
        return {
            vars = {card.ability.extra.Xchip, card.ability.extra.Xchip_gain}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			return {
				xchips = card.ability.extra.Xchip
			}
		end
    end,
	update = function(self, card)
        if G.playing_cards ~= nil then
            card.ability.extra.tally = 0

            for k, v in pairs(G.playing_cards) do
                if v.config.center == G.P_CENTERS.m_buf_porcelain or v.config.center == G.P_CENTERS.m_buf_porcelain_g then card.ability.extra.tally = card.ability.extra.tally + 1 end
            end

            card.ability.extra.Xchip = 1 + ((math.floor(card.ability.extra.tally/3)) * card.ability.extra.Xchip_gain)
        end
    end
}