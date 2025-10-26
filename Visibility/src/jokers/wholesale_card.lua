SMODS.Joker {
	key = 'wholesale_card',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { price_deduction = 25 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 6, y = 1 },
	cost = 5,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.deduction } }
	end,
	add_to_deck = function (self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.price_deduction
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
	end,
	remove_from_deck = function (self, card, from_debuff)
		G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.price_deduction
                for _, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
	end,
	joker_display_def = function (JokerDisplay)
		return {
			text = {
				{ text = "25% off", colour = G.C.ORANGE }
			}
		}
	end
}