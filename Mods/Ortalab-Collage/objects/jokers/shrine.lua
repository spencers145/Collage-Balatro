SMODS.Sound({
    key = 'shrine',
    path = 'mythos_shrine.ogg'
})

SMODS.Joker({
	key = "shrine",
	atlas = "jokers",
	pos = {x = 6, y = 3},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {limit = 5,select = 1}},
    artist_credits = {'kosze'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.limit}}
    end,
    calculate = function(self, card, context) --Shrine Logic
        if context.after then card.ability.extra.hand_size = #context.scoring_hand end
        if context.ortalab_shrine and card.ability.extra.hand_size >= card.ability.extra.limit and (#G.consumeables.cards + G.GAME.consumeable_buffer) < G.consumeables.config.card_limit then
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
                    percent = 0.3
                    ease_background_colour{special_colour = darken(G.C.SET.ortalab_mythos, 0.5), new_colour = G.C.RED, tertiary_colour = G.C.SET.ortalab_mythos, contrast = 1}
                    return true
                end
            }))
            delay(1)
            draw_card(G.jokers, G.play, nil, nil, nil, card)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                blocking = true,
                func = function()
                    card.children.particles = Particles(1, 1, 0,0, {
                        timer = 0.01,
                        scale = 0.3,
                        initialize = true,
                        lifespan = 2,
                        speed = 6,
                        padding = -1,
                        attach = card,
                        colours = {G.C.SET.ortalab_mythos, darken(G.C.SET.ortalab_mythos, 0.5), G.C.RED, darken(G.C.SET.ortalab_mythos, 0.2), G.ARGS.LOC_COLOURS['ortalab_mythos_alt']},
                        fill = true
                    })
                    card.children.particles.fade_alpha = 1
                    card.children.particles:fade(1, 0)
                    local eval = function(card) return card.children.particles end
                    juice_card_until(card, eval, true)
                    return true
                end
            }))
            if Ortalab.Mythos_Utils.can_curse_in_area(G.hand, 1) then
                Ortalab.Mythos_Utils.curse_random_hand(card)
            end
            delay(3)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 4,
                func = function()
                    mythos = SMODS.create_card({set = 'ortalab_mythos', area = G.play})
                    mythos:add_to_deck()
                    G.play:emplace(mythos)
                    mythos.stay_in_middle = true
                    local eval = function(card) return card.stay_in_middle end
                    juice_card_until(mythos, eval, true)
                    
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1                
                    return true
                end
            }))
            draw_card(G.play, G.jokers, nil, nil, nil, card)
            delay(2)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2,
                func = function()
                    card.children.particles:remove()
                    card.children.particles = nil
                    mythos.stay_in_middle = nil         
                    return true
                end
            }))
            draw_card(G.play, G.consumeables, nil, nil, nil, mythos)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7,
                func = function()
                    ease_background_colour({special_colour = old_colours.special_colour, tertiary_colour = old_colours.tertiary_colour, new_colour = old_colours.new_colour})       
                    return true
                end
            }))
            return nil, true
        end
    end    
})

local disc = G.FUNCS.draw_from_play_to_discard
G.FUNCS.draw_from_play_to_discard = function(e)
    local hand = G.GAME.current_round.current_hand.handname
    disc(e)
    SMODS.calculate_context({ortalab_shrine = true, scoring_name = hand })
end