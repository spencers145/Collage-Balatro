-- region Checkpoint

local checkpoint = {
	name = "ccc_Checkpoint",
	key = "checkpoint",
	config = { extra = { xmult = 1, xmult_scale = 0.75, did_you_discard = false, after_boss = false } },
	pos = { x = 8, y = 2 },
	rarity = 3,
	cost = 7,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Gains +0.75 XMult if Boss Blind is Defeated without discarding."
}

checkpoint.set_ability = function(self, card, initial, delay_sprites)
	if (G.GAME.blind_on_deck and G.GAME.blind_on_deck == "Boss") or 
	(G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
		card.ability.extra.after_boss = true
	else
		card.ability.extra.after_boss = false
	end
end

checkpoint.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		card.ability.extra.did_you_discard = false
		if context.blind.boss 
		or (G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
			card.ability.extra.after_boss = true
		else
			card.ability.extra.after_boss = false
		end
	end

	if context.discard and not context.blueprint then
		if card.ability.extra.after_boss == true and card.ability.extra.did_you_discard == false then
			card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Discarded", colour = G.C.RED })
			card.ability.extra.did_you_discard = true
		end
	end

	if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
		if card.ability.extra.after_boss == true and card.ability.extra.did_you_discard == false then
			card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_scale
			card_eval_status_text(card, 'extra', nil, nil, nil,
				{ message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } } })
		end
	end

	if context.joker_main then
		if card.ability.extra.xmult ~= 1 then
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

function checkpoint.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_scale } }
end

return checkpoint
-- endregion Checkpoint