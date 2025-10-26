SMODS.Joker {
    key = "dogsplayingbalatro",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = 4},
    rarity = 3,
    atlas = "NeatoJokers",
    pos = { x = 5, y = 1 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local base_chance, payout_chance = neato_get_random(card, 1, card.ability.extra)
        return { vars = {base_chance, payout_chance}}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if neato_roll_random(card, 'dogs', 1, card.ability.extra) then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = SMODS.create_card{set = "Spectral", area = G.consumeables}
                        card:add_to_deck()  -- is this needed?
                        G.consumeables:emplace(card)
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
                return {
                    message = localize('k_dog'),
                    colour = G.C.SECONDARY_SET.Planet,
                }
            end
        end
    end
}
