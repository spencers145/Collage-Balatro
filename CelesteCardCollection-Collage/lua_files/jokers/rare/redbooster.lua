
---- -- region Red Booster

---- local redbooster = {
---- 	name = "ccc_Red Booster",
---- 	key = "redbooster",
---- 	config = { extra = { choices = 1 } },
---- 	pos = { x = 3, y = 3 },
---- 	rarity = 3,
---- 	cost = 8,
---- 	discovered = true,
---- 	blueprint_compat = true,
---- 	eternal_compat = true,
---- 	perishable_compat = true,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "bein",
---- 		code = "toneblock",
---- 		concept = "sunsetquasar"
---- 	},
----     description = "Allows you to pick 1 extra card from all Booster Packs"
---- }

---- -- more lovely abuse

---- redbooster.calculate = function(self, card, context)
---- 	if context.open_booster then
---- 		ccc_rrubble_bonus_choices = (ccc_rrubble_bonus_choices or 0) + card.ability.extra.choices
---- 		card:juice_up()
---- 	end
---- end

---- function redbooster.loc_vars(self, info_queue, card)
---- 	return { vars = { card.ability.extra.choices } }
---- end

---- return redbooster
---- -- endregion Red Booster

