SMODS.Joker({
    key = "evil_eye",
	atlas = "jokers",
	pos = {x = 5, y = 8},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	yes_pool_flag = 'shady_trading_redeemed',
	config = {extra = {money = 2, spectral_type_sold = {}}},
    artist_credits = {'flowwey'},
	calc_dollar_bonus = function(self, card)
        local count = 0
        for _,_ in pairs(card.ability.extra.spectral_type_sold) do
            count = count + 1
        end
		return card.ability.extra.money*count
	end,
	loc_vars = function(self, info_queue, card)
        local count = 0
        for _,_ in pairs(card.ability.extra.spectral_type_sold) do
            count = count + 1
        end
        return {vars = {card.ability.extra.money, card.ability.extra.money*count}}
    end,
})

local CardSell_Card = Card.sell_card --Crime Scene and Evil Eye Logic
function Card.sell_card(self)
    local evil_eye = SMODS.find_card('j_ortalab_evil_eye')
	if next(evil_eye) and self.ability.set == 'Spectral' then
        for _, card in ipairs(evil_eye) do
            card.ability.extra.spectral_type_sold[self.config.center_key] = true
            card:juice_up()
        end
	end
    return CardSell_Card(self)
end