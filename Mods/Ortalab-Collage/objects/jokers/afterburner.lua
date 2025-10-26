SMODS.Joker({
	key = "afterburner",
	atlas = "jokers",
	pos = {x = 8, y = 4},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
    config = {extra = {money = 7, money_loss = 2}},
    artist_credits = {'salad'},
	calc_dollar_bonus = function(self, card)
		return card.ability.extra.money
	end,
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.money_loss}}
    end,
    calculate = function(self, card, context) --Fuel Tank Logic
        if not context.blueprint then
            if context.end_of_round and context.main_eval then
                if G.GAME.blind.boss then
                    if card.ability.extra.money - card.ability.extra.money_loss <= 0 then
                        SMODS.destroy_cards(card)
                        return {
                            message = localize('ortalab_empty'),
                            colour = G.C.RED
                        }
                    else
                        card.ability.extra.money = card.ability.extra.money - card.ability.extra.money_loss
                        return {
                            message = localize('ortalab_leak'),
                            colour = G.C.MONEY
                        }
                    end
                end
            end
        end
    end
})
