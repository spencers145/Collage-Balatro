SMODS.Joker({
	key = "hypercalculia",
	atlas = "jokers",
	pos = {x = 4, y = 2},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1, xmult_gain = 0.75}},
	artist_credits = {'flare'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.xmult_gain}}
	end,
	set_ability = function(self, card, initial)
		card.ability.extra.base = card.ability.extra.xmult
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			if not context.blueprint and not context.retrigger_joker then
				local faces = {}
				for _, card in ipairs(context.scoring_hand) do
					if card:is_face() then
						faces[card.base.id] = true
					end
				end
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "xmult_gain",
					message_key = 'a_xmult',
					message_colour = G.C.RED,
					operation = function(ref_table, ref_value, initial, scaling)
						ref_table[ref_value] = initial + scaling*table.size(faces)
					end,
					no_message = true
				})
			end

            return {
                xmult = card.ability.extra.xmult
            }
        end
		if context.after then
			card.ability.extra.xmult = card.ability.extra.base
		end
    end
})
