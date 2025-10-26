SMODS.Joker({
	key = "astrologist",
	atlas = "jokers",
	pos = {x = 9, y = 13},
	rarity = 2,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mod = 2}},
	artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mod}}
    end,
	add_to_deck = function(self, card, from_debuff)
        -- G.GAME.ortalab.zodiacs.reduction = G.GAME.ortalab.zodiacs.reduction * card.ability.extra.mod
        G.GAME.ortalab.zodiacs.temp_level_mod = G.GAME.ortalab.zodiacs.temp_level_mod * card.ability.extra.mod
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- G.GAME.ortalab.zodiacs.reduction = G.GAME.ortalab.zodiacs.reduction / card.ability.extra.mod
        G.GAME.ortalab.zodiacs.temp_level_mod = G.GAME.ortalab.zodiacs.temp_level_mod / card.ability.extra.mod
    end
})