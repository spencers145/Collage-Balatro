SMODS.Joker({
	key = "beyond_the_mask",
	atlas = "jokers",
	pos = {x = 0, y = 5},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {dollars = 1, dollars_add = 1}},
    artist_credits = {'flare','gappie'},
    enhancement_gate = 'm_ortalab_iou',
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.dollars
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_ortalab_iou
        return {vars = {card.ability.extra.dollars, card.ability.extra.dollars_add}}
    end,
	calculate = function(self, card, context) --Beyond The Mask Logic
        if context.destroy_card and context.cardarea == G.play and not context.blueprint and context.destroy_card.config.center_key == 'm_ortalab_iou' then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "dollars",
                scalar_value = "dollars_add",
                message_colour = G.C.MONEY
            })

            return {
                delay = 0.45, 
                remove = true,
                no_retrigger = true
            }
        end
    end
})