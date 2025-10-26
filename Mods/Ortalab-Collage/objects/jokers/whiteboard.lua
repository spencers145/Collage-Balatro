SMODS.Joker({
	key = "whiteboard",
	atlas = "jokers",
	pos = {x = 2, y = 3},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 3}},
    artist_credits = {'flare'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            for _, card in pairs(G.hand.cards) do
                if not card:is_suit('Hearts') and not card:is_suit('Diamonds') then
                    return
                end
            end
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
})