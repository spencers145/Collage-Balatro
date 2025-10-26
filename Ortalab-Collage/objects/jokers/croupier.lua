SMODS.Joker({
	key = "croupier",
	atlas = "jokers",
	pos = {x = 1, y = 4},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {bonus_slots = 1}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.bonus_slots}}
    end,
	add_to_deck = function(self, card, from_debuff)
		change_shop_size(card.ability.extra.bonus_slots)
	end,
	remove_from_deck = function(self, card, from_debuff)
		Ortalab.croupier_sold = (Ortalab.croupier_sold or 0) + 1
	end
})

local ortalab_reroll_shop = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(e) 
	if Ortalab.croupier_sold then SMODS.calculate_context({croupier_reroll = true}) end
	ortalab_reroll_shop()
end