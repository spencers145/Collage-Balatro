SMODS.Joker({
    key = "koko",
    atlas = "jokers",
    pos = {x = 2, y = 12},
    soul_pos = {x = 3, y = 12},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {zodiacs = {}, increase = 2}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.increase}}
    end,

    -- yes this is literally the code for infinite jest from AIJ
    -- maybe a placeholder just go with it for now
    calculate = function(self, card, context)
      if context.setting_blind and context.main_eval then
        local eff_card = context.blueprint_card or card
        --literally just black hole
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize('k_all_hands'),chips = '...', mult = '...', level=''})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            eff_card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            eff_card:juice_up(0.8, 0.5)
            return true end }))
        update_hand_text({delay = 0}, {chips = '+', StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            eff_card:juice_up(0.8, 0.5)
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level='+1'})
        delay(1.3)
        for k, v in pairs(G.GAME.hands) do
            level_up_hand(eff_card, k, true)
        end
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
      end
    end
    --[[set_ability = function(self, card, initial, delay)
        for k, _ in pairs(G.ZODIACS) do
            if k ~= 'zodiac_ortalab_ophiuchus' then
                card.ability.extra.zodiacs[#card.ability.extra.zodiacs+1] = k
            end
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
           
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            ease_background_colour{new_colour = G.C.BLUE, contrast = 1}                
                            return true
                        end
                    }))
                end,
                extra = {
                    func = function()
                        for _, key in ipairs(card.ability.extra.zodiacs) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.1,
                                func = function()
                                    if G.zodiacs and G.zodiacs[key] then
                                        G.zodiacs[key].config.extra.temp_level = G.zodiacs[key].config.extra.temp_level + (card.ability.extra.increase * G.GAME.ortalab.zodiacs.temp_level_mod)
                                    else
                                        local zod = Zodiac(key)
                                        zod.config.extra.temp_level = 2
                                        add_zodiac(zod, true)
                                    end
                                    return true
                                end
                            }))
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.7,
                            func = function()
                                ease_background_colour{new_colour = G.C.BLIND['Small'], contrast = 1}                
                                return true
                            end
                        }))
                    end,
                    message = localize('ortalab_koko'),
                    colour = G.C.BLUE,
                }
            }
        end
    end]]
})

--[[SMODS.JimboQuip({
    key = 'koko_1',
    extra = {
        center = 'j_ortalab_koko',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        return true, { weight = 5 } 
    end
})]]

--[[SMODS.JimboQuip({
    key = 'koko_win',
    extra = {
        center = 'j_ortalab_koko',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'win' then
            self.extra.text_key = self.key..'_'..math.random(1,2)
            return true, { weight = 1 }
        end
    end
})]]

--[[SMODS.JimboQuip({
    key = 'koko_loss',
    extra = {
        center = 'j_ortalab_koko',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'loss' then
            return true, { weight = 1 }
        end
    end
})]]