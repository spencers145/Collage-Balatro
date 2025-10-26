---- -- region 1UP

---- local oneup = {
---- 	name = "ccc_1UP",
---- 	key = "1up",
---- 	config = { extra = { money = 2, money_mod = 4, money_minus = 1 } },
---- 	pos = { x = 9, y = 3 },
---- 	rarity = 2,
---- 	cost = 5,
---- 	discovered = true,
---- 	blueprint_compat = false,
---- 	eternal_compat = true,
---- 	perishable_compat = false,
---- 	atlas = "j_ccc_jokers",
---- 	credit = {
---- 		art = "Gappie",
---- 		code = "toneblock",
---- 		concept = "Kol_Oss"
---- 	},
---- 	description = "Earn $2 at the end of the round. This joker scales by $4 for the first strawberry joker sold, $3 for the second, $2 for the third, $1 for any after third.",
---- 	set_badges = function(self, card, badges)
---- 		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
---- 	end,
---- }

---- G.ccc_strawberries = {
---- 	"j_ccc_strawberry",
---- 	"j_ccc_wingedstrawberry",
---- 	"j_ccc_goldenstrawberry",
---- 	"j_ccc_wingedgoldenstrawberry",
---- 	"j_ccc_moonberry",
---- 	"j_ccc_strawberrypie",
---- 	"j_ccc_thecrowd",
---- 	"j_ccc_1up"
---- }

---- oneup.calculate = function(self, card, context)
---- 	if (context.selling_card and context.card.config.center.set == "Joker" and not (context.card == card)) then
---- 		for i = 1, #G.ccc_strawberries do
---- 			if context.card.config.center.key == G.ccc_strawberries[i] then
---- 				card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
---- 				card.ability.extra.money_mod = math.max(1, card.ability.extra.money_mod - card.ability.extra.money_minus)
---- 				card_eval_status_text(card, 'extra', nil, nil, nil,
---- 					{ message = localize('k_upgrade_ex'), colour = G.C.FILTER })
---- 				break
---- 			end
---- 		end
---- 	end
---- end

---- oneup.calc_dollar_bonus = function(self, card)
---- 	return card.ability.extra.money
---- end

---- function oneup.loc_vars(self, info_queue, card)
---- 	return { vars = { card.ability.extra.money, card.ability.extra.money_mod, card.ability.extra.money_minus } }
---- end

---- return oneup
---- -- endregion 1UP