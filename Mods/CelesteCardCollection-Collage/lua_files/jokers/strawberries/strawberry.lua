-- region Strawberry

local strawberry = {
	name = "ccc_Strawberry",
	key = "strawberry",
	config = { extra = { money = 6, money_reduce = 1 } },
	pos = { x = 1, y = 1 },
	rarity = 1,
	cost = 6,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Earn $6 at the end of round, reduces by $1 upon cashing out",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

-- for some goddamn reason there's no easy way to add the dollar bonus at calculation... so i injected it via lovely. should work though
-- THERE IS!!! FUCK YOU PAST ME
-- i'm still not changing it

strawberry.calculate = function(self, card, context)
	if context.ccc_cash_out and not context.blueprint then -- custom cashout context in lovely
		if card.ability.extra.money > card.ability.extra.money_reduce then
			card.ability.extra.money = card.ability.extra.money - card.ability.extra.money_reduce
			card_eval_status_text(card, 'extra', nil, nil, nil,
				{ message = "-$" .. card.ability.extra.money_reduce, colour = G.C.MONEY })
		else
			G.E_MANAGER:add_event(Event({
				func = function()
					card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Eaten!", colour = G.C.FILTER })
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						blockable = false,
						func = function()
							G.jokers:remove_card(card)
							card:remove()
							card = nil
							return true;
						end
					}))
					return true
				end
			}))
		end
	end
end

strawberry.calc_dollar_bonus = function(self, card)
	return card.ability.extra.money
end

function strawberry.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.money, card.ability.extra.money_reduce } }
end

return strawberry
-- endregion Strawberry