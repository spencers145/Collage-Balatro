
-- region Theo Crystal

local theocrystal = {
	name = "ccc_Theo Crystal",
	key = "theocrystal",
	config = { extra = { scale = 0.5, probs = 2 } },
	pixel_size = { w = 71, h = 71 },
	pos = { x = 9, y = 2 },
	rarity = 3,
	cost = 12,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	atlas = "j_ccc_jokers",
	add_to_deck = function(self, card, from_debuff)
		if G.jokers ~= nil then -- this is always true?
			G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.probs
		end
	end,
	remove_from_deck = function(self, card, from_debuff)
		for k, v in ipairs(G.hand.cards) do
			if v.ability.forced_selection then
				v.ability.forced_selection = false
			end
		end
		G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.probs
	end,
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "toneblock"
	},
    description = "Forces one card to always be selected. Adds +1 to all listed probabilites at round end."
}

-- lovely injections to deal with the probability system (what a pain)

-- scale and probs are only for display purposes and are not actually used

-- also using lovely to hijack Blind:drawn_to_hand? this is so scuffed

theocrystal.set_ability = function(self, card, initial, delay_sprites)
	if (G.GAME.blind_on_deck and G.GAME.blind_on_deck == "Boss") or 
	(G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
		card.ability.extra.boss = true
	else
		card.ability.extra.boss = false
	end
end

theocrystal.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		if context.blind.boss 
		or (G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
			card.ability.extra.boss = true
		else
			card.ability.extra.boss = false
		end
	end
	
	if context.end_of_round and card.ability.extra.boss and not context.blueprint and not context.individual and not context.repetition then
		G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.probs
		card.ability.extra.probs = card.ability.extra.probs + card.ability.extra.scale
		G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.probs

		card_eval_status_text(card, 'extra', nil, nil, nil, { message = "X" .. (card.ability.extra.probs), colour = G.C.GREEN })
	end
end

function theocrystal.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.scale, card.ability.extra.probs } }
end

return theocrystal
-- endregion Theo Crystal	