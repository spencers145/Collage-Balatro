SMODS.Joker{ --Twister
    key = "twister",
    loc_txt = {
        ['name'] = 'Twister',
        ['text'] = {
            'Triggering {C:attention}seals{} has a',
            '{C:green}#1# in #2#{} chance of',
            'giving either {C:money}$3{}, {C:tarot}Tarot{},',
            '{C:planet}Planet{}, or a {C:spectral}Spectral{} card'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    config = { extra = { max = 100, min = 1, odds = 4, dollars = 3} },
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_twister') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
    -- these seals fucking suck and i gotta manually check for each
        if context.cardarea == G.hand and context.end_of_round and not context.blueprint then
            if context.other_card.seal == "Blue" then
                SMODS.calculate_context({cmykl_twister_trigger = true})
                return {
                    message = "!"
                }
            end
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.seal == "Gold" then
                SMODS.calculate_context({cmykl_twister_trigger = true})
                return {
                message = "!"
            }
            end
        end

        -- thankfully most of the modded seals only need this :pray:
        if context.cmykl_seal_trigger and not context.blueprint and G.GAME.blind.in_blind then
            SMODS.calculate_context({cmykl_twister_trigger = true})
            return {
                message = "!"
            }
        end

        if context.cmykl_twister_trigger and SMODS.pseudorandom_probability(card, 'j_cmykl_twister', 1, card.ability.extra.odds) then
            local spinthewheel = pseudorandom('j_cmykl_twister', card.ability.extra.min, card.ability.extra.max)
            --tarot
            if spinthewheel <= 31 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Tarot',
                                key_append = 'j_cmykl_twister'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_tarot'),
                    }
                end

            -- planet
            elseif spinthewheel <= 62 then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Planet',
                                key_append = 'j_cmykl_twister'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_planet'),
                    }
                end

            -- three fucking dollars
            elseif spinthewheel <= 93 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    dollars = card.ability.extra.dollars,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }

            -- the spectral
            else
                if SMODS.pseudorandom_probability(card, 'group_0_ac0a1114', 1, card.ability.extra.odds, 'j_cmykl__apparition', false) then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'j_cmykl__apparition' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_spectral'),
                        colour = G.C.SECONDARY_SET.Spectral,
                    }
                    end
                end
            end
        end
    end,
}