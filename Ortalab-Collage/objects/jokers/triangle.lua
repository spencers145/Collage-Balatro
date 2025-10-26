SMODS.Joker({
	key = "triangle",
	atlas = "jokers",
	pos = {x = 3, y = 4},
    pixel_size = {h = 80},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {mult_add = 1, mult_total = 0}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_add, card.ability.extra.mult_total}}
    end,
    calculate = function(self, card, context) --Triangle Joker Logic
        if context.before and #context.full_hand == 3 and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult_total",
                scalar_value = "mult_add",
                message_key = 'a_mult',
                message_colour = G.C.RED
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult_total
            }
        end
    end
})