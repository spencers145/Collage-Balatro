SMODS.Consumable{
	set = 'Tarot', 
	atlas = 'buf_consumables',
	pos = {x = 0, y = 0},
	key = 'nobility',
	discovered = false,
	set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_tarot").."!?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	config = {extra = {count = 2, royal = 50}},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'porc_info'}
		info_queue[#info_queue+1] = {set = 'Other', key = 'porcg_info'}
		info_queue[#info_queue+1] = {set = 'Other', key = 'buf_fragile_info'}
		return {vars = {card and card.ability.extra.count or self.config.extra.count, card and card.ability.extra.royal or self.config.extra.royal}}
	end,

	can_use = function(self, card)
		if G.hand and (#G.hand.highlighted >= 1) and (#G.hand.highlighted <= card.ability.extra.count) then
			return true
		end
		return false
	end,

	use = function(self, card)
		G.E_MANAGER:add_event(Event({
			trigger = 'after', delay = 0.4, func = function()
			play_sound('tarot1')
			card:juice_up(0.3, 0.5)
			return true end }))
		local gmoney = G.GAME.dollars
		if buf.compat.talisman then gmoney = to_number(gmoney) end
		if gmoney >= card.ability.extra.royal then
			conversionTarot(G.hand.highlighted, 'm_buf_porcelain_g')
		else
			conversionTarot(G.hand.highlighted, 'm_buf_porcelain')
		end
	end,
}