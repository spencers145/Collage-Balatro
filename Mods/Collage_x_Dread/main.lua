-- empty

SMODS.Atlas({
    key = "collage_rot",
    path = "rot.png",
    px = 71,
    py = 95
})

function SMODS.current_mod.reset_game_globals(run_start)
    if run_start == true then
        G.GAME.slay_the_princess_count = 0
    end
end

SMODS.Consumable {
        set = 'Statement', atlas = 'collage_rot', key = 'interference',
        pos = { x = 0, y = 0 },
        cost = 8,
        config = {extra = {active = false}},
        discovered = false,
        can_use = function(self, card)
            if G.STATE == G.STATES.SELECTING_HAND then
                return not card.ability.extra.active
            else
                return false
            end
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        end,
        credit = {
            art = "AstraLuna",
            code = "base4",
            concept = "base4 & AstraLuna"
        },
        in_pool = function (self, args)
            return false
        end,
        use = function(self, card, area, copier)
            card.ability.extra.active = true
            play_sound('tma_statement1', 1.1 + math.random()*0.1, 0.8)
            local eval = function(card) return card.ability.extra.active end
            juice_card_until(card, eval, true)
        end,
        load = function(self,card,card_table,other_card)
            local eval = function(card) return card.ability.extra.active end
            juice_card_until(card, eval, true)
        end,
        keep_on_use = function(self, card)
            return true
        end,
        calculate = function(self, card, context)
            if context.before and card.ability.extra.active and not context.blueprint and not context.repetition then
                for key, playing_card in pairs(context.scoring_hand) do
                    --if playing_card.area == G.play then
                        if SMODS.pseudorandom_probability(card, pseudoseed('collage_interference'), 1, 3, 'collage_interference', true) then
                            playing_card.ability.perma_x_mult = playing_card.ability.perma_x_mult or 0
                            playing_card.ability.perma_x_mult = playing_card.ability.perma_x_mult + 0.1
                        elseif SMODS.pseudorandom_probability(card, pseudoseed('collage_interference'), 1, 2, 'collage_interference', true) then
                            playing_card.ability.perma_x_chips = playing_card.ability.perma_x_chips or 0
                            playing_card.ability.perma_x_chips = playing_card.ability.perma_x_chips + 0.1
                        else
                            playing_card.ability.perma_p_dollars = playing_card.ability.perma_p_dollars or 0
                            playing_card.ability.perma_p_dollars = playing_card.ability.perma_p_dollars + 1
                        end
                        playing_card:juice_up()
                    --end
                end
                return {
                    message = localize('k_upgrade_ex')
                }
            end
            if context.end_of_round and not context.repetition and not context.individual and not card.getting_sliced and card.ability.extra.active then
                card.getting_sliced = true
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    G.GAME.consumeable_buffer = 0
                    play_sound('tma_statement2', 1.0 + math.random()*0.1, 0.8)
                    card:start_dissolve()
                return true end }))
            end
        end
    }

    SMODS.Consumable {
        set = 'travel', atlas = 'collage_rot', key = 'slay_the_princess',
        pos = { x = 1, y = 0 },
        cost = 6,
        config = {extra = {hands = 1, times = 4}},
        discovered = false,
        can_use = function(self, card)
            return #G.hand.highlighted == 1 and G.hand.highlighted[1]:is_face()
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
            return {vars = {G.GAME.slay_the_princess_count, card.ability.extra.times}}
        end,
        in_pool = function (self, args)
            return false
        end,
        credit = {
            art = "AstraLuna",
            code = "base4",
            concept = "base4 & AstraLuna"
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand.highlighted[1].getting_sliced = true
                    G.hand.highlighted[1]:juice_up(0.8, 0.8)
                    G.hand.highlighted[1]:start_dissolve()
                    play_sound('slice1', 0.96+math.random()*0.08)

                    G.GAME.slay_the_princess_count = G.GAME.slay_the_princess_count or 0
                    G.GAME.slay_the_princess_count = G.GAME.slay_the_princess_count + 1

                    if G.GAME.slay_the_princess_count >= card.ability.extra.times then
                        G.GAME.slay_the_princess_count = 0
                        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                        ease_hands_played(card.ability.extra.hands)
                        -- stealing bunco functions
                        forced_message("+1 Hand!", card, G.C.BLUE)
                    end
                    return true
                end
            }))
        end
    }

    reset_bleached_cards = function ()
        for key, value in pairs(G.deck.cards) do
            value.config.bleached = nil
        end
        for key, value in pairs(G.hand.cards) do
            value.config.bleached = nil
        end
        for key, value in pairs(G.discard.cards) do
            value.config.bleached = nil
        end
    end

    SMODS.Consumable {
        set = 'art', atlas = 'collage_rot', key = 'art_bleach',
        pos = { x = 2, y = 0 },
        cost = 6,
        discovered = false,
        can_use = function(self, card)
            if #G.hand.highlighted == 1 then
                local the_card = G.hand.highlighted[1]
                return the_card.config.center ~= G.P_CENTERS.c_base or the_card.seal or the_card.edition
            end
            return false
        end,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
            info_queue[#info_queue+1] = { key = "losted_card_modifiers", set = "Other" }
        end,
        in_pool = function (self, args)
            return false
        end,
        credit = {
            art = "AstraLuna",
            code = "base4",
            concept = "AstraLuna"
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.hand.highlighted[1]:juice_up(0.8, 0.8)
                    local base = G.hand.highlighted[1].config.center
                    local extra = G.hand.highlighted[1].ability.extra
                    local seal = G.hand.highlighted[1].seal
                    local edition = G.hand.highlighted[1].edition

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand.highlighted[1]:set_ability(G.P_CENTERS.c_base)
                            G.hand.highlighted[1].config.bleached = true
                            return true
                        end
                    }))

                    local exclude = 1
                    for key, value in pairs(G.hand.cards) do
                        if G.hand.highlighted[1] == value then exclude = key end
                    end

                    local cards = SARC.get_rand_hand_index(3, {exclude})

                    if base ~= G.P_CENTERS.c_base then
                        for key, i in pairs(cards) do
                            local hand_card = G.hand.cards[i]
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    hand_card:juice_up(0.6, 0.6)
                                    hand_card:set_ability(base)
                                    hand_card.ability.extra = extra
                                    return true
                                end
                            }))
                        end
                    end

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand.highlighted[1]:set_seal(nil)
                            return true
                        end
                    }))

                    local cards = SARC.get_rand_hand_index(3, {exclude})

                    if seal then
                        for key, i in pairs(cards) do
                            local hand_card = G.hand.cards[i]
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    hand_card:juice_up(0.4, 0.4)
                                    hand_card:set_seal(seal)
                                    return true
                                end
                            }))
                        end
                    end

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand.highlighted[1]:set_edition(nil)
                            return true
                        end
                    }))
                    
                    local cards = SARC.get_rand_hand_index(3, {exclude})

                    if edition then
                        for key, i in pairs(cards) do
                            local hand_card = G.hand.cards[i]
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    hand_card:juice_up(0.5, 0.8)
                                    hand_card:set_edition(edition)
                                    return true
                                end
                            }))
                        end
                    end

                    return true
                end
            }))
        end
    }

    SMODS.Consumable {
        set = 'Polymino', atlas = 'collage_rot', key = 'buffer',
        pos = { x = 3, y = 0 },
        cost = 8,
        discovered = false,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        end,
        in_pool = function (self, args)
            return false
        end,
        credit = {
            art = "AstraLuna",
            code = "base4",
            concept = "base4 & AstraLuna"
        },
        can_use = function(self, card)
            local cards = G.hand.highlighted

            for i = 1, #cards do
                if cards[i].ability.group then return false end
            end

            if #cards >= 2 and #cards <= 5 then
                return true
            end
            return false
        end,

        use = function(self, card)
            link_cards(G.hand.highlighted, self.key)
            card:juice_up(0.3, 0.5)
        end,
    }

    -- yes this is just the code for shade
    SMODS.Consumable {
        set = 'BlackMarket', atlas = 'collage_rot', key = 'undeveloped_film',
        pos = { x = 4, y = 0 },
        cost = 8,
        discovered = false,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
            info_queue[#info_queue+1] = { key = 'e_negative_playing_card', set = 'Edition', config = {extra = G.P_CENTERS['e_negative'].config.card_limit} }
        end,
        in_pool = function (self, args)
            return false
        end,
        credit = {
            art = "AstraLuna",
            code = "base4",
            concept = "base4"
        },
        can_use = function(self, card)
            if G.hand and G.hand.cards and #G.hand.cards > 0 then
                for k, v in ipairs(G.hand.cards) do
                if not v.edition then 
                    return true 
                end
            end
            else
                return false
            end
        end,
        use = function(self, card, area, copier)
            local cards = {}
            for k, v in ipairs(G.hand.cards) do
                if not v.edition then cards[#cards + 1] = v end
            end
            local _card = pseudorandom_element(cards, pseudoseed('shade_card'))
            local edition = {negative = true}
        
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                    _card:set_edition(edition, true)
                return true end }))
            card:juice_up(0.3, 0.5)
        end,
    }

    -- yes this is just the code for chaos
    SMODS.Consumable {
        set = 'collectable', atlas = 'collage_rot', key = 'blind_box',
        pos = { x = 5, y = 0 },
        soul_pos = { x = 6, y = 0 },
        cost = 10,
        discovered = false,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        end,
        in_pool = function (self, args)
            return false
        end,
        can_use = function(self, card)
            return true
        end,
        credit = {
            art = "AstraLuna & SadCube",
            code = "base4",
            concept = "AstraLuna",
        },

        use = function(self, card)
            G.E_MANAGER:add_event(Event({
            func = (function()
                local tag_key = get_next_tag_key()
                while tag_key == 'tag_orbital' do
                    -- nuh uh
                    tag_key = get_next_tag_key()
                end
                add_tag(Tag(tag_key))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
            end),
        }))
        delay(0.6)
        end,
    }

    SMODS.Consumable {
        set = 'Divine', atlas = 'collage_rot', key = 'rapture',
        pos = { x = 5, y = 0 },
        soul_pos = { x = 7, y = 0 },
        cost = 8,
        discovered = false,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue+1] = G.P_CENTERS.e_ortalab_anaglyphic
            info_queue[#info_queue+1] = G.P_CENTERS.e_paperback_dichrome
            info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        end,
        in_pool = function (self, args)
            return false
        end,
        can_use = function(self, card)
            return true
        end,
        credit = {
            art = "Monachrome",
            code = "base4",
            concept = "base4 & AstraLuna",
        },
        use = function(self, card)
            G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                local added_card = SMODS.add_card({ set = 'Spectral' })
                if SMODS.pseudorandom_probability(card, pseudoseed('collage_rapture'), 1, 2, 'collage_rapture', true) then
                    added_card:set_edition('e_paperback_dichrome', true)
                else
                    added_card:set_edition('e_ortalab_anaglyphic', true)
                end
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        delay(0.6)
        end,
    }