SMODS.Atlas({
    key = 'loteria_cards',
    path = 'loteria.png',
    px = '71',
    py = '95'
})

SMODS.UndiscoveredSprite({
    key = 'ortalab_loteria',
    atlas = "loteria_cards",
    pos = { x = 0, y = 4 },
    no_overlay = true
})

SMODS.ConsumableType({
    key = "ortalab_loteria",
    primary_colour = HEX("CC56CC"),
    secondary_colour = HEX("A85D7C"),
    collection_rows = {6, 5},
    shop_rate = 2,
    default = 'c_ortalab_lot_rooster'
})

SMODS.Consumable({
    key = 'lot_rooster',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=0},
    discovered = false,
    config = {extra = {sets = {'ortalab_loteria', 'ortalab_zodiac'}}},
    artist_credits = {'parchment'},
    can_use = function(self, card)
        if G.GAME.Ortalab and G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            return true
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        local options = {}
        for _, type in pairs(card.ability.extra.sets) do
            if G.GAME.Ortalab.usage[type] then
                for key, count in pairs(G.GAME.Ortalab.usage[type]) do
                    for i=1, count do
                        options[#options + 1] = key
                    end
                end
            end
        end
        play_sound('timpani')
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        if #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit then
            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, pseudorandom_element(options, pseudoseed('rooster_card')), 'rooster')
            card:add_to_deck()
            G.consumeables:emplace(card)
            card:juice_up(0.3, 0.5)
        end
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
    end
})

SMODS.Consumable({
    key = 'lot_melon',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=4},
    discovered = false,
    config = {extra = {key = 'm_ortalab_recycled', amount = 2}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_scorpion',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=3},
    discovered = false,
    config = {extra = {type = 'ortalab_zodiac', amount = 2}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        create_consumables(card)
    end
})

SMODS.Consumable({
    key = 'lot_umbrella',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=0},
    discovered = false,
    config = {extra = {key = 'm_ortalab_bent', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_barrel',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=3},
    discovered = false,
    config = {extra = {type = 'ortalab_loteria', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card and (card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)) or self.config.extra.amount}}
    end,
    can_use = function(self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        create_consumables(card)
    end
})

SMODS.Consumable({
    key = 'lot_mandolin',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=3},
    discovered = false,
    config = {extra = {key = 'm_ortalab_post', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_ladder',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=1},
    discovered = false,
    config = {extra = {key = 'm_ortalab_index', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_siren',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=0},
    discovered = false,
    config = {extra = {key = 'm_ortalab_rusty', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_bird',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=3},
    discovered = false,
    config = {extra = {key = 'm_ortalab_sand', amount = 2}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_bonnet',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=4},
    discovered = false,
    config = {extra = {min = -3, max = 20}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {math.abs(card.ability.extra.min), card.ability.extra.max}}
    end,
    can_use = function (self, card)
        return standard_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local doubled = to_big(G.GAME.dollars) >= to_big(card.ability.extra.max) and 2 or 1
        local money = pseudorandom(pseudoseed('bonnet'), card.ability.extra.min * doubled, card.ability.extra.max * doubled)
        ease_dollars(money)
    end
})

SMODS.Consumable({
    key = 'lot_pear',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=0},
    discovered = false,
    config = {extra = {chance = 4, amount = 1}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {SMODS.get_probability_vars(card, 1, card.ability.extra.chance)}}
    end,
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            for _, v in pairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) and not v.ability.kopi and not v.ability.shinku then
                    return true
                end
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local eligible_jokers = {}
        for k, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition) then
                table.insert(eligible_jokers, v)
            end
        end
        if SMODS.pseudorandom_probability(card, 'pear_roll', 1, card.ability.extra.chance) then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local over = false
                local eligible_card = pseudorandom_element(eligible_jokers, pseudoseed('pear_select'))
                local edition = poll_edition('pear_poll', nil, nil, true, {'e_ortalab_anaglyphic', 'e_ortalab_greyscale', 'e_ortalab_fluorescent', 'e_ortalab_overexposed'})
                eligible_card:set_edition(edition, true)
                check_for_unlock({type = 'have_edition'})
                card:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.ortalab_loteria,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end
})

SMODS.Consumable({
    key = 'lot_flag',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=2},
    discovered = false,
    config = {extra = {selected = 2, rank_change = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), card.ability.extra.rank_change}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        local signs = {1, -1}
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
            local change = pseudorandom(pseudoseed('flag_change'), 1, card.ability.extra.rank_change)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    for j=1, change do
                        G.hand.highlighted[i].base.id = G.hand.highlighted[i].base.id + signs[2 - (i % 2)]
                        local rank_suffix = get_rank_suffix(G.hand.highlighted[i])
                        assert(SMODS.change_base(G.hand.highlighted[i], nil, rank_suffix))
                    end
                    return true
                end
            }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
        delay(0.5)
    end
})

SMODS.Consumable({
    key = 'lot_bottle',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=2},
    discovered = false,
    config = {extra = {amount = 2, selected = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local destroyed_cards = {}
        for i=#G.hand.highlighted, 1, -1 do
            destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                for i=#G.hand.highlighted, 1, -1 do
                    local card = G.hand.highlighted[i]
                    if SMODS.shatters(card) then 
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #G.hand.highlighted)
                    end
                end
                return true end }))
        SMODS.calculate_context({ remove_playing_cards = true, removed = destroyed_cards })
        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
            local new_cards = {}
            for i=1, card.ability.extra.amount + G.GAME.ortalab.vouchers.tabla do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                    local new_card = create_playing_card({center = G.P_CENTERS[pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle'))]}, G.play)
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    new_cards[i] = new_card
                    return true
                end}))
                for j=1, 10 do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        new_cards[i]:juice_up(0.7, 0.3)
                        play_sound('generic1')
                        bottle_randomise(new_cards[i])
                        return true
                    end}))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                play_sound('holo1')
                playing_card_joker_effects(new_cards)
                for _, card in pairs(new_cards) do
                    card:juice_up(0.7, 0.3)
                    draw_card(G.play, G.hand, 1, 'up', false, card, nil, true)
                end
                delay(0.5)
                return true
            end}))
            return true
        end}))
    end
})

SMODS.Consumable({
    key = 'lot_harp',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=1},
    discovered = false,
    config = {extra ={selected = 2}},
    artist_credits = {'parchment'},
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            if #G.hand.highlighted == card.ability.extra.selected then
                return true
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a,b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        local card1 = G.hand.highlighted[1]
        local card_1_info = {
            rank = get_rank_suffix(card1),
            suit = card1.base.suit,
            enhancement = card1.ability.set == 'Enhanced' and card1.config.center or nil,
            edition = card1.edition and card1.edition.type and 'e_'..card1.edition.type or nil,
            seal = card1.seal or nil,
            curse = card1.curse or nil
        }
        local card2 = G.hand.highlighted[2]
        local card_2_info = {
            rank = get_rank_suffix(card2),
            suit = card2.base.suit,
            enhancement = card2.ability.set == 'Enhanced' and card2.config.center or nil,
            edition = card2.edition and card2.edition.type and 'e_'..card2.edition.type or nil,
            seal = card2.seal or nil,
            curse = card2.curse or nil
        }
        local new_card

        delay(0.5)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.35, func = function()
            draw_card(G.hand, G.play, 1, 'up', false, card1, nil, true)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                new_card = create_playing_card({center = pseudorandom_element({card1.config.center, card2.config.center}, pseudoseed('harp_card'))}, G.play)
                new_card:add_to_deck()
                harp_randomise(new_card, card_1_info, card_2_info)
                return true
            end}))
            draw_card(G.hand, G.play, 1, 'up', false, card2, nil, true)

            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                for _, card in pairs(G.play.cards) do
                    card.particles = Particles(1, 1, 0,0, {
                        timer = 0.15,
                        scale = 0.3,
                        initialize = true,
                        lifespan = 1,
                        speed = 3,
                        padding = -1,
                        attach = card,
                        colours = {G.ARGS.LOC_COLOURS.ortalab_loteria, lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2)},
                        fill = true
                    })
                    card.particles.fade_alpha = 1
                    card.particles:fade(1, 0)
                end
                return true
            end}))
            for i=1, 10 do
                for j=1, 3 do
                    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
                        G.play.cards[j]:juice_up(0.7, 0.3)
                        play_sound('generic1')
                        harp_randomise(new_card, card_1_info, card_2_info)
                        return true
                    end}))
                end
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.5,func = function()
                card1:start_dissolve()
                card2:start_dissolve()
                play_sound('holo1')
                new_card.particles:remove()
                return true
            end}))
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()     
                    draw_card(G.play, G.hand, 1, 'up', false, new_card, nil, true)
                    return true
                end
            }))
            return true
        end}))
    end
})

local function count_possessed()
    local count = 0
    for _, card in pairs(G.hand.highlighted) do
        if card.curse == 'ortalab_possessed' then count = count + 1 end
    end
    return count
end

SMODS.Consumable({
    key = 'lot_heron',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=1},
    discovered = false,
    config = {extra = {money = 1, value = 2, amount = 3}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.value, card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)        }}
    end,
    can_use = function(self, card)
        return #G.hand.cards > 0 and count_possessed() <= card.ability.extra.amount
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, loteria, area, copier)
        track_usage(loteria.config.center.set, loteria.config.center_key)
        local cards = {}
        local available_cards = {}
        for _, card in pairs(G.hand.cards) do
            if card:get_chip_bonus() > 0 or get_chips_from_enhancement(card) > 0 or get_chips_from_edition(card) > 0 then
                table.insert(available_cards, card)
            end
        end

        G.hand:unhighlight_all()

        for i=1, math.min(loteria.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, #available_cards) - #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                local selected = false
                while not selected do
                    local selected_card = pseudorandom_element(available_cards, pseudoseed('heron'))
                    if not selected_card.highlighted then
                        G.hand:add_to_highlighted(selected_card)
                        selected = true
                    end
                end
                return true
            end}))
        end
        table.sort(G.hand.highlighted, function (a,b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
            local total = 0
            local temp_total = 0
            for _, card in pairs(G.hand.highlighted) do
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                    local chips = card:get_chip_bonus()
                    local edition_chips = get_chips_from_edition(card)
                    local enhancement_chips = get_chips_from_enhancement(card)
                    chips = chips + edition_chips + enhancement_chips
                    local money = math.floor(chips/loteria.ability.extra.value)
                    card_eval_status_text(card, 'dollars', money, nil, nil, {instant = true})
                    temp_total = total + money
                            if temp_total >= 40 then
                                total = 40
                            else
                                total = total + money
                        end
                    return true
                end}))
            end
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function() ease_dollars(total); return true; end}))
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.35,func = function()
                G.hand:unhighlight_all()
                return true
            end}))
            return true
        end}))
    end
})

function get_chips_from_edition(card)
    if not card.edition then return 0 end
    local ret = card:calculate_edition({main_scoring = true, cardarea = G.play})
    if not ret then return 0 end
    if ret.chips then return ret.chips end
    if ret.chip_mod then return ret.chip_mod end
    return 0
end

function get_chips_from_enhancement(card)
    if card.config.center.set ~= 'Enhanced' then return 0 end
    local ret = card:calculate_enhancement({heron_check = true})
    if not ret then return 0 end
    if ret.chips then return ret.chips end
    if ret.chip_mod then return ret.chip_mod end
    return 0
end

SMODS.Consumable({
    key = 'lot_rose',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=4},
    discovered = false,
    config = {extra = {key = 'm_ortalab_iou', amount = 2}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key) 
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_dandy',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=2, y=2},
    discovered = false,
    config = {extra = {key = 'm_ortalab_ore', amount = 2}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[self.config.extra.key]
        return {vars = {card.ability.extra.amount + (G.GAME and G.GAME.ortalab.vouchers.tabla)}}
    end,
    can_use = function(self, card)
        return can_enhance_cards(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        use_enhance_cards(self, card, area, copier)
    end
})

SMODS.Consumable({
    key = 'lot_boot',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=4, y=2},
    discovered = false,
    config = {extra = {selected = 5, suits = {'Diamonds', 'Spades'}}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), localize(card.ability.extra.suits[1], 'suits_plural'), localize(card.ability.extra.suits[2], 'suits_plural'),
        colours = {G.C.SUITS[card.ability.extra.suits[1]], G.C.SUITS[card.ability.extra.suits[2]]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        random_suits(G.hand.highlighted, card.ability.extra.suits)
        G.hand.config.highlighted_limit = card.ability.extra.highlight_limit or 5
    end
})

SMODS.Consumable({
    key = 'lot_parrot',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=1},
    discovered = false,
    config = {extra = {selected = 5, suits = {'Hearts', 'Clubs'}}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), localize(card.ability.extra.suits[1], 'suits_plural'), localize(card.ability.extra.suits[2], 'suits_plural'),
        colours = {G.C.SUITS[card.ability.extra.suits[1]], G.C.SUITS[card.ability.extra.suits[2]]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        random_suits(G.hand.highlighted, card.ability.extra.suits)
        G.hand.config.highlighted_limit = card.ability.extra.highlight_limit or 5
    end
})

SMODS.Consumable({
    key = 'lot_heart',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=3, y=1},
    discovered = false,
    config = {extra = {selected = 5, suits = {'Hearts', 'Diamonds'}}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), localize(card.ability.extra.suits[1], 'suits_plural'), localize(card.ability.extra.suits[2], 'suits_plural'),
        colours = {G.C.SUITS[card.ability.extra.suits[1]], G.C.SUITS[card.ability.extra.suits[2]]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        random_suits(G.hand.highlighted, card.ability.extra.suits)
        G.hand.config.highlighted_limit = card.ability.extra.highlight_limit or 5
    end
})

SMODS.Consumable({
    key = 'lot_hand',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=0, y=2},
    discovered = false,
    config = {extra = {selected = 1}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        local main_end = nil
        if G.jokers then
            for _, joker in ipairs(SMODS.merge_lists({G.jokers.cards, G.consumeables.cards})) do
                if joker:is_rarity(4) then
                    main_end = {n=G.UIT.C, config={align = "cm"}, nodes={
                            {n=G.UIT.T, config = {text = localize('ortalab_hand_legendary'), colour = G.ARGS.LOC_COLOURS.inactive, scale = 0.25}}
                    }}
                    break
                end
            end
        end
        return {vars = {card.ability.extra.selected}, main_end = {main_end}}
    end,
    can_use = function(self, card)
        if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
            local target = G.jokers.highlighted[1] or G.consumeables.highlighted[#G.consumeables.highlighted]
            if target and target.ability.set == 'Joker' and not target:is_rarity(4) then
                local pool = get_current_pool('Joker', target.config.center.rarity)
                if #pool == 1 and pool[1] == 'j_joker' or pool[1] == 'j_ortalab_jester' then return false end
                return true
            end
        end
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        local joker = G.jokers.highlighted[1] or G.consumeables.highlighted[#G.consumeables.highlighted]
        local area = joker.area
        local original = joker.config.center
        local base_rarities = {'Common', 'Uncommon', 'Rare', 'Legendary'}
        local rarity = base_rarities[original.rarity] or original.rarity
        delay(0.5)
        draw_card(area, G.play, 1, 'up', false, joker, nil, true)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.35, func = function()
            local _center = G.P_CENTERS[original.key]
            if joker.remove_from_deck and type(joker.remove_from_deck) == 'function' then joker:remove_from_deck() end
            joker:check_chameleon()
            for i=1, 40 do
                local new_joker = pseudorandom_element(get_current_pool('Joker', rarity, rarity == 'Legendary'), pseudoseed('loteria_hand'))
                if G.P_CENTERS[new_joker] and new_joker ~= original.key then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                        _center = G.P_CENTERS[new_joker]
                        joker.children.center = Sprite(joker.T.x, joker.T.y, joker.T.w, joker.T.h, G.ASSET_ATLAS[_center.atlas or 'Joker'], _center.pos)
                        joker.children.center.states.hover = joker.states.hover
                        joker.children.center.states.click = joker.states.click
                        joker.children.center.states.drag = joker.states.drag
                        joker.children.center.states.collide.can = false
                        joker.children.center:set_role({major = joker, role_type = 'Glued', draw_major = joker})
                        if _center.soul_pos then 
                            joker.children.floating_sprite = Sprite(joker.T.x, joker.T.y, joker.T.w, joker.T.h, G.ASSET_ATLAS[_center[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or _center.atlas or _center.set], _center.soul_pos)
                            joker.children.floating_sprite.role.draw_major = joker
                            joker.children.floating_sprite.states.hover.can = false
                            joker.children.floating_sprite.states.click.can = false
                        end
                        if i == 1 then
                            for key, _ in pairs(joker.T) do
                                joker.T[key] = joker.original_T[key]
                            end
                        end
                        play_sound('generic1')
                        return true
                    end}))
                end
            end
            
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
                joker:set_ability(_center)
                joker:set_cost()
                joker:add_to_deck()
                joker:check_chameleon()
                joker:juice_up()
                play_sound('holo1')
                return true
            end}))
            draw_card(G.play, area, 1, 'up', false, joker, nil, true)
            return true
        end}))
    end
})

function Card:check_chameleon()
    if self.config.center_key == 'j_ortalab_chameleon' then
        self.children.front:remove()
        self.children.front = nil
        self.ignore_base_shader.chameleon = nil
        self.ignore_shadow.chameleon = nil
        self.config.center_key = 'old chameleon'
    end
end

SMODS.Consumable({
    key = 'lot_tree',
    set = 'ortalab_loteria',
    atlas = 'loteria_cards',
    pos = {x=1, y=0},
    discovered = false,
    config = {extra = {selected = 5, suits = {'Spades', 'Clubs'}}},
    artist_credits = {'parchment'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla), localize(card.ability.extra.suits[1], 'suits_plural'), localize(card.ability.extra.suits[2], 'suits_plural'),
        colours = {G.C.SUITS[card.ability.extra.suits[1]], G.C.SUITS[card.ability.extra.suits[2]]}}}
    end,
    can_use = function(self, card)
        return selected_use(self, card)
    end,
    keep_on_use = function(self, card)
        return loteria_joker_save_check(card)
    end,
    use = function(self, card, area, copier)
        track_usage(card.config.center.set, card.config.center_key)
        table.sort(G.hand.highlighted, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
        random_suits(G.hand.highlighted, card.ability.extra.suits)
        G.hand.config.highlighted_limit = card.ability.extra.highlight_limit or 5
    end
})

local ortalab_sell = Card.sell_card
function Card:sell_card()
    if self.config.center_key == 'c_ortalab_lot_tree' or self.config.center_key == 'c_ortalab_lot_heart' then
        G.hand.config.highlighted_limit = self.ability.extra.highlight_limit or 5
    end
    ortalab_sell(self)
end

function random_suits(cards, suits)
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            card:flip()
            play_sound('generic1', 0.7, 0.35)
            card:juice_up(0.3,0.3)
            return true
        end
        }))
    end
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
        func = function()
            assert(SMODS.change_base(card, pseudorandom_element(suits, pseudoseed('loteria_suit_shuffle')), nil))
            card:juice_up()
            return true
        end
        }))
    end
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            card:flip()
            play_sound('tarot2', 0.85, 0.6)
            card:juice_up(0.3,0.3)
            return true
        end
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7,
        func = function()
            G.hand:unhighlight_all()
            G.hand:parse_highlighted()                
            return true
        end
    }))
    delay(0.5)
end

function flip_suits(cards, suits)
    table.sort(cards, function (a, b) return a.T.x + a.T.w/2 < b.T.x + b.T.w/2 end)
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            card:flip()
            play_sound('generic1', 0.7, 0.35)
            card:juice_up(0.3,0.3)
            return true
        end
        }))
    end
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
        func = function()
            assert(SMODS.change_base(card, card.base.suit == suits[1] and suits[2] or suits[1], nil))
            card:juice_up()
            return true
        end
        }))
    end
    for _, card in ipairs(cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
            card:flip()
            play_sound('tarot2', 0.85, 0.6)
            card:juice_up(0.3,0.3)
            return true
        end
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7,
        func = function()
            G.hand:unhighlight_all()
            G.hand:parse_highlighted()                
            return true
        end
    }))
    delay(0.5)
end

function flip_use(self, card)
    if not selected_use(self, card) then return false end
    for _, _card in ipairs(G.hand.highlighted) do
        if not table.contains(card.ability.extra.suits, _card.base.suit) then
            return false
        end
    end
    return true
end

-- Functions

function standard_use()
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        return true
    end
end

function selected_use(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla) then
            return true
        end
    end
end

function can_enhance_cards(self, card)
    if G.STATE ~= G.STATES.HAND_PLAYED and G.STATE ~= G.STATES.DRAW_TO_HAND and G.STATE ~= G.STATES.PLAY_TAROT or any_state then
        for _, v in pairs(G.hand.cards) do
            if v.config.center_key ~= card.ability.extra.key then
                return true
            end
        end
    end
end

function use_enhance_cards(self, loteria, area, copier)
    G.hand:unhighlight_all()
    local valid_cards = 0
    for _,v in ipairs(G.hand.cards) do
        if v.config.center_key ~= loteria.ability.extra.key then valid_cards = valid_cards + 1 end
    end
    shuffle_cards()
    for i=1, math.min(loteria.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, valid_cards) do
        local set = true
        local anim_skip = 0
        while set do
            local card = pseudorandom_element(G.hand.cards, pseudoseed(loteria.ability.extra.key..'_select'))
            if not Ortalab.config.loteria_skip then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(true); play_sound('card3', math.random()*0.2 + 0.9, 0.35); return true; end}))
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(false); return true; end}))
            end
            if card.config.center_key ~= loteria.ability.extra.key and not card.changed then
                if pseudorandom(pseudoseed(loteria.ability.extra.key..'_set')) < ((1 + anim_skip) / (card.ability.set == 'Enhanced' and 8 or 3)) then
                    set_enhancement(card, loteria.ability.extra.key)
                    card.changed = true
                    set = false
                end
                anim_skip = anim_skip + 0.5
            end
        end
    end
    for _, card in pairs(G.hand.cards) do
        if card.changed then card.changed = false end
    end
    Ortalab.check_force_highlight()
end

function shuffle_cards()
    if Ortalab.config.loteria_skip then return end
    for i = math.random(5, 10), 1, -1 do
        local card = pseudorandom_element(G.hand.cards, pseudoseed('loteria_roll'))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(true); play_sound('card3', math.random()*0.2 + 0.9, 0.35); return true; end}))
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function() card:highlight(false); return true; end}))
    end
end

function set_enhancement(card, key)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() card:highlight(true); card:flip(); play_sound('generic1', 0.7, 0.35); card:juice_up(0.3,0.3); return true; end}))
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4,
        func = function()
            card:set_ability(G.P_CENTERS[key])
            card:juice_up()
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function() card:highlight(false); card:flip(); play_sound('tarot2', 0.85, 0.6); card:juice_up(0.3,0.3); return true; end}))
end

function create_consumables(card)
    for i = 1, math.min(card.ability.extra.amount + G.GAME.ortalab.vouchers.tabla, G.consumeables.config.card_limit - #G.consumeables.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = create_card(card.ability.extra.type, G.consumeables, nil, nil, nil, nil, nil, 'barrel')
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
    end
    delay(0.6)
end

function change_suit(card)
    local suits = {'Spades', 'Hearts', 'Diamonds', 'Clubs'}
    for i,v in ipairs(suits) do
        if v == card.ability.extra.suit then
            table.remove(suits, i)
        end
    end
    local chosen_suit = pseudorandom_element(suits, pseudoseed(card.config.center_key..'_suit'))
    for i=1, #G.hand.highlighted do
        local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    for _, selected in pairs(G.hand.highlighted) do
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            assert(SMODS.change_base(selected, chosen_suit, nil))
        return true; end}))
    end
    for i=1, #G.hand.highlighted do
        local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    delay(0.5)
end

function track_usage(type, key)
    if not G.GAME.Ortalab then G.GAME.Ortalab = {usage = {}} end
    if not G.GAME.Ortalab.usage[type] then G.GAME.Ortalab.usage[type] = {} end
    G.GAME.Ortalab.usage[type][key] = G.GAME.Ortalab.usage[type][key] and G.GAME.Ortalab.usage[type][key] + 1 or 1     
end

function get_rank_suffix(card)
    local rank_suffix = (card.base.id - 2) % 13 + 2
    if rank_suffix < 11 then rank_suffix = tostring(rank_suffix)
    elseif rank_suffix == 11 then rank_suffix = 'Jack'
    elseif rank_suffix == 12 then rank_suffix = 'Queen'
    elseif rank_suffix == 13 then rank_suffix = 'King'
    elseif rank_suffix == 14 then rank_suffix = 'Ace'
    end
    return rank_suffix
end

function harp_randomise(new_card, card_1_info, card_2_info)
    Ortalab.harp_usage = true
    local weighting = 0.2
    assert(SMODS.change_base(new_card, pseudorandom_element({card_1_info.suit, card_2_info.suit}, pseudoseed('harp_suit')), pseudorandom_element({card_1_info.rank, card_2_info.rank}, pseudoseed('harp_rank')), nil))
    local edition = pseudorandom('harp_edition') > (0.5 - (card_1_info.edition and weighting or 0) + (card_2_info.edition and weighting or 0)) and (card_1_info.edition or 'none') or (card_2_info.edition or 'none')
    if edition ~= 'none' then new_card:set_edition(edition, true, true) else new_card:set_edition(nil, nil, true) end
    local enhancement = pseudorandom('harp_enhancement') > (0.5 - (card_1_info.enhancement and weighting or 0) + (card_2_info.enhancement and weighting or 0)) and (card_1_info.enhancement or 'none') or (card_2_info.enhancement or 'none')
    if enhancement ~= 'none' then new_card:set_ability(enhancement) else new_card:set_ability(G.P_CENTERS.c_base) end
    local seal = pseudorandom('harp_seal') > (0.5 - (card_1_info.seal and weighting or 0) + (card_2_info.seal and weighting or 0)) and (card_1_info.seal or 'none') or (card_2_info.seal or 'none')
    if seal ~= 'none' then new_card:set_seal(seal, true, true) else new_card:set_seal() end
    local curse = pseudorandom('harp_curse') > 0.5 and (card_1_info.curse or 'none') or (card_2_info.curse or 'none')
    if curse ~= 'none' then new_card:set_curse(curse, true, true) else new_card:set_curse() end
    Ortalab.harp_usage = false
end

function bottle_randomise(card)
    local modifier = 8
    local edition = poll_edition('bottle_edition', modifier, false, false)
    -- local enhance = pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle_enhancement'))
    -- while enhance == 'UNAVAILABLE' do
    --     enhance = pseudorandom_element(get_current_pool('Enhanced'), pseudoseed('bottle_enhancement'))
    -- end
    local enhance = SMODS.poll_enhancement({key = 'bottle_enhance', guaranteed = true})
    local seal = SMODS.poll_seal({key = 'bottle_seal', mod = modifier})
    card:set_edition(edition, true, true)
    card:set_ability(G.P_CENTERS[enhance])
    card:set_seal(seal, true, true)
end

function loteria_joker_save_check(card)
    if card.ability.extra.kept then return false end
    local loteria_joker = SMODS.find_card('j_ortalab_televangelist')
    for _, joker_card in pairs(loteria_joker) do        
        if SMODS.pseudorandom_probability(joker_card, 'televangelist_keep', 1, joker_card.ability.extra.chance) then
            joker_card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ortalab_loteria_saved')})
            card.ability.extra.kept = true
            return true
        end
    end
    return false
end

local ortalab_highlight = Card.highlight
function Card:highlight(is_highlighted)
    ortalab_highlight(self, is_highlighted)
    if self.area ~= G.consumeables and self.area ~= G.pack_cards then return end
    if self.config.center_key == 'c_ortalab_lot_tree' or self.config.center_key == 'c_ortalab_lot_heart' or self.config.center_key == 'c_ortalab_lot_parrot' or self.config.center_key == 'c_ortalab_lot_boot' then
        if is_highlighted and G.hand.config.highlighted_limit < (self.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla)) then
            self.ability.extra.highlight_limit = G.hand.config.highlighted_limit
            G.hand.config.highlighted_limit = self.ability.extra.selected + (G.GAME and G.GAME.ortalab.vouchers.tabla)
        end
        if not is_highlighted and G.hand then
            G.hand.config.highlighted_limit = self.ability.extra.highlight_limit or 5
        end
    end
    if self.config.center_key == 'c_ortalab_lot_hand' and G.consumeables and self.area == G.consumeables then
        if is_highlighted then
            G.consumeables.config.highlighted_limit = G.consumeables.config.highlighted_limit + 1
        else
            G.consumeables.config.highlighted_limit = G.consumeables.config.highlighted_limit - 1
        end
    end
end