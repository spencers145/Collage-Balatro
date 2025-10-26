SMODS.Atlas({
    key = "ortalab_enhanced",
    path = "Enhancements.png",
    px = 71,
    py = 95
})

SMODS.Enhancement({
    key = "post",
    atlas = "ortalab_enhanced",
    pos = {x = 0, y = 0},
    discovered = false,
    config = {extra = {hand_chips = 10}},
    artist_credits = {'notmario'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card and card.ability.extra.hand_chips or self.config.extra.hand_chips }
        }
    end,
    calculate = function(self, card, context)
        if context.heron_check then
            return { chips = (#G.hand.cards - #G.hand.highlighted) * card.ability.extra.hand_chips }
        end
        if context.cardarea == G.play and context.main_scoring then
            local chip_return = 0
            for i, held_card in pairs(G.hand.cards) do
                if not Ortalab.config.enhancement_skip then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            held_card:juice_up()
                            play_sound('chips1', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                            card:juice_up(0.6, 0.1)
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                            return true
                        end
                    }))
                end
                chip_return = chip_return + card.ability.extra.hand_chips
                if i ~= # G.hand.cards and not Ortalab.config.enhancement_skip then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_chips',vars={chip_return}}, colour = G.C.BLUE, delay = 0, chip_mod = true}) end
            end
            return {
                chips = chip_return
            }            
        end
    end
})

SMODS.Enhancement({
    key = "bent",
    atlas = "ortalab_enhanced",
    pos = {x = 1, y = 0},
    discovered = false,
    config = {extra = {hand_mult = 2}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card and card.ability.extra.hand_mult or self.config.extra.hand_mult }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and context.main_scoring then
            local mult_return = 0
            for i, held_card in pairs(G.hand.cards) do
                if not Ortalab.config.enhancement_skip then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            held_card:juice_up()
                            play_sound('chips1', 0.8+ (0.9 + 0.2*math.random())*0.2, 1)
                            card:juice_up(0.6, 0.1)
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                            return true
                        end
                    }))
                end
                mult_return = mult_return + card.ability.extra.hand_mult
                if i ~= #G.hand.cards and not Ortalab.config.enhancement_skip then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_mult',vars={mult_return}}, colour = G.C.RED, delay = 0, mult_mod = true}) end
            end
            return {
                mult = mult_return
            }
            
        end
    end
})

SMODS.Enhancement({
    key = "index",
    atlas = "ortalab_enhanced",
    pos = {x = 2, y = 0},
    discovered = false,
    config = {extra = {index_state = 'MID'}},
    artist_credits = {'luna'},
    set_sprites = function(self, card, front)
        if card.ability and card.ability.extra and type(card.ability.extra) == 'table' and card.ability.index_state then 
            if card.ability.index_state == 'MID' then card.children.center:set_sprite_pos({x = 2, y = 0}) 
            elseif card.ability.index_state == 'UP' then card.children.center:set_sprite_pos({x = 1, y = 2}) 
            elseif card.ability.index_state == 'DOWN' then card.children.center:set_sprite_pos({x = 0, y = 2}) end
        end
    end,
    set_ability = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.index_state = 'MID'
        end
    end
})

SMODS.Sound({
    key = 'sand',
    path = 'sand.ogg'
})


SMODS.Enhancement({
    key = "sand",
    atlas = "ortalab_enhanced",
    pos = {x = 3, y = 0},
    config = {extra = {x_mult = 2.0, change=0.25}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card and card.ability.extra.x_mult or self.config.extra.x_mult, card and card.ability.extra.change or self.config.extra.change }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring and card.ability.extra.x_mult > 1 then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
        if context.final_scoring_step and (context.cardarea == G.hand or context.cardarea == G.play) and not next(SMODS.find_card('j_ortalab_sandstone')) then
            card.ability.extra.x_mult = card.ability.extra.x_mult - card.ability.extra.change
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ortalab_sand_crumble'), colour = G.C.GOLD, instant = true})
                    play_sound('ortalab_sand', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.5)
                    if card.ability.extra.x_mult and card.ability.extra.x_mult < 1 then
                        SMODS.destroy_cards(card)
                    end
                    card.particles = Particles(1, 1, 0,0, {
                        timer = 0.015,
                        scale = 0.3,
                        initialize = true,
                        lifespan = 1,
                        speed = 3,
                        padding = -1,
                        attach = card,
                        colours = {G.C.GOLD, lighten(G.C.GOLD, 0.4), lighten(G.C.GOLD, 0.2), darken(G.C.GOLD, 0.2)},
                        fill = true
                    })
                    card.particles.fade_alpha = 1
                    card.particles:fade(1, 0)
                    
                    return true
                end
            }))  
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1,
                func = function()
                    card.particles:remove()
                    return true
                end
            }))
        end
        if context.destroying_card and context.destroying_card == card and card.ability.extra.x_mult < 1 then
            return {
                remove = true
            }
        end
    end
})

SMODS.Sound({
    key = 'metal1',
    path = 'metal1.ogg'
})

SMODS.Enhancement({
    key = "rusty",
    atlas = "ortalab_enhanced",
    pos = {x = 0, y = 1},
    discovered = false,
    config = {extra = {base_x = 1.25, x_gain = 0.25}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.base_x, card_ability.extra.x_gain }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            local rusty_in_hand = 0
            for i, held_card in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(held_card, 'm_ortalab_rusty') then
                    if not Ortalab.config.enhancement_skip then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                held_card:juice_up()
                                play_sound('ortalab_metal1', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.5)
                                card:juice_up()
                                G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                                return true
                            end
                        }))
                    end
                    rusty_in_hand = rusty_in_hand + 1
                    if i ~= #G.hand.cards and not Ortalab.config.enhancement_skip then card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.base_x + (rusty_in_hand * card.ability.extra.x_gain)}}, colour = G.C.RED, delay = 0, Xmult_mod = true}) end
                end
            end
            local rusty_joker_add = 0
            for _, rusty_joker in ipairs(SMODS.find_card('j_ortalab_rusty')) do
                rusty_joker_add = rusty_joker_add + rusty_joker.ability.extra.gain
                if not Ortalab.config.enhancement_skip then
                    G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            func = function()
                                rusty_joker:juice_up()
                                play_sound('ortalab_metal1', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.5)
                                card:juice_up()
                                G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                                return true
                            end
                        }))
                    SMODS.calculate_effect({
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.base_x + (rusty_in_hand * card.ability.extra.x_gain) + (rusty_joker_add * rusty_in_hand)}},
                        colour = G.C.RED,
                        delay = 0,
                    }, card)
                end
            end
            return {
                x_mult = card.ability.extra.base_x + (rusty_in_hand * card.ability.extra.x_gain) + (rusty_joker_add * rusty_in_hand)
            }
        end
    end
})

SMODS.Enhancement({
    key = "ore",
    atlas = "ortalab_enhanced",
    pos = {x = 1, y = 1},
    discovered = false,
    no_rank = true,
    no_suit = true,
    replace_base_card = true,
    always_scores = true,
    config = {extra = {mult = 15}},
    artist_credits = {'eremel'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult }
        }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})

SMODS.Sound({
    key = 'cosmic',
    path = 'cosmic.ogg'
})

SMODS.Enhancement({
    key = "iou",
    atlas = "ortalab_enhanced",
    pos = {x = 2, y = 1},
    discovered = false,
    config = {extra = {level_up = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card and card.ability.extra.level_up or self.config.extra.level_up }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            Ortalab.modify_temp_levels(card.ability.extra.level_up, context.scoring_name)
            return {
                message = localize('ortalab_level_up'),
                colour = G.C.PURPLE,
                sound = 'ortalab_cosmic',
                pitch =  0.8+ (0.9 + 0.2*math.random())*0.2,
                volume = 0.5
            }     
        end
    end
})

SMODS.Enhancement({
    key = "recycled",
    atlas = "ortalab_enhanced",
    pos = {x = 3, y = 1},
    discovered = false,
    config = {extra = {discard_chance = 5, tag_chance = 15, tags = 1, chips = 125}},
    artist_credits = {'kosze', 'gappie'},
    loc_vars = function(self, info_queue, card)
        local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.discard_chance)
        local c, d = SMODS.get_probability_vars(card, 1, card.ability.extra.tag_chance)
        return {
            vars = { a, b, c, d, card.ability.extra.chips}
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'recycled_discard', 1, card.ability.extra.discard_chance) then
                --[[ease_discard(card.ability.extra.discards)]]
                ret = {
                    --[[message = localize('ortalab_moldy_discard'),]]
                    colour = G.C.RED,
                    chips = card.ability.extra.chips
                }
            end
            if SMODS.pseudorandom_probability(card, 'recycled_tag', 1, card.ability.extra.tag_chance) then
                card.recycled_tag = true
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder'))
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, pseudoseed('ortalab_hoarder_resample'..it))
                end
                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 0.4,
                    func = (function()
                        local tag = Tag(selected_tag, false, 'Small')
                        tag.from_recycled = true
                        add_tag(tag)
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
                if next(ret) then
                    ret.extra = {
                        message = localize('ortalab_moldy_tag'),
                        colour = G.C.BLUE,
                        
                    }
                else
                    ret = {
                        message = localize('ortalab_moldy_tag'),
                        colour = G.C.BLUE
                    }
                end 
            end
            return ret
        end
        if context.after and card.recycled_tag then
            card.recycled_tag = nil
        end
    end
})


local card_highlight = Card.highlight
function Card:highlight(highlighted)
    card_highlight(self, highlighted)
    if highlighted and self.area == G.hand and #G.hand.highlighted == 1 and not G.booster_pack and SMODS.has_enhancement(self, 'm_ortalab_index') then
        self.children.use_button = UIBox{
            definition = G.UIDEF.use_index_buttons(self), 
            config = {align = 'cl', offset = {x=0.5, y=0}, parent = self, id = 'ortalab_index'}
        }
    elseif self.area and self.area == G.hand and #self.area.highlighted > 0 and not G.booster_pack then
        for _, card in ipairs(self.area.highlighted) do
            if SMODS.has_enhancement(card, 'm_ortalab_index') then
                card.children.use_button = #self.area.highlighted == 1 and UIBox{
                    definition = G.UIDEF.use_index_buttons(card), 
                    config = {align = 'cl', offset = {x=0.5, y=0}, parent = card, id = 'ortalab_index'}
                } or nil
            end
        end
        -- self.children.use_button = nil
    elseif self.children.use_button and self.children.use_button.config.id == 'ortalab_index' then
        self.children.use_button:remove()
    end
    if highlighted and self.children.use_button and self.children.use_button.config.id == 'ortalab_index' and not SMODS.has_enhancement(self, 'm_ortalab_index') then
        self.children.use_button:remove()
    end
end

function G.UIDEF.use_index_buttons(card)
    local up = nil
    local mid = nil
    local down = nil

    up = {n=G.UIT.C, config={align = "cl"}, nodes={
            {n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 0.9, minh = 0.6, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'increase_index', func = 'index_card_increase'}, nodes={
                {n=G.UIT.T, config={text = '+1', colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true}}
            }}
        }}

    mid = {n=G.UIT.C, config={align = "cl"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 0.9, minh = 0.6, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'mid_index', func = 'index_card_mid'}, nodes={
            {n=G.UIT.T, config={text = ' 0', colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true}}
        }}
    }}

    down = {n=G.UIT.C, config={align = "cl"}, nodes={
        {n=G.UIT.C, config={ref_table = card, align = "cl",maxw = 1.25, padding = 0.1, r=0.08, minw = 0.9, minh = 0.6, hover = true, colour = G.C.UI.BACKGROUND_INACTIVE, button = 'decrease_index', func = 'index_card_decrease'}, nodes={
            {n=G.UIT.T, config={text = '-1', colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true}}
        }}
    }}

    local t = {n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
        {n=G.UIT.R, config={align = 'cl'}, nodes={
            up
        }},
        {n=G.UIT.R, config={align = 'cl'}, nodes={
            mid
        }},
        {n=G.UIT.R, config={align = 'cl'}, nodes={
            down
        }},
        }},
    }}
    return t
end

SMODS.Sound({
    key = 'index',
    path = 'index.ogg'
})

G.FUNCS.index_card_increase = function(e)
    if e.config.ref_table.ability.index_state ~= 'UP' then 
        e.config.colour = G.C.RED
        e.config.button = 'increase_index'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.increase_index = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    card.ability.extra = card.ability.extra or {index_state == 'MID'}
    local area = card.area
    local change = 1
    if card.ability.index_state == 'DOWN' then change = 2 end
    card.ability.index_state = 'UP'
    if not card.ability.chiselled or card.config.center_key == 'm_ortalab_index' then
        play_sound('ortalab_index', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.8)
        card.children.center.atlas.name = 'ortalab_enhanced'
        card.children.center.sprite_pos = {x = 1, y = 2}
        card.children.center:reset()
    end
    card.base.id = card.base.id + change
    SMODS.change_base(card, nil, get_rank_suffix(card)) 
end

G.FUNCS.index_card_mid = function(e)
    if e.config.ref_table.ability.index_state ~= 'MID' then 
        e.config.colour = G.C.RED
        e.config.button = 'mid_index'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.mid_index = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    local area = card.area
    local change = 1
    if card.ability.index_state == 'UP' then change = -1 end
    card.ability.index_state = 'MID'
    if not card.ability.chiselled or card.config.center_key == 'm_ortalab_index' then
        play_sound('ortalab_index', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.8)
        card.children.center.atlas.name = 'ortalab_enhanced'
        card.children.center.sprite_pos = {x = 2, y = 0}
        card.children.center:reset()
    end
    card.base.id = card.base.id + change
    SMODS.change_base(card, nil, get_rank_suffix(card)) 
end

G.FUNCS.index_card_decrease = function(e)
    if e.config.ref_table.ability.index_state ~= 'DOWN' then 
        e.config.colour = G.C.RED
        e.config.button = 'decrease_index'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end

G.FUNCS.decrease_index = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    local area = card.area
    local change = 1
    if card.ability.index_state == 'UP' then change = 2 end
    card.ability.index_state = 'DOWN'
    if not card.ability.chiselled or card.config.center_key == 'm_ortalab_index' then
        play_sound('ortalab_index', 0.8+ (0.9 + 0.2*math.random())*0.2, 0.8)
        card.children.center.atlas.name = 'ortalab_enhanced'
        card.children.center.sprite_pos = {x = 0, y = 2}
        card.children.center:reset()
    end
    card.base.id = card.base.id - change
    SMODS.change_base(card, nil, get_rank_suffix(card))
end