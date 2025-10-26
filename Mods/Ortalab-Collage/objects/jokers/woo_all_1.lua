SMODS.Joker({
	key = "woo_all_1",
	atlas = "jokers",
	pos = {x = 8, y = 7},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	artist_credits = {'crimson'},
	--config = {extra = {chance = 50}},
	--[[loc_vars = function(self, info_queue, card)
		if card.area == G.jokers and card.ability.extra.enabled then
            card.ability.active_text = ' '..localize('ortalab_enabled')..' '
            card.ability.bubble_colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)

        else
            card.ability.active_text = ' '..localize('ortalab_disabled')..' '
            card.ability.bubble_colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
        end
		local main_end = (card.area and card.area == G.jokers) and {
            {n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                {n=G.UIT.C, config={ref_table = card, align = "m", colour = card.ability.bubble_colour, r = 0.05, padding = 0.06}, nodes={
                    {n=G.UIT.T, config={ref_table = card.ability, ref_value = 'active_text',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
                }}
            }}}
		return {vars = {card.ability.extra.chance}, main_end = main_end}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			if context.blind.boss then
				card.ability.extra.enabled = true
				local eval = function() return card.ability.extra.enabled end
				juice_card_until(card, eval, true)
				return {
					message = localize('ortalab_enabled'),
					colour = G.C.GREEN
				}
			else
				card.ability.extra.enabled = false
				return {
					message = localize('ortalab_disabled'),
					colour = G.C.GREY
				}
			end
		end
		if context.fix_probability and card.ability.extra.enabled then
			return {
				numerator = context.denominator
			}
		end
	end]]
	add_to_deck = function(self, card, from_debuff)
		for k, v in pairs(G.GAME.probabilities) do
			G.GAME.probabilities[k] = v/2
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for k, v in pairs(G.GAME.probabilities) do
			G.GAME.probabilities[k] = v*2
		end
	end
})

-- SMODS.DrawStep {
--     key = 'woo_all_1',
--     order = -1,
--     func = function(self)
--         if self.config.center_key == 'j_ortalab_woo_all_1' and not self.ability.extra.enabled then
--             self.children.center:draw_shader('ortalab_celadon', nil, self.ARGS.send_to_shader)
--         end
--     end,
--     conditions = { vortex = false, facing = 'front' },
-- }