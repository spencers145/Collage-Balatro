SMODS.Joker({
	key = "spectrum",
	atlas = "jokers",
	pos = {x = 3, y = 8},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 2, type = 'Flush'}},
	artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, localize(card.ability.extra.type, 'poker_hands')}}
    end,
    calculate = function(self, card, context) --The Spectrum Logic
        if context.joker_main and not next(context.poker_hands["Flush"]) then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
})