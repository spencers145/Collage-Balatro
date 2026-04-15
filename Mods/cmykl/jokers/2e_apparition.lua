SMODS.Joker{ -- Apparition
    key = "apparition",
    config = {
        extra = {
            odds = 8
        }
    },
    loc_txt = {
        ['name'] = 'Apparition',
        ['text'] = {
            [1] = '{C:green}#1# in #2# chance{} to',
            [2] = 'create a {C:spectral}Spectral{} card',
            [3] = 'per {C:attention}reroll{} in the shop'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    soul_pos = {
        x = 1,
        y = 2
    },
    draw = function(self, card, layer)
        if card.config.center.discovered or card.bypass_discovery_center then
            card.children.center:draw_shader('voucher', nil, card.ARGS.send_to_shader)
        end
    end,
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl__apparition') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.reroll_shop then
            if true then
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
    end
}