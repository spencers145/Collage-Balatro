SMODS.Joker {
    key = "collector",
    unlocked = true,
    discovered = false,
    atlas = 'joker_atlas',
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 6, y = 4 },
    config = {
        extra = {
            mult = 0.02,
            added_value = 2,
        }
    },

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
                card.ability.extra.mult,
                card.ability.extra.mult * sell_cost + 1,
                card.ability.extra.added_value
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
                x_mult = card.ability.extra.mult * sell_cost + 1
            }
        end

        if context.setting_blind then
            if context.blueprint and G.jokers.cards[#G.jokers.cards] == context.blueprint_card or not context.blueprint and G.jokers.cards[#G.jokers.cards] == card then
                if #G.consumeables.cards > 0 then
                    G.consumeables.cards[1].ability.extra_value = G.consumeables.cards[1].ability.extra_value + card.ability.extra.added_value
                    G.consumeables.cards[1]:set_cost()

                    SMODS.calculate_effect({ extra = { message = localize('k_val_up'), colour = G.C.MONEY } }, G.consumeables.cards[1])
                end
            else
                for v, joker in ipairs(G.jokers.cards) do
                    if context.blueprint and joker == context.blueprint_card or not context.blueprint and joker == card then
                        G.jokers.cards[v + 1].ability.extra_value = G.jokers.cards[v + 1].ability.extra_value + card.ability.extra.added_value
                        G.jokers.cards[v + 1]:set_cost()

                        SMODS.calculate_effect({ extra = { message = localize('k_val_up'), colour = G.C.MONEY } }, G.jokers.cards[v + 1])
                    end
                end
            end
        end
    end
}
