local ivory_card = SMODS.Enhancement({
    key = "ivory_card",
    atlas = "m_flc_enhancements",
    pos = {x = 0, y = 0},
    config = {extra = 1},
    loc_txt = {
        name = 'Ivory Card',
        text = { 
            'Retriggers the',
            'card to the right',
        },
    },
    weight = 4
})


local eval_cardRef = eval_card

function eval_card(card, context)
    ret, post = eval_cardRef(card, context)

    if context.repetition then
        local extra_reps = 0
        local other_card = nil

        local scoring = context.cardarea == G.play and context.scoring_hand or context.cardarea.cards
        
        if not scoring then return ret, post end

        for i = 2, #scoring do
            if scoring[i] == card then other_card = scoring[i-1] end
        end

        if other_card and other_card ~= card and not other_card.debuff and SMODS.has_enhancement(other_card, 'm_femtoLabsCollection_ivory_card') then
            extra_reps = 1

            for i=1, #SMODS.find_card('j_femtoLabsCollection_amulet') do
                extra_reps = extra_reps + 1
            end
        end
        if extra_reps > 0 then
            local rep_return = {
                message = localize('k_again_ex'),
                repetitions = extra_reps,
                card = other_card
            }
    
            if ret.jokers then
                table.insert(ret.jokers, rep_return)
            else 
                ret.jokers = rep_return
            end
        end
    end
    return ret, post
end

--ice card

dissolveRef = Card.start_dissolve
Card.start_dissolve = function(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
    if SMODS.has_enhancement(self, 'm_femtoLabsCollection_ice_card') then
        dissolve_colours = {HEX('7A9EC7'), HEX('9BB6D5'), HEX('BCCEE2'), HEX('DDE6F0'), HEX('FFFFFF')}
    end
    dissolveRef(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

local ice_card = SMODS.Enhancement({
    key = "ice_card",
    atlas = "m_flc_enhancements",
    pos = {x = 1, y = 0},
    config = {extra = {chips = 60, chip_mod = 20, calm_the_fuck_down = false}},
    loc_txt = {
        name = 'Ice Card',
        text = { 
            '{C:chips}+#1#{} extra chips when',
            'scored or held in hand',
            'decreases by {C:attention}#2#',
            'until melted',
        },
    }
})

ice_card.loc_vars = function(self, info_queue, card)
    return {
        vars = {
            card.ability.extra.chips,
            card.ability.extra.chip_mod,
        }
    }
end


ice_card.calculate = function(self, card, context)
    if context.main_scoring then
        if context.cardarea == G.play and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.cardarea == G.hand and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
    if context.after and (context.cardarea == G.play or context.cardarea == G.hand) and not context.end_of_round then
        if card.ability.extra.calm_the_fuck_down then
            card.ability.extra.calm_the_fuck_down = false
        else
            card.ability.extra.chips = math.max(card.ability.extra.chips - card.ability.extra.chip_mod, 0)
            if card.ability.extra.chips <= 0 then
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.CHIPS,
                    func = function()
                        card.destroyed = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'immediate',
                            blocking = true,
                            delay = 0.0,
                            func = (function()
                                card:start_dissolve(nil, true)
                                return true
                            end)}))

                        delay(0.3)
                        for j=1, #G.jokers.cards do
                            eval_card(G.jokers.cards[j], {cardarea = G.jokers, remove_playing_cards = true, removed = {card}})
                        end
                    end
                }
            else
                return {
                    message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_mod}},
                    colour = G.C.CHIPS
                }
            end
        end
    end
end

local bronze_seal = SMODS.Seal({
    key = 'bronze_seal',
    loc_txt = {
        name = 'Bronze Seal',
        label = 'Bronze Seal',
        text = {
            "Creates a {C:femtolabscollection_twilight}Twilight{} card",
            "when {C:attention}Enhanced",
            "{C:inactive}(Must have room)"
        }
    },
    badge_colour = HEX('B87E5E'),
    atlas = 'm_flc_enhancements', 
    pos = { x = 2, y = 0 },
    draw = function(self, card, layer)
        G.shared_seals[card.seal].role.draw_major = card
        G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
})

local set_abilityRef = Card.set_ability
Card.set_ability = function(self, center, initial, delay_sprites)
    local enh = self.config.center.key

    set_abilityRef(self, center, initial, delay_sprites)

    if delay_sprites == 'quantum' then return end

    if center.key ~= enh and center.key ~= 'c_base' and self.seal == "femtoLabsCollection_bronze_seal" and (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) then
        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    local card = SMODS.create_card({
                        set = "m_femtoLabsCollection_twilight", 
                        area = G.consumeables, 
                        key_append = "flc_bronze_seal", 
                        no_edition = true, 
                        skip_materialize = true
                    })
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                end
                return true end }))
        end
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = '+1 Twilight', colour = G.C.PURPLE})
    end

    if self.ability.set == "Enhanced" and (self.area == G.hand or self.area == G.play or self.area == G.deck) then
        if G.jokers then
            for i=1, #G.jokers.cards do
                G.jokers.cards[i]:calculate_joker({enhancing_card = true, cardarea = G.jokers, other_card = self})
            end
        end
    end
end

