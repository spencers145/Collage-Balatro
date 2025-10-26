-- region Golden Strawberry

local goldenstrawberry ={
	name = "ccc_Golden Strawberry",
	key = "goldenstrawberry",
	config = { extra = { after_boss = false, money = 12 } },
	pos = { x = 3, y = 1 },
	rarity = 1,
	cost = 4,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Earn $15 at the end of Boss Blind",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

-- literally the simplest code in the entire mod lmao

goldenstrawberry.set_ability = function(self, card, initial, delay_sprites)
	if (G.GAME.blind_on_deck and G.GAME.blind_on_deck == "Boss") or 
	(G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
		card.ability.extra.after_boss = true
	else
		card.ability.extra.after_boss = false
	end
end

goldenstrawberry.calculate = function(self, card, context)
	if context.setting_blind and not context.blueprint then
		if context.blind.boss 
		or (G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
			card.ability.extra.after_boss = true
		else
			card.ability.extra.after_boss = false
		end
	end
end

goldenstrawberry.calc_dollar_bonus = function(self, card)
	if card.ability.extra.after_boss == true then 
		return card.ability.extra.money
	end
end

function goldenstrawberry.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.money } }
end

return goldenstrawberry
-- endregion Golden Strawberry
