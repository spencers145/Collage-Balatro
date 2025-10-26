---- -- region Green Bubble

---- local greenbooster = {
---- 	name = "ccc_Green Booster",
---- 	key = "greenbooster",
---- 	config = { extra = { choices = 1 } },
---- 	pos = { x = 3, y = 2 },
---- 	rarity = 2,
---- 	cost = 6,
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
----     description = "Adds 1 extra option to all Booster Packs"
---- }

---- -- lovely abuse

---- greenbooster.calculate = function(self, card, context)
---- 	if context.open_booster then
---- 		ccc_grubble_bonus_choices = (ccc_grubble_bonus_choices or 0) + card.ability.extra.choices
---- 		card:juice_up()
---- 	end
---- end

---- function greenbooster.loc_vars(self, info_queue, card)
---- 	return { vars = { card.ability.extra.choices } }
---- end

---- return greenbooster
---- -- endregion Green Booster