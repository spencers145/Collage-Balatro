-- region Strawberry Pie

local strawberrypie = {
	name = "ccc_Strawberry Pie",
	key = "strawberrypie",
	config = { extra = { mult = 45, chips = 120, xmult = 5 } },
	pos = { x = 8, y = 5 },
	rarity = 3,
	cost = 13,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Kol_Oss"
	},
    description = "Grants a large bonus based on current money; $30-$79: +120 Chips; $80-$174: +45 Mult; $175+: X5 Mult",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

strawberrypie.calculate = function(self, card, context)
	if context.joker_main then
		local dollars = math.max(0, (to_big(G.GAME.dollars) + (to_big(G.GAME.dollar_buffer) or 0))) -- idk what to wrap in to_big
		if to_big(dollars) >= to_big(30) and to_big(dollars) < to_big(80) then
			return {
				message = localize {
					type = 'variable',
					key = 'a_chips',
					vars = { card.ability.extra.chips }
				},
				chip_mod = card.ability.extra.chips
			}
		elseif to_big(dollars) >= to_big(80) and to_big(dollars) < to_big(175) then
			return {
				message = localize {
					type = 'variable',
					key = 'a_mult',
					vars = { card.ability.extra.mult }
				},
				mult_mod = card.ability.extra.mult
			}
		elseif to_big(dollars) >= to_big(175) then
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				Xmult_mod = card.ability.extra.xmult
			}
		end
	end
end

function strawberrypie.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult } }
end

return strawberrypie
-- endregion Strawberry Pie