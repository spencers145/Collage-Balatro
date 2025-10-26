SMODS.Joker({
    key = "solo",
    atlas = "jokers",
	pos = {x = 1, y = 8},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {x_mult = 2.5, type = 'High Card'}},
    artist_credits = {'flowwey'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult, localize(card.ability.extra.type, 'poker_hands')}}
    end,
    calculate = function(self, card, context) --The Solo Logic
        if context.joker_main then
            if context.scoring_name == 'High Card' then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
})