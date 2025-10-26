SMODS.Joker({
	key = "joker_miles",
	atlas = "jokers",
	pos = {x = 4, y = 1},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {dollars_so_far = 0, dollars_per = 10}},
    artist_credits = {'logan'},'flare',
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars_per, 10 - card.ability.extra.dollars_so_far}}
    end,
    calculate = function(self, card, context)
        if (context.buying_card or (context.open_booster and not context.card.from_tag)) and not context.blueprint and context.card ~= card then
            if context.card.cost and context.card.cost > 0 then
                card.ability.extra.dollars_so_far = card.ability.extra.dollars_so_far + context.card.cost
                if card.ability.extra.dollars_so_far >= 10 then
                    card.ability.extra.dollars_so_far = card.ability.extra.dollars_so_far % 10
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        return {
                            message = "Rewards!",
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    --trigger = 'before',
                                    --delay = 0.0,
                                    func = (function()
                                        local cardd = create_card('travel', G.consumeables, false, nil, true, true, nil, 'travel')
                                        G.consumeables:emplace(cardd)
                                        cardd:start_materialize()
                                        G.GAME.consumeable_buffer = 0
                                        return true
                                    end)
                                }))
                            end
                        }
                    else
                        return {
                            message = "No Space..."
                        }
                    end
                end
            end
        end
        --[[if context.after and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'ortalab_joker_miles', 1, card.ability.extra.chance) then
                card.ability.extra.mult = 0
                return {
                    message = localize('ortalab_joker_miles_reset'),
                    colour = G.C.RED
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_gain",
                    scaling_message = {
                        message = localize('ortalab_joker_miles'),
                        colour = G.C.RED
                    }
                })
            end
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult,
            }
        end]]
    end
})