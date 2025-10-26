femtoLabsCollection.twilight_cards = SMODS.ConsumableType({
    key = "m_femtoLabsCollection_twilight",
    primary_colour = HEX('715D91'),
    secondary_colour = HEX('AA9186'),
    default = "c_femtoLabsCollection_aurora",
    loc_txt = {
        name = 'Twilight',
        collection = 'Twilight Cards', 
        undiscovered = {
            name = 'Undiscovered',
            text = { ':3' },
        },
    },
    collection_rows = { 4, 5 },
    shop_rate = 0
})

SMODS.Gradient({
    key = "twilight",
    colours = {
        femtoLabsCollection.twilight_cards.secondary_colour,
        femtoLabsCollection.twilight_cards.secondary_colour,
    },
})

-------------------

local card_initRef = Card.init
Card.init = function(self, X, Y, W, H, card, center, params)
    card_initRef(self, X, Y, W, H, card, center, params)
    if self.ability.set == 'Booster' then

        --[[local extra_choices = 0
        local goobers = SMODS.find_card('j_femtoLabsCollection_gooseberry')
        for i=1, #goobers do
            extra_choices = goobers[i].ability.extra.choices
        end   
        if G.GAME.starting_params.flc_gradientdeck then
            self.ability.extra = self.ability.extra + 1
        end
		self.ability.choose = math.min(self.ability.choose + extra_choices, self.ability.extra)]]
    elseif self.ability.set == 'm_femtoLabsCollection_twilight' and ((G.GAME['m_femtolabscollection_twilight_negatives'] and pseudorandom('flc_twilight_negative') < 1/5) or next(SMODS.find_card('j_femtoLabsCollection_sol'))) then
        self:set_edition({negative = true}, true)
    end
end

local openRef = Card.open
Card.open = function(self)
    local scrags = SMODS.find_card('j_femtoLabsCollection_scraggly')
    for _, v in pairs(scrags) do
        self.ability.extra = math.ceil(pseudorandom('flc_scraggly_booster') * 10);
        self.ability.choose = math.min(math.ceil(pseudorandom('flc_scraggly_booster') * 10), self.ability.extra)
        card_eval_status_text(v, 'extra', nil, nil, nil, {message = 'Hello!', colour = G.C.FILTER, instant = true})
    end
    openRef(self)
end

function ease_bg_nightfall()
    ease_colour(G.C.DYN_UI.MAIN, HEX('BC6F6F'))
    ease_background_colour{new_colour = HEX('895F52'), special_colour = darken(G.C.BLACK, 0.6), tertiary_colour = HEX('513B4C'), contrast = 2}
end

function particles_nightfall()
    G.booster_pack_stars = Particles(1, 1, 0,0, {
        timer = 0.04,
        scale = 0.2,
        initialize = true,
        lifespan = 4,
        speed = 0.7,
        padding = -4,
        attach = G.ROOM_ATTACH,
        colours = {HEX('D8C5C5'), HEX('CE9A6D'), HEX('8F72C1')},
        fill = true
    })
    G.booster_pack_meteors = Particles(1, 1, 0,0, {
        timer = 1,
        scale = 0.05,
        lifespan = 3,
        speed = 3,
        attach = G.ROOM_ATTACH,
        colours = {G.C.WHITE},
        fill = true
    })
end

-- nightfall pack 1

local std1 = SMODS.Booster({
    key = 'twilight_normal_1',
    loc_txt = {
        name = "Nightfall Pack",
        group_name = "Nightfall Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:femtolabscollection_twilight} Twilight{} cards to be",
            "added to your {C:attention}consumables",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = 2, choose = 1 },
    atlas = "p_flc_twilight",
    pos = { x = 0, y = 0 },
    discovered = true,
    cost = 4,
    weight = 0.5,
    draw_hand = false,
    kind = "p_flc_twilight",
    select_card = "consumeables",
    select_exclusions = {'c_femtoLabsCollection_samsara'}
})

std1.loc_vars = function(self, loc_vars, card)
    return {
        vars = {
            card.ability.choose,
            card.ability.extra,
        }
    }
end

std1.create_card = function(self, card, i)
    return {set = "m_femtoLabsCollection_twilight", area = G.pack_cards, key_append = "m_flc_booster_"..i, soulable = true, no_edition = true, skip_materialize = true}
end

std1.ease_background_colour = function(self)
    ease_bg_nightfall()
end

std1.particles = function(self)
    particles_nightfall()
end

-- nightfall pack 2

local std2 = SMODS.Booster({
    key = 'twilight_normal_2',
    loc_txt = {
        name = "Nightfall Pack",
        group_name = "Nightfall Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:femtolabscollection_twilight} Twilight{} cards to be",
            "added to your {C:attention}consumables",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = 2, choose = 1 },
    atlas = "p_flc_twilight",
    pos = { x = 1, y = 0 },
    discovered = true,
    cost = 4,
    weight = 0.5,
    draw_hand = false,
    kind = "p_flc_twilight",
    select_card = "consumeables",
    select_exclusions = {'c_femtoLabsCollection_samsara'}
})

std2.loc_vars = function(self, loc_vars, card)
    return {
        vars = {
            card.ability.choose,
            card.ability.extra,
        }
    }
end

std2.create_card = function(self, card, i)
    return {set = "m_femtoLabsCollection_twilight", area = G.pack_cards, key_append = "m_flc_booster_"..i, soulable = true, no_edition = true, skip_materialize = true}
end

std2.ease_background_colour = function(self)
    ease_bg_nightfall()
end

std2.particles = function(self)
    particles_nightfall()
end

-- jumbo nightfall pack

local jumbo = SMODS.Booster({
    key = 'twilight_jumbo',
    loc_txt = {
        name = "Jumbo Nightfall Pack",
        group_name = "Nightfall Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:femtolabscollection_twilight} Twilight{} cards to be",
            "added to your {C:attention}consumables",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = 4, choose = 1 },
    atlas = "p_flc_twilight",
    pos = { x = 2, y = 0 },
    discovered = true,
    cost = 6,
    weight = 0.5,
    draw_hand = false,
    kind = "p_flc_twilight",
    select_card = "consumeables",
    select_exclusions = {'c_femtoLabsCollection_samsara'}
})

jumbo.loc_vars = function(self, loc_vars, card)
    return {
        vars = {
            card.ability.choose,
            card.ability.extra,
        }
    }
end

jumbo.create_card = function(self, card, i)
    return {set = "m_femtoLabsCollection_twilight", area = G.pack_cards, key_append = "m_flc_booster_"..i, soulable = true, no_edition = true, skip_materialize = true}
end

jumbo.ease_background_colour = function(self)
    ease_bg_nightfall()
end

jumbo.particles = function(self)
    particles_nightfall()
end

-- mega nightfall pack

local mega = SMODS.Booster({
    key = 'twilight_mega',
    loc_txt = {
        name = "Mega Nightfall Pack",
        group_name = "Nightfall Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2#{C:femtolabscollection_twilight} Twilight{} cards to be",
            "added to your {C:attention}consumables",
            "{C:inactive}(Must have room)",
        }
    },
    config = { extra = 4, choose = 2 },
    atlas = "p_flc_twilight",
    pos = { x = 3, y = 0 },
    discovered = true,
    cost = 8,
    weight = 0.5,
    draw_hand = false,
    kind = "p_flc_twilight",
    select_card = "consumeables",
    select_exclusions = {'c_femtoLabsCollection_samsara'}
})

mega.loc_vars = function(self, loc_vars, card)
    return {
        vars = {
            card.ability.choose,
            card.ability.extra,
        }
    }
end

mega.create_card = function(self, card, i)
    return {set = "m_femtoLabsCollection_twilight", area = G.pack_cards, key_append = "m_flc_booster_"..i, soulable = true, no_edition = true, skip_materialize = true}
end

mega.ease_background_colour = function(self)
    ease_bg_nightfall()
end

mega.particles = function(self)
    particles_nightfall()
end

local buysell = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
    local old_sel = booster_obj and booster_obj.select_card
    if card.ability.set == "m_femtoLabsCollection_twilight" then
        if booster_obj then booster_obj.select_card = 'consumeables' end
    end
    local ret = buysell(card)
    if booster_obj then booster_obj.select_card = old_sel end
    return ret
end

local selectableRef = Card.selectable_from_pack

function Card.selectable_from_pack(card, pack)
    if card.ability.set == "m_femtoLabsCollection_twilight" then return 'consumeables' else return selectableRef(card, pack) end
end

local useRef = G.FUNCS.use_card
G.FUNCS.use_card = function(e, mute, nosave)
    local old_sel = booster_obj and booster_obj.select_card
    if e.config.ref_table.ability.set == "m_femtoLabsCollection_twilight" then
        if booster_obj then booster_obj.select_card = 'consumeables' end
    end
    useRef(e, mute, nosave)
    if booster_obj then booster_obj.select_card = old_sel end
end

femtoLabsCollection.TwilightCard = SMODS.Consumable:extend {
    set = "m_femtoLabsCollection_twilight",
	atlas = "femtoLabsCollection_c_flc_twilight",
    unlocked = true,
	discovered = true,
}

-- horizon

local horizon = femtoLabsCollection.TwilightCard({
    key = "horizon",
    config = {extra = 2},
	pos = {x = 0, y = 0},
	loc_txt = {
        name = 'Horizon',
        text = {
            "Creates the last",
            "{C:femtolabscollection_twilight}Twilight{} or {C:spectral}Spectral{} card",
            "used during this run",
            "{s:0.8,C:femtolabscollection_twilight}Horizon{s:0.8} excluded",
        }
    },
	cost = 6,
})

horizon.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

horizon.can_use = function(self, card)
    return (G.GAME.flc_last_twilight_spectral ~= nil and G.GAME.flc_last_twilight_spectral ~= 'c_femtoLabsCollection_horizon' and G.P_CENTERS[G.GAME.flc_last_twilight_spectral] and not G.P_CENTERS[G.GAME.flc_last_twilight_spectral].hidden)
end

horizon.use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('timpani')
        local new_card = SMODS.create_card{key = G.GAME.flc_last_twilight_spectral, key_append = 'flc_horizon'}
        new_card:add_to_deck()
        G.consumeables:emplace(new_card)
        card:juice_up(0.3, 0.5)
        return true
    end}))
    delay(0.6)
end

horizon.generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    femtoLabsCollection.TwilightCard.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)

    local twi_spe = G.GAME.flc_last_twilight_spectral and G.P_CENTERS[G.GAME.flc_last_twilight_spectral] or nil
    local last_twi_spe = twi_spe and localize{type = 'name_text', key = twi_spe.key, set = twi_spe.set} or localize('k_none')
    if G.GAME.flc_last_twilight_spectral == 'c_femtoLabsCollection_horizon' or (twi_spe and twi_spe.hidden) then twi_spe = nil end
    local colour = not twi_spe and G.C.RED or (twi_spe.set == 'Spectral' and G.C.SECONDARY_SET.Spectral or femtoLabsCollection.twilight_cards.secondary_colour)

    table.insert(desc_nodes, {
        {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
            {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                {n=G.UIT.T, config={text = ' '..last_twi_spe..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
            }}
        }}
    })

    if twi_spe then
        table.insert(info_queue, twi_spe)
    end
end

horizon.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- fleeting

local fleeting = femtoLabsCollection.TwilightCard({
    key = "fleeting",
    config = {mod_conv = 'm_femtoLabsCollection_ice_card', max_highlighted = 2},
	pos = {x = 1, y = 0},
	loc_txt = {
        name = 'Fleeting',
        text = {
            "Enhances up to {C:attention}#1#",
            "selected cards to",
            "{C:attention}#2#s"
        }
    },
	cost = 6,
})

fleeting.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

fleeting.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_femtoLabsCollection_ice_card
    return {
        vars = {
            card.ability.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = 'm_femtoLabsCollection_ice_card'}
        }
    }
end

fleeting.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- moment

local moment = femtoLabsCollection.TwilightCard({
    key = "moment",
    config = {extra = {prob_success = 4}},
	pos = {x = 2, y = 0},
	loc_txt = {
        name = 'Moment',
        text = {
    "Creates a",
    "{C:attention}Summon Tag"
        }
    },
	cost = 6,
})

moment.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'tag_femtoLabsCollection_summon', set = 'Tag'}
end

moment.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

moment.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

moment.can_use = function(self, card)
    return true
end

moment.use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            add_tag(Tag('tag_femtoLabsCollection_summon'))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
    }))
end

-- sampo

local sampo = femtoLabsCollection.TwilightCard({
    key = "sampo",
    config = {extra = {destroy = 1, gold = 4}},
	pos = {x = 3, y = 0},
	loc_txt = {
        name = 'Sampo',
        text = {
    "Destroys {C:attention}#1#{} random card",
    "in hand, enhance {C:attention}#2#{} random",
    "cards in hand to {C:attention}Gold Cards{}"
        }
    },
	cost = 6,
})

sampo.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

sampo.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

sampo.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_gold
    return {
        vars = {
            card.ability.extra.destroy,
            card.ability.extra.gold
        }
    }
end

sampo.can_use = function(self, card)
    if (G.STATE == G.STATES.SELECTING_HAND or G.STATES.SMODS_BOOSTER_OPENED) and #G.hand.cards > 0 then
        return true
    end
    return false
end

sampo.use = function(self, card, area, copier)
    local temp_hand = {}
    for i=1, #G.hand.cards do
        table.insert(temp_hand, G.hand.cards[i])
    end

    pseudoshuffle(temp_hand, pseudoseed('flc_sampo'))

    local destroyed_cards = {}

    for i=1, math.min(card.ability.extra.destroy, #temp_hand) do
        destroyed_cards[#destroyed_cards+1] = temp_hand[i]

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function() 
                for i=#destroyed_cards, 1, -1 do
                    local _card = destroyed_cards[i]
                    if _card.ability.name == 'Glass Card' then 
                        _card:shatter()
                    else
                        _card:start_dissolve(nil, i ~= #destroyed_cards)
                    end
                end
                return true 
            end }))
    end
    delay(0.2)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true end }))
    for i=card.ability.extra.destroy+1, math.min(#temp_hand, card.ability.extra.destroy + card.ability.extra.gold) do
        local percent = 1.15 - ((i - card.ability.extra.destroy)-0.999)/(math.min(#temp_hand, card.ability.extra.gold)-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() temp_hand[i]:flip();play_sound('card1', percent);temp_hand[i]:juice_up(0.3, 0.3);return true end }))
    end
    delay(0.2)
    for i=card.ability.extra.destroy+1, math.min(#temp_hand, card.ability.extra.destroy + card.ability.extra.gold) do
        temp_hand[i]:set_ability(G.P_CENTERS.m_gold, nil, true)
        local percent = 0.85 + ((i - card.ability.extra.destroy)-0.999)/(math.min(#temp_hand, card.ability.extra.gold)-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() temp_hand[i]:flip();play_sound('tarot2', percent, 0.6);temp_hand[i]:juice_up(0.3, 0.3);return true end }))
    end
    delay(0.3)
    for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
    end
end

-- theseus

local theseus = femtoLabsCollection.TwilightCard({
    key = "theseus",
    config = {extra = {mult = 3, chips = 15}},
	pos = {x = 4, y = 0},
	loc_txt = {
        name = 'Theseus',
        text = {
    "Removes the {C:attention}Enhancement of",
    "a selected card, permanently",
    "give it {C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips"
        }
    },
	cost = 6,
})

theseus.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

theseus.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra.mult,
            card.ability.extra.chips,
        }
    }
end

theseus.can_use = function(self, card)
    return #G.hand.highlighted == 1 and G.hand.highlighted[1].ability.set == "Enhanced"
end

theseus.use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true end }))
    for i=1, #G.hand.highlighted do
        local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    delay(0.2)
    for i=1, #G.hand.highlighted do
        G.hand.highlighted[i]:set_ability(G.P_CENTERS.c_base, nil, true)
        G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus or 0
        G.hand.highlighted[i].ability.perma_bonus = G.hand.highlighted[i].ability.perma_bonus + card.ability.extra.chips
        G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult or 0
        G.hand.highlighted[i].ability.perma_mult = G.hand.highlighted[i].ability.perma_mult + card.ability.extra.mult
        local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    delay(0.5)
end


theseus.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- light

local light = femtoLabsCollection.TwilightCard({
    key = "light",
    config = {},
	pos = {x = 5, y = 0},
	loc_txt = {
        name = 'Light',
        text = {
    "{C:attention}Doubles{} the {C:money}sell value",
    "of a selected {C:joker}Joker",
    "{C:inactive}(Max of {C:money}$30{C:inactive})"
        }
    },
	cost = 6,
})

light.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

light.can_use = function(self, card)
    return G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0
end

light.use = function(self, card, area, copier)
    delay(0.3)
    card:juice_up(0.3, 0.5)
    play_sound('tarot1')
    delay(0.1)
    local inc = 0
    if G.jokers.highlighted[1].set_cost then 
        inc = math.min(G.jokers.highlighted[1].sell_cost, 30)
        G.jokers.highlighted[1].ability.extra_value = (G.jokers.highlighted[1].ability.extra_value or 0) + inc
        G.jokers.highlighted[1]:set_cost()
    end
    card_eval_status_text(G.jokers.highlighted[1], 'dollars', inc)
    delay(0.5)
    G.jokers:unhighlight_all()
end

light.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- penumbra

local penumbra = femtoLabsCollection.TwilightCard({
    key = "penumbra",
    config = {},
	pos = {x = 6, y = 0},
	loc_txt = {
        name = 'Penumbra',
        text = {
    "Turns {C:attention}a selected",
    "card in your hand",
    "into a {C:dark_edition}Negative{} card",
        }
    },
	cost = 6,
})

penumbra.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "e_negative_playing_card", set = "Edition", config = {extra = G.P_CENTERS['e_negative'].config.card_limit}}
    return {
        vars = {
        }
    }
end

penumbra.can_use = function(self, card)
    return #G.hand.highlighted == 1 and not (G.hand.highlighted[1].edition and G.hand.highlighted[1].edition.negative) and not G.hand.highlighted[1].debuff
end

penumbra.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

penumbra.use = function(self, card, area, copier)
    delay(0.2)
    for i=1, #G.hand.highlighted do
        if not (G.hand.highlighted[i].edition and G.hand.highlighted[i].edition.negative) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function() 
                    play_sound('negative', 1.5, 0.6)
                    card:juice_up()
                    G.hand.highlighted[i]:juice_up(1, 0.5)
                    G.hand.highlighted[i]:set_edition({negative = true}, nil, true)
                return true end }))
        end
    end 
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    delay(0.5)
end

penumbra.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- egress

local egress = femtoLabsCollection.TwilightCard({
    key = "egress",
    config = {extra = 'femtoLabsCollection_bronze_seal', max_highlighted = 1},
	pos = {x = 7, y = 0},
	loc_txt = {
        name = 'Egress',
        text = {
    "Add a {C:femtolabscollection_twilight}Bronze Seal{}",
    "to {C:attention}#1#{} selected",
    "card in your hand"
        }
    },
	cost = 6,
})

egress.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS['femtoLabsCollection_bronze_seal']
    return {
        vars = {
            card.ability.max_highlighted,
        }
    }
end

egress.use = function(self, card)
    local conv_card = G.hand.highlighted[1]
    G.E_MANAGER:add_event(Event({func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true end }))
    
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        conv_card:set_seal(card.ability.extra, nil, true)
        return true end }))
    
    delay(0.5)
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
end

egress.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

egress.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- decay

local decay = femtoLabsCollection.TwilightCard({
    key = "decay",
    config = {extra = 25},
	pos = {x = 8, y = 0},
	loc_txt = {
        name = 'Decay',
        text = {
    "Removes {C:dark_edition}Edition{} from",
    "a random {C:joker}Joker,",
    "gain {C:money}$#1#",
    "{C:inactive,s:0.8}(Cannot remove {C:dark_edition,s:0.8}Negative{}{C:inactive,s:0.8})"
        }
    },
	cost = 6,
})

decay.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra
        }
    }
end

decay.can_use = function(self, card)
    if G.jokers and G.jokers.cards and #G.jokers.cards > 0 then
        local edtable = {}
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i].edition and not G.jokers.cards[i].edition.negative then
                table.insert(edtable, G.jokers.cards[i])
            end
        end
        if #edtable > 0 then return true end
    end
end

decay.use = function(self, card, area, copier)

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        local edtable = {}
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i].edition and not G.jokers.cards[i].edition.negative then
                table.insert(edtable, G.jokers.cards[i])
            end
        end
        local _card = pseudorandom_element(edtable, pseudoseed('flc_decay_colon_3'))
        _card:set_edition(nil, nil, false)
        _card:juice_up()
        return true end }))
    delay(0.5)
    ease_dollars(card.ability.extra)
end

decay.in_pool = function(self, args)
    return self:can_use(nil), {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

decay.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- fulfillment

local fulfillment = femtoLabsCollection.TwilightCard({
    key = "fulfillment",
    config = {},
	pos = {x = 9, y = 0},
	loc_txt = {
        name = 'Fulfillment',
        text = {
            "Progress a Joker's {C:dark_edition}Edition",
            "{C:inactive}(Using Collection order)"
        }
    },
	cost = 6,
})

fulfillment.loc_vars = function(self, info_queue, card)
end

fulfillment.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

fulfillment.can_use = function(self, card)

    local joker = G.jokers and G.jokers.highlighted[1] or nil
    if not joker or #G.jokers.highlighted ~= 1 then return false end

    local edition_id = 1;

    for i, ed in ipairs(G.P_CENTER_POOLS.Edition) do
        if not joker.edition then break end
        if joker.edition.key == ed.key then
            edition_id = i
            break
        end
    end

    return edition_id ~= #G.P_CENTER_POOLS.Edition
end

fulfillment.use = function(self, card, area, copier)

    local joker = G.jokers.highlighted[1]
    if not joker then return end

    local edition_id = 1;

    for i, ed in ipairs(G.P_CENTER_POOLS.Edition) do
        if not joker.edition then break end
        if joker.edition.key == ed.key then
            edition_id = i
            break
        end
    end

    if G.P_CENTER_POOLS.Edition[edition_id + 1].key == 'e_ccc_mirrored' then edition_id = edition_id + 1 end -- skip mirrored

    G.E_MANAGER:add_event(Event({
        func = (function()
            play_sound('tarot1')
            joker:juice_up();
            joker:set_edition(G.P_CENTER_POOLS.Edition[edition_id + 1].key)
            return true
        end)
    }))

    delay(0.4)
end

fulfillment.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- nostalgia

local nostalgia = femtoLabsCollection.TwilightCard({
    key = "nostalgia",
    config = {mod_conv = 'm_femtoLabsCollection_ivory_card', max_highlighted = 2},
	pos = {x = 0, y = 1},
	loc_txt = {
        name = 'Nostalgia',
        text = {
    "Enhances up to {C:attention}#1#",
    "selected cards to",
    "{C:attention}#2#s"
        }
    },
	cost = 6,
})

nostalgia.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

nostalgia.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.m_femtoLabsCollection_ivory_card
    return {
        vars = {
            card.ability.max_highlighted,
            localize{type = 'name_text', set = 'Enhanced', key = 'm_femtoLabsCollection_ivory_card'}
        }
    }
end

nostalgia.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

-- presence

local presence = femtoLabsCollection.TwilightCard({
    key = "presence",
    config = {},
	pos = {x = 2, y = 1},
	loc_txt = {
        name = 'Presence',
        text = {
    "Creates a random",
    "{C:dark_edition}Edition{} tag"
        }
    },
	cost = 6,
})

presence.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'tag_foil', set = 'Tag'}
    info_queue[#info_queue+1] = {key = 'tag_holo', set = 'Tag'}
    info_queue[#info_queue+1] = {key = 'tag_polychrome', set = 'Tag'}
    info_queue[#info_queue+1] = {key = 'tag_negative', set = 'Tag'}
end

presence.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

presence.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

presence.use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
        func = (function()
            local key = pseudorandom_element({'foil', 'holo', 'polychrome', 'negative'}, pseudoseed('flc_twilight_presence'))
            add_tag(Tag('tag_'..key))
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
    }))
end

presence.can_use = function(self, card)
    return true
end

-- life

local life = femtoLabsCollection.TwilightCard({
    key = "life",
    config = {},
	pos = {x = 3, y = 1},
	loc_txt = {
        name = 'Life',
        text = {
    "Creates a random",
    "{C:dark_edition}Negative{} {C:blue}Common{C:attention} Joker"
        }
    },
	cost = 6,
})

life.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
end

life.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

life.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

life.use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
        local card = SMODS.create_card({
            set = 'Joker',
            rarity = 0.1,
            skip_materialize = true,
            key_append = 'flc_life',
            edition = {negative = true}
        })
        card:start_materialize()
        card:add_to_deck()
        G.jokers:emplace(card)
        return true end }))
end

life.can_use = function(self, card)
    return true
end

-- view

local view = femtoLabsCollection.TwilightCard({
    key = "view",
    config = {},
	pos = {x = 7, y = 1},
	loc_txt = {
        name = 'View',
        text = {
    "Fills all {C:attention}empty{} consumable",
    "slots with {C:dark_edition}Foil{}, {C:dark_edition}Holographic",
    "or {C:dark_edition}Polychrome {C:planet}Planet Cards{}",
        }
    },
	cost = 6,
})

view.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_foil; 
    info_queue[#info_queue+1] = G.P_CENTERS.e_holo; 
    info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome; 
end

view.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

view.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

view.use = function(self, card, area, copier)
    for i = 1, G.consumeables.config.card_limit - #G.consumeables.cards do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = SMODS.create_card({set = 'Planet', key_append = 'flc_view'})
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
                card:set_edition(poll_edition('flc_view_edition', nil, true, true))
            end
            return true end }))
    end
    delay(0.6)
end

view.can_use = function(self, card)
    return true
end

-- forever

local forever = femtoLabsCollection.TwilightCard({
    key = "forever",
    config = {},
	pos = {x = 4, y = 1},
	loc_txt = {
        name = 'Forever',
        text = {
    "Makes a selected",
    "{C:Joker}Joker {V:1}Eternal"
        }
    },
	cost = 6,
})

forever.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'eternal', set = 'Other'}
    return {
        vars = {
            colours = {
                G.C.ETERNAL
            }
        }
    }
end

forever.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

forever.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

forever.can_use = function(self, card)
    return G.jokers and G.jokers.highlighted and #G.jokers.highlighted > 0 and G.jokers.highlighted[1].config.center.eternal_compat and not G.jokers.highlighted[1].ability.perishable and not G.jokers.highlighted[1].ability.eternal
end

forever.use = function(self, card, area, copier)
    delay(0.3)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.0,func = function() 
            card:juice_up(0.3, 0.5)
            play_sound('tarot1')
            G.jokers.highlighted[1]:juice_up()
            play_sound('gold_seal', 1.2, 0.4)
            G.jokers.highlighted[1]:set_eternal(true)
            return true 
        end }))
    delay(0.5)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.0,func = function() 
            G.jokers:unhighlight_all()
            return true 
        end }))
end

-- aurora

local aurora = femtoLabsCollection.TwilightCard({
    key = "aurora",
    config = {extra = 2},
	pos = {x = 5, y = 1},
	loc_txt = {
        name = 'Aurora',
        text = {
            "Creates up to {C:attention}#1#",
            "consumables from",
            "{C:attention}random sets",
            "{C:inactive}(Must have room)",
        }
    },
	cost = 6,
})

aurora.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra
        }
    }
end

aurora.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

aurora.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

aurora.use = function(self, card, area, copier)
    for i = 1, math.min(card.ability.extra, G.consumeables.config.card_limit - #G.consumeables.cards) do
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            if G.consumeables.config.card_limit > #G.consumeables.cards then
                play_sound('timpani')
                local card = SMODS.create_card({set = pseudorandom_element(SMODS.ConsumableTypes, pseudoseed('flc_aurora_set')).key, key_append = 'flc_aurora'})
                card:add_to_deck()
                G.consumeables:emplace(card)
                card:juice_up(0.3, 0.5)
            end
            return true end }))
    end
    delay(0.6)
end

aurora.can_use = function(self, card)
    return true
end

-- reflection

local reflection = femtoLabsCollection.TwilightCard({
    key = "reflection",
    config = {},
	pos = {x = 6, y = 1},
	loc_txt = {
        name = 'Reflection',
        text = {
    "Creates a {V:1}Perishable{} copy",
    "of a random {C:joker}Joker",
    "{C:inactive}(Must have room)"
        }
    },
	cost = 6,
})

reflection.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'perishable', set = 'Other', vars = {G.GAME.perishable_rounds or 1, G.GAME.perishable_rounds}}
    return {
        vars = {
            colours = {
                G.C.PERISHABLE
            }
        }
    }
end

reflection.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

reflection.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

reflection.use = function(self, card, area, copier)
    local chosen_joker = pseudorandom_element(G.jokers.cards, pseudoseed('flc_reflection_choice'))
    G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
        local card = copy_card(chosen_joker, nil, nil, nil, chosen_joker.edition and chosen_joker.edition.negative)
        card:start_materialize()
        card:set_eternal(false)
        card:set_perishable(true)
        card:add_to_deck()
        if card.edition and card.edition.negative then
            card:set_edition(nil, true)
        end
        G.jokers:emplace(card)
        return true end }))
end

reflection.can_use = function(self, card)
    for k, v in pairs(G.jokers.cards) do
        if v.ability.set == 'Joker' and G.jokers.config.card_limit > 1 then 
            return true
        end
    end
end

check_useRef = Card.check_use
Card.check_use = function(self)
    ret = check_useRef(self)
    if self.config.center_key == 'c_femtoLabsCollection_reflection' then 
        if #G.jokers.cards >= G.jokers.config.card_limit and self.area ~= G.pack_cards then
            alert_no_space(self, G.jokers)
            return true
        end
    end
    return ret
end

-- treasure

local treasure = femtoLabsCollection.TwilightCard({
    key = "treasure",
    config = {extra = 10},
	pos = {x = 8, y = 1},
	loc_txt = {
        name = 'Treasure',
        text = {
    "Makes all {C:joker}Jokers{} {V:1}Rental,",
    "gain {C:money}$#1#{} per",
    "{C:joker}Joker{} made {V:1}Rental"
        }
    },
	cost = 6,
})

treasure.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = 'rental', set = 'Other', vars = {G.GAME.rental_rate or 1}}
    return {
        vars = {
            card.ability.extra,
            colours = {
                G.C.RENTAL
            }
        }
    }
end

treasure.in_pool = function(self, args)
    return true, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

treasure.draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') then
        card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
end

treasure.use = function(self, card, area, copier)
    local table2 = {}

    delay(0.3)

    for i=1, #G.jokers.cards do
        if not G.jokers.cards[i].ability.rental then table2[#table2+1] = G.jokers.cards[i] end
    end

    for i=1, #table2 do
        local percent = 0.85 + (i-0.999)/(#table2-0.998)*0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function() 
                table2[i]:juice_up(); 
                play_sound('tarot2', percent, 0.6);
                table2[i]:set_rental(true)
                return true 
            end }))
    end 
    delay(0.3)
    if #table2 > 0 then ease_dollars(card.ability.extra * #table2) end
    delay(0.5)
end

treasure.can_use = function(self, card)
    if G.jokers then
        for i=1, #G.jokers.cards do
            if not G.jokers.cards[i].ability.rental then return true end
        end
    else return false end
end

-- samsara

local samsara = SMODS.Consumable({
    key = "samsara",
    set = "Spectral",
    config = {},
	pos = {x = 1, y = 1},
	loc_txt = {
        name = 'Samsara',
        text = {
    "Creates a {C:dark_edition}Negative{} copy of",
    "{C:legendary,E:1}every{} {C:attention}Joker{} and {C:attention}Consumable",
    "card sold this run"
        }
    },
	cost = 6,
    unlocked = true,
	discovered = false,
    hidden = true,
    soul_set = 'twilight',
	atlas = "c_flc_twilight",
    can_repeat_soul = false
})

samsara.loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    info_queue[#info_queue+1] = {key = 'e_negative_consumable', set = 'Edition', config = {extra = 1}}
end

samsara.can_use = function(self, card)
    return G.flc_soldarea and G.flc_soldarea.cards and #G.flc_soldarea.cards > 0
end

samsara.in_pool = function(self, args)
    return G.flc_soldarea and G.flc_soldarea.cards and #G.flc_soldarea.cards > 0, {allow_duplicates = next(SMODS.find_card('j_femtoLabsCollection_sol'))}
end

samsara.use = function(self, card, area, copier)

    if not G.flc_soldarea then return end

    local i = 1;

    local sold_count = #G.flc_soldarea.cards

    for _, new in pairs(G.flc_soldarea.cards) do
        local i2 = i
        G.E_MANAGER:add_event(Event({trigger = 'before', delay = 0.4, func = function()
            local percent = 0.85 + (i2-0.999)/(sold_count-0.998)*0.3
            play_sound('tarot2', percent, 0.6);
            G.flc_soldarea:remove_card(new)
            new.VT.x = card.VT.x
            new.VT.y = card.VT.y
            card:juice_up(0.3, 0.1)
            new:set_edition({negative = true}, nil, false)
            new:start_materialize()
            new:add_to_deck()
            if new.ability.set == 'Joker' then
                G.jokers:emplace(new)
            else 
                G.consumeables:emplace(new)
            end
            return true end }))
        i = i + 1
    end
    delay(0.5)
end

local sellRef = Card.sell_card

Card.sell_card = function(self)
    sellRef(self)

    local card = copy_card(self, nil, nil, nil, false)

    G.flc_soldarea:emplace(card)
end

if next(SMODS.find_mod('RiftRaft')) then
    RIFTRAFT.RiftCard{
        key = "cadence",
        loc_txt = {
            name = "Cadence",
            text = {
                "Add {C:attention}#1#{} random {C:femtolabscollection_twilight}Twilight{}",
                "{C:femtolabscollection_twilight}Cards{} to the {C:riftraft_void}Void{}",
            }
        },
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.amount,
                }
            }
        end,
        config = {
            extra = {amount = 3},
        },
        atlas = "c_flc_twilight",
        pos = {x = 9, y = 1},
        cost = 1,
        can_use = function(self, card)
            return true
        end,
        use = function(self, card, area)
            local added = {}
            for i=1, card.ability.extra.amount do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    play_sound('timpani')
                    -- local new_card = create_card('Code', G.riftraft_rifthand, nil, nil, nil, nil, nil, 'null')
                    local new_card = SMODS.create_card{set = 'm_femtoLabsCollection_twilight', area = G.riftraft_rifthand, key_append = 'null', discover = true}
                    new_card:set_edition({negative = true}, true, true)
                    G.riftraft_rifthand:emplace(new_card)
                    card:juice_up(0.3, 0.5)
                    table.insert(added, new_card)
                    return true
                end}))
            end
            G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
                SMODS.calculate_context({add_to_void = true, added = added})
                return true
            end}))
            if not RIFTRAFT.in_void_pack() then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
                    RIFTRAFT.draw_from_rift_to_void()
                    return true
                end}))
            end
        end,
    }
end

