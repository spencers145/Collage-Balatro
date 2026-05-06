-- Season cycle
local season_loc_vars = function(self, info_queue, card)
    return { vars = { localize(card.ability.extra.from_suit, 'suits_singular'), localize(card.ability.extra.to_suit, 'suits_plural'), colours = { card.ability.extra.from_color, card.ability.extra.to_color } } }
end
local season_calculate = function(self, card, context)
    if context.before and not context.blueprint then
        local convert = false
        for _, scored_card in ipairs(context.scoring_hand) do
            if scored_card:is_suit(card.ability.extra.from_suit) and not scored_card.debuff then
                convert = true
                assert(SMODS.change_base(scored_card, card.ability.extra.to_suit))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        scored_card:juice_up()
                        return true
                    end
                }))
            end
        end
        if convert then
            return {
                message = localize('season_convert'),
                colour = card.ability.extra.to_color
            }
        end
    end
end

-- Summer
SMODS.Joker {
    key = "summer",
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 0 },
    config = { extra = { mult = -3, xmult = 1.3, from_suit = "Clubs", to_suit = "Hearts", from_color = G.C.SUITS.Clubs, to_color = G.C.SUITS.Hearts} },
    loc_vars = function (self, info_queue, card)
        local vars = season_loc_vars(self, info_queue, card)
        table.insert(vars.vars, card.ability.extra.mult)
        table.insert(vars.vars, card.ability.extra.xmult)
        return vars
    end,
    calculate = function (self, card, context)
        local season = season_calculate(self, card, context)
        if season then
            return season
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.to_suit) then
            return {
                xmult = card.ability.extra.xmult,
                mult = math.max(-mult, card.ability.extra.mult),
            }
        end
    end,
}

-- Fall
SMODS.Joker {
    key = "fall",
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 0 },
    config = { extra = { chips = 125, odds = 2, from_suit = "Hearts", to_suit = "Spades", from_color = G.C.SUITS.Hearts, to_color = G.C.SUITS.Spades} },
    loc_vars = function (self, info_queue, card)
        local vars = season_loc_vars(self, info_queue, card)
        table.insert(vars.vars, card.ability.extra.chips)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        table.insert(vars.vars, n)
        table.insert(vars.vars, d)
        return vars
    end,
    calculate = function (self, card, context)
        local season = season_calculate(self, card, context)
        if season then
            return season
        end
            if context.individual and SMODS.pseudorandom_probability(card, pseudoseed('j_cod_summer'), 1, card.ability.extra.odds) and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.to_suit) then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end,
}

-- Winter
SMODS.Joker {
    key = "winter",
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 0 },
    config = { extra = { chips = -25, money = 2, from_suit = "Spades", to_suit = "Diamonds", from_color = G.C.SUITS.Spades, to_color = G.C.SUITS.Diamonds} },
    loc_vars = function (self, info_queue, card)
        local vars = season_loc_vars(self, info_queue, card)
        table.insert(vars.vars, card.ability.extra.chips)
        table.insert(vars.vars, card.ability.extra.money)
        return vars
    end,
    calculate = function (self, card, context)
        local season = season_calculate(self, card, context)
        if season then
            return season
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.to_suit) then
            return {
                chips = math.max(-chips, card.ability.extra.chips),
                dollars = card.ability.extra.money
            }
        end
    end,
}

-- Spring
SMODS.Joker {
    key = "spring",
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 0 },
    config = { extra = { money = -1, odds = 2, mult = 14, from_suit = "Diamonds", to_suit = "Clubs", from_color = G.C.SUITS.Diamonds, to_color = G.C.SUITS.Clubs} },
    loc_vars = function (self, info_queue, card)
        local vars = season_loc_vars(self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        table.insert(vars.vars, card.ability.extra.mult)
        table.insert(vars.vars, n)
        table.insert(vars.vars, d)
        table.insert(vars.vars, -card.ability.extra.money)
        return vars
    end,
    calculate = function (self, card, context)
        local season = season_calculate(self, card, context)
        if season then
            return season
        end
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.to_suit) then
            return {
                mult = card.ability.extra.mult,
                dollars = SMODS.pseudorandom_probability(card, pseudoseed('j_cod_spring'), 1, card.ability.extra.odds) and card.ability.extra.money or nil
            }
        end
    end,
}

-- Mitosis
SMODS.Joker {
    key = "mitosis",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 3 },
    -- amount is unused
    config = { extra = { amount = 1, suit = "Hearts", color = G.C.SUITS.Hearts, xmult = 0.1} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.xmult, colours = { card.ability.extra.color } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local valid_mitosis_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit(card.ability.extra.suit) and not playing_card.getting_sliced then
                    valid_mitosis_cards[#valid_mitosis_cards + 1] = playing_card
                end
            end
            local mitosis_card = pseudorandom_element(valid_mitosis_cards, 'cod_mitosis')
            if mitosis_card then

                draw_card(G.deck, G.play, 90, 'up', nil, mitosis_card)

                local card_copied = copy_card(mitosis_card, nil, nil, G.playing_card)
                card_copied.states.visible = nil
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                card_copied.playing_card = G.playing_card
                table.insert(G.playing_cards, card_copied)

                card_copied.ability.perma_x_mult = card_copied.ability.perma_x_mult + card.ability.extra.xmult

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.5,
                    func = function()
                        card_copied:start_materialize()
                        G.play:emplace(card_copied)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        return true
                    end
                }))

                draw_card(G.play, G.deck, 90, 'up', nil, mitosis_card)
                draw_card(G.play, G.deck, 90, 'up', nil, card_copied)
                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                return {
                    message = localize('mitosis_split'),
                    colour = card.ability.extra.color,
                }
            end
        end
    end
}

-- Invasion
SMODS.Joker {
    key = "invasion",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 3 },
    config = { extra = { amount = 2, suit = "Spades", color = G.C.SUITS.Spades, chips = 20} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.chips, colours = { card.ability.extra.color } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            
            local spade_card1 = SMODS.create_card { set = "Base", suit = card.ability.extra.suit, area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            spade_card1.playing_card = G.playing_card
            table.insert(G.playing_cards, spade_card1)

            G.E_MANAGER:add_event(Event({
                func = function()
                    spade_card1:start_materialize()
                    G.play:emplace(spade_card1)
                    return true
                end
            }))

            local spade_card2 = SMODS.create_card { set = "Base", suit = card.ability.extra.suit, area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            spade_card2.playing_card = G.playing_card
            table.insert(G.playing_cards, spade_card2)

            spade_card1.ability.perma_bonus = card.ability.extra.chips
            spade_card2.ability.perma_bonus = card.ability.extra.chips

            G.E_MANAGER:add_event(Event({
                func = function()
                    spade_card2:start_materialize()
                    G.play:emplace(spade_card2)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1,
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 2
                    return true
                end
            }))

            draw_card(G.play, G.deck, 90, 'up', nil, spade_card1)
            draw_card(G.play, G.deck, 90, 'up', nil, spade_card2)

            SMODS.calculate_context({ playing_card_added = true, cards = { spade_card1, spade_card2 } })
            return {
                message = localize('invasion_attack'),
                colour = card.ability.extra.color,
            }
        end
    end
}

-- Purification
SMODS.Joker {
    key = "purification",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 3 },
    config = { extra = { amount = 1, suit = "Diamonds", color = G.C.SUITS.Diamonds, money = 3} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.money, colours = { card.ability.extra.color } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards_removed = 0
            for i=1,card.ability.extra.amount do
                local valid_remove_cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not playing_card:is_suit(card.ability.extra.suit) and not playing_card.getting_sliced then
                        valid_remove_cards[#valid_remove_cards + 1] = playing_card
                    end
                end
                local remove_card = pseudorandom_element(valid_remove_cards, 'cod_purification')
                if remove_card then
                    remove_card.getting_sliced = true
                    draw_card(G.deck, G.play, 90, 'up', nil, remove_card)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 1,
                        func = function()
                            return true
                        end
                    }))
                    SMODS.destroy_cards(remove_card)
                    cards_removed = cards_removed + 1
                end
            end
            
            if cards_removed > 0 then
                return {
                    message = localize('purification_remove'),
                    colour = card.ability.extra.color,
                    dollars = card.ability.extra.money,
                }
            end
        end
    end
}

-- Overgrowth
SMODS.Joker {
    key = "overgrowth",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 0 },
    -- amount is unused
    config = { extra = { amount = 1, suit = "Clubs", color = G.C.SUITS.Clubs, mult = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_plural'), card.ability.extra.mult, colours = { card.ability.extra.color } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local valid_overgrowth_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card.base.suit ~= card.ability.extra.suit and not SMODS.has_no_suit(playing_card) and not playing_card.getting_sliced then
                    valid_overgrowth_cards[#valid_overgrowth_cards + 1] = playing_card
                end
            end
            local overgrowth_card = pseudorandom_element(valid_overgrowth_cards, 'cod_overgrowth')
            if overgrowth_card then
                draw_card(G.deck, G.play, 90, 'up', nil, overgrowth_card)

                overgrowth_card.ability.perma_mult = overgrowth_card.ability.perma_mult + card.ability.extra.mult

                assert(SMODS.change_base(overgrowth_card, card.ability.extra.suit, nil, true))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        overgrowth_card:set_sprites(nil, overgrowth_card.config.card)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        return true
                    end
                }))

                draw_card(G.play, G.deck, 90, 'up', nil, overgrowth_card)
                
                return {
                    message = localize('overgrowth_grow'),
                    colour = card.ability.extra.color,
                }
            end

        end
    end
}

-- Short Joker
SMODS.Joker {
    key = "short",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 2 },
    pixel_size = { h = 56 },
    config = { extra = { chips = 100, max_sum = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.max_sum } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rank_sum = 0
            for i = 1,#context.full_hand do
                rank_sum = rank_sum + context.full_hand[i].base.nominal
            end

            if rank_sum <= card.ability.extra.max_sum then
                return {
                    chips = card.ability.extra.chips,
                }
            end
        end
    end,
}

-- Tall Joker
SMODS.Joker {
    key = "tall",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 2 },
    config = { extra = { mult = 12, min_sum = 40 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.min_sum } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rank_sum = 0
            for i = 1,#context.full_hand do
                rank_sum = rank_sum + context.full_hand[i].base.nominal
            end

            if rank_sum >= card.ability.extra.min_sum then
                return {
                    mult = card.ability.extra.mult,
                }
            end
        end
    end,
}

-- Hungry Joker
SMODS.Joker {
    key = "hungry",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 1 },
    config = {  extra = { eat_size = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.eat_size } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local cards_eaten = 0
            local eaten_cards = {}
            for i=1,card.ability.extra.eat_size do
                local valid_hungry_cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not playing_card.getting_sliced then
                        valid_hungry_cards[#valid_hungry_cards + 1] = playing_card
                    end
                end
                local hungry_card = pseudorandom_element(valid_hungry_cards, 'cod_hungry')
                if hungry_card then
                    draw_card(G.deck, G.play, 90, 'up', nil, hungry_card)
                    hungry_card.getting_sliced = true
                    eaten_cards[#eaten_cards+1] = hungry_card
                    cards_eaten = cards_eaten + 1
                end
            end
            
            if cards_eaten > 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        return true
                    end
                }))
                SMODS.destroy_cards(eaten_cards)

                return {
                    message = localize(pseudorandom_element({"hungry_1", "hungry_2", "hungry_3", "hungry_4", "hungry_5"}, 'cod_hungry_text')),
                    colour = G.C.RED,
                }
            else
                return {
                    message = localize('hungry_cant'),
                    colour = G.C.RED,
                }
            end

        end
    end
}

-- Homework
SMODS.Joker {
    key = "homework",
    unlocked = true,
    blueprint_compat = true,
    cod_confidential_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 4, sum = 2, min_sum = 2, max_sum = 55 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.sum } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rank_sum = 0
            for i = 1,#context.full_hand do
                rank_sum = rank_sum + context.full_hand[i].base.nominal
            end
            
            local difference = math.abs(rank_sum - card.ability.extra.sum)

            if difference == 0 then
                return {
                    xmult = card.ability.extra.xmult,
                    message = localize('homework_a'),
                    colour = G.C.GREEN,
                }
            elseif difference == 1 then
                return {
                    xmult = card.ability.extra.xmult-1,
                    message = localize('homework_c'),
                    colour = G.C.GOLD,
                }
            elseif difference == 2 then
                return {
                    xmult = card.ability.extra.xmult-2,
                    message = localize('homework_e'),
                    colour = G.C.GOLD,
                }
            else
                return {
                    message = localize('homework_f'),
                    colour = G.C.RED,
                }
            end
        end
        if context.after and not context.blueprint then
            card.ability.extra.sum = pseudorandom('cod_homework', card.ability.extra.min_sum, card.ability.extra.max_sum)
            return {
                message = localize('k_reset')
            }
        end
    end,
    --initial random roll
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.sum = pseudorandom('cod_homework', card.ability.extra.min_sum, card.ability.extra.max_sum)
    end
}

-- The Conspiracy
-- SMODS.Joker {
--     key = "conspiracy",
--     unlocked = true,
--     blueprint_compat = true,
--     rarity = 3,
--     cost = 8,
--     atlas = 'atlas_cod_jokers',
--     pos = { x = 8, y = 0 },
--     config = { extra = { xmult = 4} },
--     loc_vars = function(self, info_queue, card)
--         return { vars = { card.ability.extra.xmult } }
--     end,
--     calculate = function(self, card, context)
--         if context.joker_main then
--             if next(context.poker_hands["Flush House"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Five of a Kind"]) then
--                 return {
--                     xmult = card.ability.extra.xmult
--                 }
--             end
--             -- more general solution that doesnt work
--             -- for i = 1, #G.hands do
--             --     if G.hands[i].visible and next(context.poker_hands[G.hands[i]]) then          
--             --         return {
--             --             xmult = card.ability.extra.Xmult
--             --         }
--             --     end
--             -- end
--         end
--     end,
--     locked_loc_vars = function(self, info_queue, card)
--         return { vars = { localize('High Card', 'poker_hands') } }
--     end,
--     check_for_unlock = function(self, args)
--         return args.type == 'win_no_hand' and G.GAME.hands['High Card'].played == 0
--     end
-- }

-- Singularity
SMODS.Joker {
    key = "singularity",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 0 },
    config = { extra = { xmult = 0.5 } },
    loc_vars = function(self, info_queue, card)
        local lowest_plays = nil
        for handname, hand in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and hand.played > 0 then
                if not lowest_plays or hand.played < lowest_plays then
                    lowest_plays = hand.played
                end
            end
        end
        lowest_plays = lowest_plays or 0

        return { vars = { card.ability.extra.xmult, 1 + card.ability.extra.xmult * lowest_plays } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
            local lowest_plays = nil
            for handname, hand in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and hand.played > 0 then
                    if not lowest_plays or hand.played < lowest_plays then
                        lowest_plays = hand.played
                    end
                end
            end
            lowest_plays = lowest_plays or 0
            return {
                xmult = 1 + card.ability.extra.xmult * lowest_plays
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
            local lowest_plays = nil
            for handname, hand in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and hand.played > 0 then
                    if not lowest_plays or hand.played < lowest_plays then
                        lowest_plays = hand.played
                    end
                end
            end
            lowest_plays = lowest_plays or 0
            return lowest_plays >= 3
        end
    end
}

-- Chosen One
SMODS.Joker {
    key = "chosen_one",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 2 },
    config = {},
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and G.GAME.blind.name ~= "Small Blind" and G.GAME.blind.name ~= "Big Blind" then
            return {
                repetitions = 1
            }
        end
    end
}

-- Hiding Joker
SMODS.Joker {
    key = "hiding",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 2 },
    config = { extra = { d_size = 3, cards_to_flip = 0 } },
    soul_pos = {
        x = 6, y = 2
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.discard then
                card.ability.extra.cards_to_flip = card.ability.extra.cards_to_flip + 1
            end
            if context.stay_flipped and context.to_area == G.hand and card.ability.extra.cards_to_flip > 0 then
                card.ability.extra.cards_to_flip = card.ability.extra.cards_to_flip - 1
                return {
                    stay_flipped = true
                }
            end
            if context.setting_blind or context.hand_drawn then
                card.ability.extra.cards_to_flip = 0
            end
        end
    end,
}

-- Spam
SMODS.Joker {
    key = "spam",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    config = { extra = { spam_cards = 1, spam_tags = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.spam_cards } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            for i=1,card.ability.extra.spam_cards do

                local _card = SMODS.create_card { set = "Base", area = G.discard }
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                _card.playing_card = G.playing_card
                table.insert(G.playing_cards, _card)

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand:emplace(_card)
                        _card:start_materialize()
                        G.GAME.blind:debuff_card(_card)
                        G.hand:sort()
                        if context.blueprint_card then
                            context.blueprint_card:juice_up()
                        else
                            card:juice_up()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                        save_run()
                        return true
                    end
                }))
            end

            for i = 1, card.ability.extra.spam_tags do
                return {
                    message = localize('paperback_plus_tag'),
                    func = function()
                        G.E_MANAGER:add_event(Event({
                        func = function()
                            PB_UTIL.add_tag(PB_UTIL.poll_tag("spam"))
                            return true
                        end
                        }))
                    end
                }
            end

            return {
                message = localize(pseudorandom_element({"spam_1", "spam_2", "spam_3", "spam_4", "spam_5"}, 'cod_spam_text')),
                colour = G.C.GOLD,
            }
        end
    end
}

-- Cantrip
SMODS.Joker {
    key = "cantrip",
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 3 },
    config = { extra = { hands = 2, poker_hand = "High Card"} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand and G.GAME.hands[context.scoring_name].played_this_round == 1 then

            ease_hands_played(card.ability.extra.hands)

            return {
                message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } },
                colour = G.C.BLUE,
            }
        end
    end,
}

-- Password
SMODS.Joker {
    key = "password",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 3 },
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local number = false
            local letter = false
            for i = 1, #context.scoring_hand do
                if not SMODS.has_no_rank(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:get_id() >= 11 then
                        letter = true
                    end
                    if context.scoring_hand[i]:get_id() <= 10 then
                        number = true
                    end
                end
            end
            if letter and number then
                return {
                    xmult = card.ability.extra.xmult,
                }
            else
                return {
                    message = localize("password_weak"),
                    colour = G.C.RED
                }
            end
        end
    end,
}

-- Unpredictable
SMODS.Joker {
    key = "random",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 3 },
    config = { extra = { current = {}, possibilities = { xmult = 1.5, mult = 10, chips = 50, h_size = 1, discards = 1, hands = 1, sell_value = 7, probability = 1 } } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.current.xmult then return { key = "j_cod_random_xmult", vars = { card.ability.extra.current.xmult, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.mult then return { key = "j_cod_random_mult", vars = { card.ability.extra.current.mult, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.chips then return { key = "j_cod_random_chips", vars = { card.ability.extra.current.chips, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.h_size then return { key = "j_cod_random_h_size", vars = { card.ability.extra.current.h_size, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.discards then return { key = "j_cod_random_discards", vars = { card.ability.extra.current.discards, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.hands then return { key = "j_cod_random_hands", vars = { card.ability.extra.current.hands, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.sell_value then return { key = "j_cod_random_sell_value", vars = { card.ability.extra.current.sell_value, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
        if card.ability.extra.current.probability then return { key = "j_cod_random_probability", vars = { card.ability.extra.current.probability, localize("cod_random_joker_change"), localize("cod_random_joker_name") } } end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.current.hands
            ease_hands_played(card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.current.discards
            ease_discard(card.ability.extra.current.discards)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(-card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
            ease_hands_played(-card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
            ease_discard(-card.ability.extra.current.discards)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.current.xmult or card.ability.extra.current.mult or card.ability.extra.current.chips then
                return card.ability.extra.current
            end
        end

        if context.mod_probability and card.ability.extra.current.probability then
            return {
                numerator = context.numerator + card.ability.extra.current.probability
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then

            if card.ability.extra.current.discards then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
                ease_discard(-card.ability.extra.current.discards)
            end

            if card.ability.extra.current.hands then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
                ease_hands_played(-card.ability.extra.current.hands)
            end

            if card.ability.extra.current.h_size then
                G.hand:change_size(-card.ability.extra.current.h_size)
            end

            if card.ability.extra.current.sell_value then
                card.ability.extra_value = card.ability.extra_value - card.ability.extra.current.sell_value
            end

            local c_val, c_key = pseudorandom_element(card.ability.extra.possibilities, 'cod_random_joker')
            card.ability.extra.current = {}
            card.ability.extra.current[c_key] = c_val

            if card.ability.extra.current.discards then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.current.discards
                ease_discard(card.ability.extra.current.discards)
            end

            if card.ability.extra.current.hands then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.current.hands
                ease_hands_played(card.ability.extra.current.hands)
            end

            if card.ability.extra.current.h_size then
                G.hand:change_size(card.ability.extra.current.h_size)
            end

            if card.ability.extra.current.sell_value then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.current.sell_value
            end
            card:set_cost()

            return {
                message = localize('k_reset')
            }
        end
    end,
    --initial random roll
    set_ability = function(self, card, initial, delay_sprites)
        local c_val, c_key = pseudorandom_element(card.ability.extra.possibilities, 'cod_random_joker')
        card.ability.extra.current = {}
        card.ability.extra.current[c_key] = c_val

        if card.ability.extra.current.sell_value then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.current.sell_value
        end
    end
}

-- Possibility space
SMODS.Joker {
    key = "random_big",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 3 },
    config = { extra = { current = {}, possibilities = { xmult = 3, mult = 50, chips = 250, h_size = 2, discards = 3, hands = 2, sell_value = 20, probability = 2, retrigger = true } } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.current.xmult then return { key = "j_cod_random_xmult", vars = { card.ability.extra.current.xmult, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.mult then return { key = "j_cod_random_mult", vars = { card.ability.extra.current.mult, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.chips then return { key = "j_cod_random_chips", vars = { card.ability.extra.current.chips, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.h_size then return { key = "j_cod_random_h_size", vars = { card.ability.extra.current.h_size, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.discards then return { key = "j_cod_random_discards", vars = { card.ability.extra.current.discards, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.hands then return { key = "j_cod_random_hands", vars = { card.ability.extra.current.hands, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.sell_value then return { key = "j_cod_random_sell_value", vars = { card.ability.extra.current.sell_value, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.probability then return { key = "j_cod_random_probability", vars = { card.ability.extra.current.probability, localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
        if card.ability.extra.current.retrigger then return { key = "j_cod_random_retrigger", vars = { localize("cod_random_joker_change"), localize("cod_random_big_joker_name") } } end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.current.hands
            ease_hands_played(card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.current.discards
            ease_discard(card.ability.extra.current.discards)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(-card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
            ease_hands_played(-card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
            ease_discard(-card.ability.extra.current.discards)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.current.xmult or card.ability.extra.current.mult or card.ability.extra.current.chips then
                return card.ability.extra.current
            end
        end

        if context.repetition and context.cardarea == G.play and card.ability.extra.current.retrigger then
            return {
                repetitions = 1
            }
        end

        if context.mod_probability and card.ability.extra.current.probability then
            return {
                numerator = context.numerator + card.ability.extra.current.probability
            }
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then

            if card.ability.extra.current.discards then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
                ease_discard(-card.ability.extra.current.discards)
            end

            if card.ability.extra.current.hands then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
                ease_hands_played(-card.ability.extra.current.hands)
            end

            if card.ability.extra.current.h_size then
                G.hand:change_size(-card.ability.extra.current.h_size)
            end

            if card.ability.extra.current.sell_value then
                card.ability.extra_value = card.ability.extra_value - card.ability.extra.current.sell_value
            end

            local c_val, c_key = pseudorandom_element(card.ability.extra.possibilities, 'cod_random_big_joker')
            card.ability.extra.current = {}
            card.ability.extra.current[c_key] = c_val

            if card.ability.extra.current.discards then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.current.discards
                ease_discard(card.ability.extra.current.discards)
            end

            if card.ability.extra.current.hands then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.current.hands
                ease_hands_played(card.ability.extra.current.hands)
            end

            if card.ability.extra.current.h_size then
                G.hand:change_size(card.ability.extra.current.h_size)
            end

            if card.ability.extra.current.sell_value then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.current.sell_value
            end
            card:set_cost()

            return {
                message = localize('k_reset')
            }
        end
    end,
    --initial random roll
    set_ability = function(self, card, initial, delay_sprites)
        local c_val, c_key = pseudorandom_element(card.ability.extra.possibilities, 'cod_random_big_joker')
        card.ability.extra.current = {}
        card.ability.extra.current[c_key] = c_val

        if card.ability.extra.current.sell_value then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.current.sell_value
        end
    end
}

-- Ricochet
SMODS.Joker {
    key = "ricochet",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 4 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator1 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_ricochet')
        local denominator2 = denominator1 + 1
        local denominator3 = denominator2 + 1
        return { vars = {numerator, denominator1, denominator2, denominator3} }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card:is_suit("Diamonds") then
            local bounces = 0
            local odds = card.ability.extra.odds
            for i=1,256 do
                if SMODS.pseudorandom_probability(card, 'cod_ricochet', 1, odds) then
                    bounces = bounces + 1
                    odds = odds + 1
                else
                    break
                end
            end
            
            if bounces>0 then
                return {
                    repetitions = bounces
                }
            end
        end
    end
}

-- Tapas
SMODS.Joker {
    key = "tapas",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 4 },
    config = { extra = { dishes = 3, current = {}, possibilities = { xmult = 1.5, mult = 10, chips = 50, h_size = 1, discards = 1, hands = 1, probability = 1 } } },
    loc_vars = function(self, info_queue, card)
        local effects = {}
        local colors = {}
        local index = 1
        for k, v in pairs(card.ability.extra.current) do
            if k == "xmult" then
                effects[index] = "X"..tostring(v)
                effects[index+1] = "Mult"
                colors[index] = G.C.WHITE
                colors[index+1] = G.C.RED
            end
            if k == "mult" then
                effects[index] = "+"..tostring(v)
                effects[index+1] = "Mult"
                colors[index] = G.C.RED
                colors[index+1] = G.C.WHITE
            end
            if k == "chips" then
                effects[index] = "+"..tostring(v)
                effects[index+1] = "Chips"
                colors[index] = G.C.BLUE
                colors[index+1] = G.C.WHITE
            end
            if k == "h_size" then
                effects[index] = "+"..tostring(v)
                effects[index+1] = "hand size"
                colors[index] = G.C.ORANGE
                colors[index+1] = G.C.WHITE
            end
            if k == "discards" then
                effects[index] = "+"..tostring(v)
                effects[index+1] = "discards"
                colors[index] = G.C.RED
                colors[index+1] = G.C.WHITE
            end
            if k == "hands" then 
                effects[index] = "+"..tostring(v)
                effects[index+1] = "Hands"
                colors[index] = G.C.BLUE
                colors[index+1] = G.C.WHITE
            end
            if k == "sell_value" then
                effects[index] = "+$"..tostring(v)
                effects[index+1] = "sell value"
                colors[index] = G.C.GOLD
                colors[index+1] = G.C.WHITE
            end
            if k == "probability" then
                effects[index] = "+"..tostring(v)
                effects[index+1] = "probability"
                colors[index] = G.C.GREEN
                colors[index+1] = G.C.WHITE
            end
            index = index + 2
        end

        effects["colours"] = colors;

        return {
            vars = effects,
            key = "j_cod_tapas_"..tostring(card.ability.extra.dishes),
        }

    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.current.hands
            ease_hands_played(card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.current.discards
            ease_discard(card.ability.extra.current.discards)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.current.h_size then
            G.hand:change_size(-card.ability.extra.current.h_size)
        end
        if card.ability.extra.current.hands then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
            ease_hands_played(-card.ability.extra.current.hands)
        end
        if card.ability.extra.current.discards then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
            ease_discard(-card.ability.extra.current.discards)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.current.xmult or card.ability.extra.current.mult or card.ability.extra.current.chips then
                return card.ability.extra.current
            end
        end

        if context.mod_probability and card.ability.extra.current.probability then
            return {
                numerator = context.numerator + card.ability.extra.current.probability
            }
        end

        if context.end_of_round and context.beat_boss and context.game_over == false and context.main_eval and not context.blueprint then

            card.ability.extra.dishes = card.ability.extra.dishes - 1

            local _, c_key = pseudorandom_element(card.ability.extra.current, 'cod_random_joker')

            if c_key == "discards" then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.current.discards
                ease_discard(-card.ability.extra.current.discards)
            end

            if c_key == "hands" then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.current.hands
                ease_hands_played(-card.ability.extra.current.hands)
            end

            if c_key == "h_size" then
                G.hand:change_size(-card.ability.extra.current.h_size)
            end

            if c_key == "sell_value" then
                card.ability.extra_value = card.ability.extra_value - card.ability.extra.current.sell_value
            end

            card.ability.extra.current[c_key] = nil

            card:set_cost()

            if card.ability.extra.dishes == 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('k_eaten_ex')
                }
            else
                return {
                    message = localize('tapas_bite')
                }
            end
        end
    end,
    --initial random roll
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.current = {}
        
        for i=1,card.ability.extra.dishes do
            local c_val, c_key = pseudorandom_element(card.ability.extra.possibilities, 'cod_random_joker')
            card.ability.extra.current[c_key] = c_val
            card.ability.extra.possibilities[c_key] = nil
        end

        if card.ability.extra.current.sell_value then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.current.sell_value
        end
    end
}

-- Gear Stick
SMODS.Joker {
    key = "gear_stick",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 4 },
    config = { extra = { xmult = 0.2 } },
    loc_vars = function(self, info_queue, card)
        local gear = 0
        local passed_self = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    if G.jokers.cards[i] == card then
                        passed_self = true
                    else
                        if passed_self then
                            gear = gear + 1
                        else
                            gear = gear - 1
                        end
                    end
                end
            end
        end
        return { vars = { card.ability.extra.xmult, 1 + (gear*card.ability.extra.xmult) } }
    end,
    calculate = function(self, card, context)
        local gear = 0
        local passed_self = false
        if context.joker_main then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    if G.jokers.cards[i] == card then
                        passed_self = true
                    else
                        if passed_self then
                            gear = gear + 1
                        else
                            gear = gear - 1
                        end
                    end
                end
            end
            return {
                xmult = 1 + (gear*card.ability.extra.xmult)
            }
        end
    end,
}

-- Limbo
SMODS.Joker {
    key = "limbo",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 4 },
    config = { extra = { mult_gain = 1, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == "High Card" then
                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { localize('High Card', 'poker_hands') } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_no_hand' and G.GAME.hands['High Card'].played == 0
    end
}

-- Patent
SMODS.Joker {
    key = "patent",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 4 },
    config = { extra = {  dollars = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.hands[context.scoring_name].played == 1 then
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
        end
    end,
    in_pool = function(self, args)
        for handname, hand in pairs(G.GAME.hands) do
            if G.GAME.hands[handname].played == 0 then
                return true
            end
        end
        return false
    end,
}

-- Rule of Three
SMODS.Joker {
    key = "rule_of_three",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 4 },
    config = { extra = { xmult = 3, required = 3, rank = 3, count = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult,card.ability.extra.required, card.ability.extra.rank, card.ability.extra.count } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 3 then
            card.ability.extra.count = card.ability.extra.count + 1
            if (card.ability.extra.count >= card.ability.extra.required) then
                card.ability.extra.count = 0
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Astral Transit
SMODS.Joker {
    key = "astral_transit",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 4 },
    calculate = function(self, card, context)
         if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= context.consumeable.ability.hand_type then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            local transit_planet = pseudorandom_element(_poker_hands, 'cod_astral_transit')
            SMODS.upgrade_poker_hands({hands = transit_planet, level_up = 1, from = card})
        end
    end,
}

-- Death Star
SMODS.Joker {
    key = "death_star",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 4 },
    config = { extra = {  chips = 0, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local level_ups = G.GAME.hands[context.scoring_name].level - 1
            if level_ups > 0 then

                -- update to work better with custom scaled hands? just check chips before vs chips after?
                card.ability.extra.chips = card.ability.extra.chips + (G.GAME.hands[context.scoring_name].l_chips*level_ups)
                card.ability.extra.mult = card.ability.extra.mult + (G.GAME.hands[context.scoring_name].l_mult*level_ups)

                SMODS.upgrade_poker_hands({hands = context.scoring_name, level_up = -level_ups, from = card})

                return {
                    message = localize("death_star_destroy"),
                    colour = G.C.RED,
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
            }
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'win_custom' then
            for handname, _ in pairs(G.GAME.hands) do
                if G.GAME.hands[handname].level>1 then
                    return false
                end
            end
            return true
        end
        return false
    end,
}

-- Infrastructure
SMODS.Joker {
    key = "infrastructure",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 5 },
    -- amount is unused
    config = { extra = { amount = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local valid_enhance_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not next(SMODS.get_enhancements(playing_card)) and not playing_card.getting_sliced then
                    valid_enhance_cards[#valid_enhance_cards + 1] = playing_card
                end
            end
            local enhance_card = pseudorandom_element(valid_enhance_cards, 'cod_infrastructure')
            if enhance_card then
                draw_card(G.deck, G.play, 90, 'up', nil, enhance_card)

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        return true
                    end
                }))

                -- bug: to stone animation instantly removes rank and suit
                local random_enhancement = SMODS.poll_enhancement {key = "cod_infrastructure", guaranteed = true}
                enhance_card:set_ability(random_enhancement, nil, true)

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        return true
                    end
                }))

                draw_card(G.play, G.deck, 90, 'up', nil, enhance_card)
                
                return {
                    message = localize('infrastructure_build'),
                    colour = G.C.GOLD,
                }
            end

        end
    end
}

-- Printer
SMODS.Joker {
    key = "printer",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 5 },
    config = { extra = { rank = "Ace", suit = "Hearts" } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.rank, 'ranks'), localize(card.ability.extra.suit, 'suits_plural'), colours = { G.C.SUITS[card.ability.extra.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            
            local printer_card = SMODS.create_card { set = "Base", suit = card.ability.extra.suit, rank = card.ability.extra.rank, area = G.discard }
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            printer_card.playing_card = G.playing_card
            table.insert(G.playing_cards, printer_card)

            G.E_MANAGER:add_event(Event({
                func = function()
                    printer_card:start_materialize()
                    G.play:emplace(printer_card)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 1,
                func = function()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    return true
                end
            }))

            draw_card(G.play, G.deck, 90, 'up', nil, printer_card)

            SMODS.calculate_context({ playing_card_added = true, cards = { printer_card } })
            return {
                message = localize('printer_print'),
                colour = G.C.GOLD,
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, 'cod_printer_suit').key
        card.ability.extra.rank = pseudorandom_element(SMODS.Ranks, 'cod_printer_rank').key
    end
}

-- Dyson Sphere
SMODS.Joker {
    key = "dyson_sphere",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 5 },
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_dyson_sphere')
        return { vars = { numerator, denominator} }
    end,
}

local level_up_hand_ref = level_up_hand
function level_up_hand(card, hand, instant, amount)
    local _, dyson = next(SMODS.find_card('j_cod_dyson_sphere'))
    if dyson and (not amount or amount > 0) then
        local most_played_hand = nil
        local times_played = -1
        for _, handname in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > times_played then
                most_played_hand = handname
                times_played = G.GAME.hands[handname].played
            end
        end
        if hand ~= most_played_hand and SMODS.pseudorandom_probability(dyson, 'cod_dyson_sphere', 1, dyson.ability.extra.odds) then
            SMODS.calculate_effect({message = localize("dyson_sphere_redirect")}, dyson)
            hand = most_played_hand
        end
    end
    level_up_hand_ref(card, hand, instant, amount)
end

-- Stellar Void
SMODS.Joker {
    key = "stellar_void",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 5 },
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)
        local unplayed = 0
        for _, hand in pairs(G.GAME.hands) do
            if hand.played == 0 then
                unplayed = unplayed + 1
            end
        end

        return { vars = { card.ability.extra.mult, unplayed*card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local unplayed = 0
            for _, hand in pairs(G.GAME.hands) do
                if hand.played == 0 then
                    unplayed = unplayed + 1
                end
            end
            return {
                mult = unplayed * card.ability.extra.mult,
            }
        end
    end,
    in_pool = function(self, args)
        for handname, hand in pairs(G.GAME.hands) do
            if G.GAME.hands[handname].played == 0 then
                return true
            end
        end
        return false
    end,
}

-- Stellar Cluster
SMODS.Joker {
    key = "stellar_cluster",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 5 },
    config = { extra = { mult = 2 } },
    loc_vars = function(self, info_queue, card)
        local played = 0
        for _, hand in pairs(G.GAME.hands) do
            if hand.played > 0 then
                played = played + 1
            end
        end

        return { vars = { card.ability.extra.mult, played*card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local played = 0
            for _, hand in pairs(G.GAME.hands) do
                if hand.played > 0 then
                    played = played + 1
                end
            end
            return {
                mult = played * card.ability.extra.mult,
            }
        end
    end,
}

-- Taxes
SMODS.Joker {
    key = "taxes",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 5 },
    config = { extra = { mult = 1, cap = 30 } },
    loc_vars = function(self, info_queue, card)
        local played = 0
        for _, hand in pairs(G.GAME.hands) do
            if hand.played > 0 then
                played = played + 1
            end
        end

        return { vars = { card.ability.extra.mult, card.ability.extra.cap, math.max(0, card.ability.extra.cap - (G.GAME.dollars*card.ability.extra.mult)) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if context.joker_main then
                return {
                    mult = math.max(0, card.ability.extra.cap - (G.GAME.dollars*card.ability.extra.mult))
                }
            end
        end
    end,
}

-- Knockoff
SMODS.Joker {
    key = "knockoff",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 6 },
    config = {},
    loc_vars = function(self, info_queue, card)
        if card.area and card.area == G.jokers then
            local lowest_cost = nil
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card and (not lowest_cost or (lowest_cost and G.jokers.cards[i].sell_cost<lowest_cost)) then
                    lowest_cost = G.jokers.cards[i].sell_cost
                    other_joker = G.jokers.cards[i]
                end
            end
            local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
            main_end = {
                {
                    n = G.UIT.C,
                    config = { align = "bm", minh = 0.4 },
                    nodes = {
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
                    }
                }
            }
            return { main_end = main_end }
        end
    end,
    calculate = function(self, card, context)
        local lowest_cost = nil
        local other_joker = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] ~= card and (not lowest_cost or (lowest_cost and G.jokers.cards[i].sell_cost<lowest_cost)) then
                lowest_cost = G.jokers.cards[i].sell_cost
                other_joker = G.jokers.cards[i]
            end
        end
        local ret = SMODS.blueprint_effect(card, other_joker, context)
        if ret then
            ret.colour = G.C.GOLD
        end
        return ret
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_custom'
    end
}

-- Gambler
SMODS.Joker {
    key = "gambler",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 6 },
    config = { extra = { mult = 0, mult_gain = 3, odds = 8 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_gambler')
        return { vars = { numerator, denominator, card.ability.extra.mult, card.ability.extra.mult_gain, } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == "High Card" then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                if SMODS.pseudorandom_probability(card, 'cod_gambler', 1, card.ability.extra.odds) then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        colour = G.C.RED,
                        message = localize('gambler_ruined'),
                    }
                else
                    return {
                        colour = G.C.RED,
                        message = localize('gambler_win'),
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Stone Tablet
SMODS.Joker {
    key = "stone_tablet",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 6 },
    pixel_size = { h = 82 },
    config = { extra = { odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_stone_tablet')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_no_rank(context.other_card) and not context.other_card.seal then
                if SMODS.pseudorandom_probability(card, 'cod_stone_tablet', 1, card.ability.extra.odds) then
                    local random_seal = pseudorandom_element({'Red', 'Purple', 'Blue', 'Gold'}, pseudoseed('cod_stone_tablet_seal'))
                    context.other_card:set_seal(random_seal)
                    return {
                        message = localize("stone_tablet_upgrade"),
                        colour = G.C.RED,
                    }
                end
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_rank(playing_card) then
                return true
            end
        end
        return false
    end,
}

-- Sector Map
SMODS.Joker {
    key = "sector_map",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 6 },
        calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if next(context.poker_hands["Straight Flush"]) or next(context.poker_hands["Full House"]) or next(context.poker_hands["Flush"]) or next(context.poker_hands["Straight"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Five of a Kind"]) then
                local five_hands = {"Straight Flush", "Full House", "Flush", "Straight"}
                local hidden_hands = {"Flush House", "Flush Five", "Five of a Kind"}
                for _, v in ipairs(hidden_hands) do
                    if SMODS.is_poker_hand_visible(v) then
                        five_hands[#five_hands+1] = v
                    end
                end
                local chosen_hand = pseudorandom_element(five_hands, 'cod_sector_map')
                local planet = nil
                for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == chosen_hand then
                        planet = v.key
                    end
                end

                if planet then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card {
                                set = 'Planet',
                                key = planet,
                                key_append = 'cod_sector_map'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = localize('k_plus_planet'),
                        colour = G.C.SECONDARY_SET.Planet
                    }
                end
            end
        end
    end,
}

-- completely repurpused for blueprint effect because we need more copy jokers
SMODS.Joker {
    key = "coloring",
    rarity = 2,
    pos = { x = 5, y = 7 },
    atlas = "atlas_cod_jokers",
    config = {
        extra = {
            spectrum_played = false,
        }
    },
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,

  loc_vars = function(self, info_queue, card)
    if card.area and card.area == G.jokers then
      local other_joker = nil
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
      end

      local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
      local main_end = {
        {
          n = G.UIT.C,
          config = { align = "bm", minh = 0.4 },
          nodes = {
            {
              n = G.UIT.C,
              config = { ref_table = card, align = "m", colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8) or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8), r = 0.05, padding = 0.06 },
              nodes = {
                { n = G.UIT.T, config = { text = ' ' .. localize('k_' .. (compatible and 'compatible' or 'incompatible')) .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
              }
            }
          }
        }
      }

      local text = nil
      if card.ability.extra.spectrum_played then
        text = localize('k_active_ex')
      else
        text = localize('k_inactive_ex')
      end

      return { vars = {text}, main_end = main_end }
    end
  end,

  calculate = function(self, card, context)
    local other_joker = nil
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
    end

    if context.ante_end then
        card.ability.extra.spectrum_played = false
    end

    if context.before then
        for key, value in pairs(context.poker_hands) do
            if key == "bunc_Spectrum" then
                card.ability.extra.spectrum_played = true
            end
        end
    end

    if card.ability.extra.spectrum_played then
        return SMODS.blueprint_effect(card, other_joker, context)
    end
  end
}

-- Connect the Dots
SMODS.Joker {
    key = "connect_the_dots",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 7 },
    config = { extra = { rank = 2, dollars = 1 } },
    loc_vars = function(self, info_queue, card)
        local rank
        for k, v in pairs(SMODS.Ranks) do
            if v.id == card.ability.extra.rank then
                rank = v
            end
        end
        return { vars = { card.ability.extra.dollars, localize(rank.key, 'ranks') } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == card.ability.extra.rank then
            card.ability.extra.rank = card.ability.extra.rank - 1
            if card.ability.extra.rank < 2 then
                card.ability.extra.rank = 14
            end
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
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.rank = pseudorandom('cod_connect_the_dots', 2, 14)
    end
}

-- Mult Joker
SMODS.Joker {
    key = "mult",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 7 },
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_mult') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_mult') then
                return true
            end
        end
        return false
    end
}

-- Tornado
SMODS.Joker {
    key = "tornado",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 8 },
    config = { extra = { h_size = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    calculate = function(self, card, context)
        if context.press_play and not context.blueprint and #G.hand.cards > 0 then
            -- track undiscarded cards, block other discard effects
            local tornado_cards = {}
            for _, playing_card in pairs(G.hand.cards) do
                if not playing_card.ability.discarded then
                    tornado_cards[#tornado_cards+1] = playing_card
                    playing_card.ability.discarded = true
                end
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    -- unblock this discard
                    for _, playing_card in pairs(tornado_cards) do
                        playing_card.ability.discarded = false
                    end
                    G.hand:unhighlight_all()
                    local prev_limit = G.hand.config.highlighted_limit
                    G.hand.config.highlighted_limit = #G.hand.cards
                    local any_selected = nil
                    for _, playing_card in ipairs(G.hand.cards) do
                        G.hand:add_to_highlighted(playing_card, true)
                        any_selected = true
                    end
                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                    G.hand.config.highlighted_limit = prev_limit
                    return true
                end
            }))
            return {
                message = localize("tornado_swish"),
                colour = G.C.GREY,
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 100, G.PROFILES[G.SETTINGS.profile].career_stats.c_cards_discarded or 0 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and args.statname == 'c_cards_discarded' then
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 100
        end
        return false
    end
}

-- Moai
SMODS.Joker {
    key = "moai",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 7 },
    config = { extra = { rank = "King", suit = "Hearts" } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return { vars = { localize(card.ability.extra.rank, 'ranks'), localize(card.ability.extra.suit, 'suits_plural'), colours = { G.C.SUITS[card.ability.extra.suit] } } }
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.suit = pseudorandom_element(SMODS.Suits, 'cod_moai_suit').key
        card.ability.extra.rank = pseudorandom_element({"King", "Queen", "Jack"}, 'cod_moai_face')
    end,
}

-- moai hooks
local no_suit_ref = SMODS.has_no_suit
function SMODS.has_no_suit(card)
    if SMODS.has_enhancement(card, 'm_stone') and next(SMODS.find_card('j_cod_moai')) then
        return false
    end
    return no_suit_ref(card)
end

local no_rank_ref = SMODS.has_no_rank
function SMODS.has_no_rank(card)
    if SMODS.has_enhancement(card, 'm_stone') and next(SMODS.find_card('j_cod_moai')) then
        return false
    end
    return no_rank_ref(card)
end

local is_suit_ref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if SMODS.has_enhancement(self, 'm_stone') then
        local _, moai = next(SMODS.find_card('j_cod_moai'))
        if moai then
            if moai_smeared_check(moai, suit) then
                return true
            end
            return moai.ability.extra.suit == suit
        end
    end
    return is_suit_ref(self, suit, bypass_debuff, flush_calc)
end

local get_id_ref = Card.get_id
function Card:get_id()
    if SMODS.has_enhancement(self, 'm_stone') then
        local _, moai = next(SMODS.find_card('j_cod_moai'))
        if moai then
            return SMODS.Ranks[moai.ability.extra.rank].id
        end
    end
    return get_id_ref(self)
end

function moai_smeared_check(moai, suit)
    if not next(find_joker('Smeared Joker')) then
        return false
    end

    if ((moai.ability.extra.suit == 'Hearts' or moai.ability.extra.suit == 'Diamonds') and (suit == 'Hearts' or suit == 'Diamonds')) then
        return true
    elseif (moai.ability.extra.suit == 'Spades' or moai.ability.extra.suit == 'Clubs') and (suit == 'Spades' or suit == 'Clubs') then
        return true
    end
    return false
end

local is_face_ref = Card.is_face
function Card:is_face(from_boss)
    if not self.debuff and SMODS.has_enhancement(self, 'm_stone') and next(SMODS.find_card('j_cod_moai')) then
        return true
    end
    return is_face_ref(self, from_boss)
end

-- Cryptogram
SMODS.Joker {
    key = "cryptogram",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 8 },
    config = { extra = { h_size = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.h_size)
    end,
    calculate = function(self, card, context)
        if context.stay_flipped and context.to_area == G.hand and not context.blueprint and
            G.GAME.current_round.hands_played == 0 and G.GAME.current_round.discards_used == 0 then
            return {
                stay_flipped = true
            }
        end
    end
}

-- Gold Bar
SMODS.Joker {
    key = "gold_bar",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 7 },
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_gold') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) and SMODS.has_enhancement(context.other_card, 'm_gold') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end
}

-- Eldritch Joker
SMODS.Joker {
    key = "eldritch",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 9 },
}

-- Jimboel
SMODS.Joker {
    key = "jimboel",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 9 },
    config = { extra = { xmult_mod = 0.5, base_xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.base_xmult + card.ability.extra.xmult_mod * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.base_xmult + card.ability.extra.xmult_mod * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) } },
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.base_xmult + card.ability.extra.xmult_mod * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)
            }
        end
    end
}

local poker_hands_ordered = {"High Card", "Pair", "Two Pair", "Three of a Kind", "Straight", "Flush", "Full House", "Four of a Kind", "Straight Flush", "Five of a Kind", "Flush House", "Flush Five"}

-- Ringworld
SMODS.Joker {
    key = "ringworld",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 9 },
    config = { extra = { poker_hand = 'High Card' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            local hand_changed = false
            local passed = false
            for i=1,#poker_hands_ordered do
                local handname = poker_hands_ordered[i]
                if handname == card.ability.extra.poker_hand then
                    passed = true
                elseif passed and SMODS.is_poker_hand_visible(handname) then
                    card.ability.extra.poker_hand = handname
                    hand_changed = true
                    break
                end
            end
            if not hand_changed then
                card.ability.extra.poker_hand = "High Card"
            end
            return {
                level_up = 2,
                message = localize('k_level_up_ex')
            }
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for handname, _ in pairs(G.GAME.hands) do
            if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                _poker_hands[#_poker_hands + 1] = handname
            end
        end
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'cod_ringworld')
    end
}

-- Marshmallow
SMODS.Joker {
    key = "marshmallow",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 9 },
    config = { extra = { xmult = 3, loses = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.loses } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and SMODS.last_hand_oneshot then
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.loses

            if card.ability.extra.xmult <= 1 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('marshmallow_burnt')
                }
            else
                return {
                    message = "-X0.5",
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Orson
SMODS.Joker {
    key = "orson",
    unlocked = true,
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 9 },
    soul_pos = { x = 9, y = 9 },
}

-- Audience
SMODS.Joker {
    key = "audience",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 10 },
    config = { extra = { mult = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult }}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local rank_tally = 0
            for _, playing_card in ipairs(G.deck.cards) do
                if context.other_card:get_id() == playing_card:get_id() then rank_tally = rank_tally + card.ability.extra.mult end
            end
            return {
                mult = rank_tally
            }
        end
    end
}

-- Piggy Bank
SMODS.Joker {
    key = "piggy_bank",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 10 },
    config = { extra = { dollars = 6, immune = true }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars }}
    end,
    calculate = function(self, card, context)
        if context.buying_self then
            card.ability.extra.immune = true
            G.E_MANAGER:add_event(Event({
                func = function()
                    card.ability.extra.immune = false
                    return true
                end
            }))
        end
        if context.money_altered and not context.blueprint and context.amount < 0 and not card.ability.extra.immune then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize('piggy_bank_break')
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}

-- Pillars
SMODS.Joker {
    key = "pillars",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 10 },
    config = { extra = { mult = 0, mult_gain = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult }}
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            
            local lowest_plays = nil
            for handname, hand in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) then
                    if not lowest_plays then
                        lowest_plays = hand.played
                    elseif lowest_plays > hand.played then
                        lowest_plays = hand.played
                    end
                    
                end
            end

            if (G.GAME.hands[context.scoring_name].played <= lowest_plays+1) then

                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

-- Sequel
SMODS.Joker {
    key = "sequel",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 10 },
    config = { extra = { repetitions = 1 }},
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card ~= context.scoring_hand[1] then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
}

-- Preserved Insect
SMODS.Joker {
    key = "preserved_insect",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 10 },
    config = { extra = { big_xmult = 1.5, boss_xmult = 2 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.big_xmult, card.ability.extra.boss_xmult }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			if G.GAME.blind.name == "Big Blind" then
                return {
                    xmult = card.ability.extra.big_xmult
                }
            end
            if G.GAME.blind.name ~= "Small Blind" and G.GAME.blind.name ~= "Big Blind" then
                return {
                    xmult = card.ability.extra.boss_xmult
                }
            end
        end
    end,
}

-- Armory
SMODS.Joker {
    key = "armory",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 10 },
    config = { extra = { mult = 1 }},
    loc_vars = function(self, info_queue, card)
        local spade_tally = 0
        if G.deck then
            for _, playing_card in ipairs(G.deck.cards) do
                if playing_card:is_suit("Spades") then spade_tally = spade_tally + card.ability.extra.mult end
            end
        end
        return { vars = { card.ability.extra.mult, spade_tally }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local spade_tally = 0
            for _, playing_card in ipairs(G.deck.cards) do
                if playing_card:is_suit("Spades") then spade_tally = spade_tally + card.ability.extra.mult end
            end
            return {
                mult = spade_tally
            }
        end
    end,
}

-- Compost
SMODS.Joker {
    key = "compost",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 11 },
    config = { extra = { mult_gain = 2, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and
            not context.other_card.debuff and
            context.other_card:is_suit("Clubs") then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                colour = G.C.RED,
                delay = 0.45
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.mult > 0 then
            card.ability.extra.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

-- Red Joker
SMODS.Joker {
    key = "red_joker",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 11 },
    config = { extra = { mult_gain = 3, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and G.GAME.current_round.hands_left == 0 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

-- Gold Ore
SMODS.Joker {
    key = "gold_ore",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 8 },
    config = { extra = { chips = 25, dollars = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_no_rank(context.other_card) or SMODS.has_enhancement(context.other_card, 'm_gold') then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
                return {
                    chips = card.ability.extra.chips,
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
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_rank(playing_card) or SMODS.has_enhancement(playing_card, 'm_gold') then
                return true
            end
        end
        return false
    end
}

-- Hired Hand
SMODS.Joker {
    key = "hired_hand",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 11 },
    config = { extra = { dollars = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calc_dollar_bonus = function(self, card)
        return G.GAME.current_round.hands_left * card.ability.extra.dollars
    end
}

-- Artifact
SMODS.Joker {
    key = "artifact",
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 11 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_negative', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_negative' } } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_negative'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return {
                message = localize('cod_artifact_activate'),
                colour = G.C.RED,
            }
        end
    end,
}

-- Socialite
SMODS.Joker {
    key = "socialite",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 12 },
    config = { extra = { xmult = 0.05 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_face() then
            context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 0) + card.ability.extra.xmult
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
}

--  Unused art:
-- Fortunate Joker
-- Black Market
-- Chromatic Aberration
-- Noise
-- Secret hand xmult