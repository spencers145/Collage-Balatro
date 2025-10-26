SMODS.Joker {
    key = "gold_plating",
    blueprint_compat = false,
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 5},
    atlas = 'joker_atlas',
    config = { extra = { price = 1 } },
    perishable_compat = false,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end

        if context.selling_self and G.jokers.cards[#G.jokers.cards] ~= card and not context.blueprint then
            for v, joker in ipairs(G.jokers.cards) do
                if joker == card then
                    G.jokers.cards[v + 1].ability.extra_value = G.jokers.cards[v + 1].ability.extra_value + card.sell_cost
                    G.jokers.cards[v + 1]:set_cost()

                    SMODS.calculate_effect({ extra = { message = localize('k_val_up'), colour = G.C.MONEY } }, G.jokers.cards[v + 1])
                end
            end
        end
    end
}