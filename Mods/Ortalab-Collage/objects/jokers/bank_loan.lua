SMODS.Joker({
	key = "bank_loan",
	atlas = "jokers",
	pos = {x=9,y=0},
	rarity = 1,
	cost = 0,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {money = 20, cost = 1}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.money, card.ability.extra.cost}}
	end,
	add_to_deck = function(self, card, from_debuff)
        ease_dollars(card.ability.extra.money)
        card:set_cost()
    end,
	calc_dollar_bonus = function(self, card)
		return -card.ability.extra.cost
	end
})

local set_cost = Card.set_cost
function Card:set_cost()
    set_cost(self)
    if (self.config.center_key == 'j_ortalab_bank_loan' or (self.ability.pinkprint and self.ability.pinkprint.key == 'j_ortalab_bank_loan')) then
        self.sell_cost = -1 * self.ability.extra.money
        self.sell_cost_label = self.ability.extra.money
    end
end