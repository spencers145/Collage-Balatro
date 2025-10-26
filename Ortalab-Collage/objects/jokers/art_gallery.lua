SMODS.Joker({
	key = "art_gallery",
	atlas = "jokers",
	pos = {x=2,y=2},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips_add = 8}},
	artist_credits = {'flare'},
	loc_vars = function(self, info_queue, card)
        local sell_cost = 0
        for _, joker in ipairs(G.jokers and G.jokers.cards or {}) do
            sell_cost = sell_cost + joker.sell_cost
        end

        for _, consumable in ipairs(G.consumeables and G.consumeables.cards or {}) do
            sell_cost = sell_cost + consumable.sell_cost
        end
        return {
            vars = {
                card.ability.extra.chips_add,
                card.ability.extra.chips_add * sell_cost
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local sell_cost = 0
            for _, joker in ipairs(G.jokers.cards) do
                sell_cost = sell_cost + joker.sell_cost
            end

            for _, consumable in ipairs(G.consumeables.cards) do
                sell_cost = sell_cost + consumable.sell_cost
            end
            return {
                chips = card.ability.extra.chips_add * sell_cost
            }
        end
	end,
})