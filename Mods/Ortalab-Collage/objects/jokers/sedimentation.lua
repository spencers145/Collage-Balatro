SMODS.Joker({
	key = "sedimentation",
	atlas = "jokers",
	pos = {x = 3, y = 5},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult_per_card = 5}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_per_card, math.max(0,card.ability.extra.mult_per_card*(G.playing_cards and (#G.playing_cards - G.GAME.starting_deck_size) or 0)), G.GAME.starting_deck_size}}
    end,
    calculate = function(self, card, context) --Sedimentation Logic
        if context.joker_main and (#G.playing_cards - G.GAME.starting_deck_size) > 0 then
            return {
                mult = card.ability.extra.mult_per_card*(#G.playing_cards - G.GAME.starting_deck_size)
            }
        end
    end
})
--[[
	config = {extra = {xmult = 1, gain = 0.2}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.xmult, card.ability.extra.gain, math.max(0,card.ability.xmult + (G.playing_cards and ((#G.playing_cards - G.GAME.starting_deck_size)*card.ability.extra.gain) or 0)), G.GAME.starting_deck_size}}
    end,
    calculate = function(self, card, context) --Sedimentation Logic
        if context.joker_main and (#G.playing_cards - G.GAME.starting_deck_size) > 0 then
            return {
                xmult = card.ability.extra.xmult + ((#G.playing_cards - G.GAME.starting_deck_size)*card.ability.extra.gain)
            }
        end
    end
})]]


