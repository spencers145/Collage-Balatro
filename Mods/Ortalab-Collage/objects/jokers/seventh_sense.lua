SMODS.Joker({
    key = "seventh_sense",
    atlas = "jokers",
    pos = {x = 0, y = 7},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {rank = "7", primed = nil}},
    artist_credits = {'cejai'},
    loc_vars = function(self, info_queue, card)
        return {vars = {localize(card.ability.extra.rank, 'ranks') or localize('ortalab_rank')}}
    end,
    calculate = function(self, card, context)
        if context.destroying_card and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 and Ortalab.hand_contains_rank(context.scoring_hand, card.ability.extra.rank) then
            card.ability.extra.primed = nil
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            local mythos
            local old_colours = {
                special_colour = copy_table(G.C.BACKGROUND.C),
                tertiary_colour = copy_table(G.C.BACKGROUND.D),
                new_colour = copy_table(G.C.BACKGROUND.L),
            }
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()            
                    play_sound('ortalab_shrine', nil, 2)
                    ease_background_colour{special_colour = darken(G.C.SET.ortalab_mythos, 0.5), new_colour = G.C.RED, tertiary_colour = G.C.SET.ortalab_mythos, contrast = 1}
                    return true
                end
            }))
            delay(1)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                blocking = true,
                func = function()
                    context.destroying_card.children.particles = Particles(1, 1, 0,0, {
                        timer = 0.01,
                        scale = 0.3,
                        initialize = true,
                        lifespan = 2,
                        speed = 6,
                        padding = -1,
                        attach = context.destroying_card,
                        colours = {G.C.SET.ortalab_mythos, darken(G.C.SET.ortalab_mythos, 0.5), G.C.RED, darken(G.C.SET.ortalab_mythos, 0.2), G.ARGS.LOC_COLOURS['ortalab_mythos_alt']},
                        fill = true
                    })
                    context.destroying_card.children.particles.fade_alpha = 1
                    context.destroying_card.children.particles:fade(1, 0)
                    local eval = function(card) return card.children.particles end
                    juice_card_until(context.destroying_card, eval, true)
                    return true
                end
            }))
            delay(3)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 4,
                func = function()
                    mythos = SMODS.create_card({set = 'ortalab_mythos', area = G.consumeables})
                    mythos:add_to_deck()
                    G.consumeables:emplace(mythos)
                    mythos.stay_in_middle = true
                    local eval = function(card) return card.stay_in_middle end
                    juice_card_until(mythos, eval, true)
                    context.destroying_card:start_dissolve()
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1                
                    return true
                end
            }))
            delay(2)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2,
                func = function()
                    
                    context.destroying_card.children.particles:remove()
                    context.destroying_card.children.particles = nil
                    mythos.stay_in_middle = nil         
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()
                    ease_background_colour({special_colour = old_colours.special_colour, tertiary_colour = old_colours.tertiary_colour, new_colour = old_colours.new_colour})       
                    return true
                end
            }))
            return { remove = true }
        end
    end
})