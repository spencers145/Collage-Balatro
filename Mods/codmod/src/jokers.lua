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
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 0 },
    config = { extra = { from_suit = "Clubs", to_suit = "Hearts", from_color = G.C.SUITS.Clubs, to_color = G.C.SUITS.Hearts} },
    loc_vars = season_loc_vars,
    calculate = season_calculate,
}

-- Fall
SMODS.Joker {
    key = "fall",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 0 },
    config = { extra = { from_suit = "Hearts", to_suit = "Spades", from_color = G.C.SUITS.Hearts, to_color = G.C.SUITS.Spades} },
    loc_vars = season_loc_vars,
    calculate = season_calculate,
}

-- Winter
SMODS.Joker {
    key = "winter",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 0 },
    config = { extra = { from_suit = "Spades", to_suit = "Diamonds", from_color = G.C.SUITS.Spades, to_color = G.C.SUITS.Diamonds} },
    loc_vars = season_loc_vars,
    calculate = season_calculate,
}

-- Spring
SMODS.Joker {
    key = "spring",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 0 },
    config = { extra = { from_suit = "Diamonds", to_suit = "Clubs", from_color = G.C.SUITS.Diamonds, to_color = G.C.SUITS.Clubs} },
    loc_vars = season_loc_vars,
    calculate = season_calculate,
}

-- Four Seasons
SMODS.Joker {
    key = "four_seasons",
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 0 },
    config = {},
    calculate = function(self, card, context)
        if context.before then
            local convert = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if not SMODS.has_no_suit(scored_card) and not scored_card.debuff then
                    convert = true
                    local suits = {"Hearts", "Spades", "Diamonds", "Clubs", "Hearts"}
                    for i=1,4 do
                        if scored_card.base.suit == suits[i] then
                            assert(SMODS.change_base(scored_card, suits[i+1]))
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    scored_card:juice_up()
                                    return true
                                end
                                
                            }))
                            break
                        end
                    end
                end
            end
            if convert then
                return {
                    message = localize('season_convert'),
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then

            if G.P_CENTERS["j_cod_winter"].discovered and G.P_CENTERS["j_cod_spring"].discovered and G.P_CENTERS["j_cod_summer"].discovered and G.P_CENTERS["j_cod_fall"].discovered then

                return true
            end
            return false
        end
    end
}

-- Suit imbalance cycle

-- Mitosis
SMODS.Joker {
    key = "mitosis",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 3 },
    -- amount is unused
    config = { extra = { amount = 1, suit = "Hearts", color = G.C.SUITS.Hearts} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), colours = { card.ability.extra.color } } }
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
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 3 },
    config = { extra = { amount = 2, suit = "Spades", color = G.C.SUITS.Spades} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), colours = { card.ability.extra.color } } }
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
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 3 },
    config = { extra = { amount = 1, suit = "Diamonds", color = G.C.SUITS.Diamonds} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_singular'), colours = { card.ability.extra.color } } }
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
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 0 },
    -- amount is unused
    config = { extra = { amount = 1, suit = "Clubs", color = G.C.SUITS.Clubs} },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, localize(card.ability.extra.suit, 'suits_plural'), colours = { card.ability.extra.color } } }
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

-- Harmony
SMODS.Joker {
    key = "harmony",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 1,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 3 },
    -- amount is unused
    config = { extra = { amount = 1, mult_gain = 2, mult = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.amount, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.setting_blind then

            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain

            local spades = {}
            local hearts = {}
            local diamonds = {}
            local clubs = {}

            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) and not SMODS.has_any_suit(playing_card) then
                    if playing_card:is_suit("Hearts") then hearts[#hearts + 1] = playing_card end
                    if playing_card:is_suit("Clubs") then clubs[#clubs + 1] = playing_card end
                    if playing_card:is_suit("Spades") then spades[#spades + 1] = playing_card end
                    if playing_card:is_suit("Diamonds") then diamonds[#diamonds + 1] = playing_card end
                end
            end

            if #spades == #hearts and #hearts == #diamonds and #diamonds == #clubs then
                return {
                    message = localize('harmony_balance'),
                    colour = G.C.GOLD,
                }
            end

            local majority = {}

            if #spades >= #hearts and #spades >= #diamonds and #spades >= #clubs then
                for _, v in ipairs(spades) do majority[#majority+1] = v end
            end
            if #hearts >= #spades and #hearts >= #diamonds and #hearts >= #clubs then
                for _, v in ipairs(hearts) do majority[#majority+1] = v end
            end
            if #clubs >= #hearts and #clubs >= #diamonds and #clubs >= #spades then
                for _, v in ipairs(clubs) do majority[#majority+1] = v end
            end
            if #diamonds >= #hearts and #diamonds >= #spades and #diamonds >= #clubs then
                for _, v in ipairs(diamonds) do majority[#majority+1] = v end
            end

            local minority = {}

            if #spades <= #hearts and #spades <= #diamonds and #spades <= #clubs then
                minority[#minority+1] = "Spades"
            end
            if #hearts <= #spades and #hearts <= #diamonds and #hearts <= #clubs then
                minority[#minority+1] = "Hearts"
            end
            if #clubs <= #hearts and #clubs <= #diamonds and #clubs <= #spades then
                minority[#minority+1] = "Clubs"
            end
            if #diamonds <= #hearts and #diamonds <= #spades and #diamonds <= #clubs then
                minority[#minority+1] = "Diamonds"
            end

            local majority_card = pseudorandom_element(majority, 'cod_harmony')
            local minority_suit = pseudorandom_element(minority, 'cod_harmony')

            if majority_card and minority_suit then
                draw_card(G.deck, G.play, 90, 'up', nil, majority_card)

                assert(SMODS.change_base(majority_card, minority_suit, nil, true))

                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        majority_card:set_sprites(nil, majority_card.config.card)
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

                draw_card(G.play, G.deck, 90, 'up', nil, majority_card)
                
                return {
                    message = localize('season_convert'),
                    colour = G.C.GOLD,
                }
            end

        end
    end
}

-- Common Clone
SMODS.Joker {
    key = "common_clone",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 1 },
    config = { extra = { chips = 35, cod_clone = true } },
    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and type(context.other_joker.ability.extra) == "table" and context.other_joker.ability.extra.cod_clone then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

-- Uncommon Clone
SMODS.Joker {
    key = "uncommon_clone",
    unlocked = false,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 1 },
    config = { extra = { mult = 15, cod_clone = true } },
    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and type(context.other_joker.ability.extra) == "table" and context.other_joker.ability.extra.cod_clone then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            local count = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and type(joker.ability.extra) == "table" and joker.ability.extra.cod_clone then
                    count = count + 1
                end
                if count >= 2 then
                    return true
                end
            end
        end
        return false
    end
}

-- Rare Clone
SMODS.Joker {
    key = "rare_clone",
    unlocked = false,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 1 },
    config = { extra = { xmult = 1.5, cod_clone = true } },
    in_pool = function(self, args)
        return true, { allow_duplicates = true }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and type(context.other_joker.ability.extra) == "table" and context.other_joker.ability.extra.cod_clone then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'modify_jokers' and G.jokers then
            local count = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and type(joker.ability.extra) == "table" and joker.ability.extra.cod_clone then
                    count = count + 1
                end
                if count >= 3 then
                    return true
                end
            end
        end
        return false
    end
}

-- Short Joker
SMODS.Joker {
    key = "short",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 2 },
    pixel_size = { h = 56 },
    config = { extra = { chips = 75, max_sum = 25 } },
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

-- All-Seeing Joker
SMODS.Joker {
    key = "all_seeing",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 3,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 1 },
    config = { extra = { pack_h_size = 3, active = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pack_h_size } }
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.active then
            card.ability.extra.active = false
            G.hand:change_size(-card.ability.extra.pack_h_size)
        end
    end,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint and not card.ability.extra.active then
            G.hand:change_size(card.ability.extra.pack_h_size)
            card.ability.extra.active = true

            return {
                message = localize('all_seeing_pack'),
                colour = G.C.RED,
            }
        end
        if context.ending_booster and not context.blueprint and card.ability.extra.active then
            card.ability.extra.active = false
            G.hand:change_size(-card.ability.extra.pack_h_size)
        end
    end
}

-- Resourceful Joker
SMODS.Joker {
    key = "resourceful",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 1 },
    config = { extra = { pack_size = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pack_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if not G.GAME.modifiers.booster_size_mod then
            G.GAME.modifiers.booster_size_mod = 0
        end
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod + card.ability.extra.pack_size
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not G.GAME.modifiers.booster_size_mod then
            G.GAME.modifiers.booster_size_mod = 0
        end
        G.GAME.modifiers.booster_size_mod = G.GAME.modifiers.booster_size_mod - card.ability.extra.pack_size
    end,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            return {
                message = localize('resourceful_pack'),
                colour = G.C.GOLD,
            }
        end
    end
}

-- Scavenging Joker
SMODS.Joker {
    key = "scavenging",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 1 },
    config = { extra = { pack_choices = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.pack_choices } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if not G.GAME.modifiers.booster_choice_mod then
            G.GAME.modifiers.booster_choice_mod = 0
        end
        G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod + card.ability.extra.pack_choices
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not G.GAME.modifiers.booster_choice_mod then
            G.GAME.modifiers.booster_choice_mod = 0
        end
        G.GAME.modifiers.booster_choice_mod = G.GAME.modifiers.booster_choice_mod - card.ability.extra.pack_choices
    end,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint then
            return {
                message = localize('resourceful_pack'),
                colour = G.C.GOLD,
            }
        end
    end
}

-- Bully
SMODS.Joker {
    key = "bully",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 1 },
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			if G.GAME.blind.name == "Small Blind" then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Scam
SMODS.Joker {
    key = "scam",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 21,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 1 },
    config = { extra = { xmult = 1.1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end,
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
--     unlocked = false,
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
    unlocked = false,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 0 },
    config = { extra = { xmult = 1 } },
    loc_vars = function(self, info_queue, card)
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

        return { vars = { card.ability.extra.xmult, 1 + card.ability.extra.xmult * lowest_plays } }
    end,
    
    calculate = function(self, card, context)
        if context.joker_main then
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
            return {
                xmult = 1 + card.ability.extra.xmult * lowest_plays
            }
        end
    end,

    check_for_unlock = function(self, args)
        if args.type == 'hand_contents' then
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
            return lowest_plays >= 3
        end
    end
}

-- Anchor
SMODS.Joker {
    key = "anchor",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 1 },
    config = { extra = { suit = "Spades", color = G.C.SUITS.Spades } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.suit, 'suits_singular'), colours = { card.ability.extra.color } } }
    end,
    calculate = function(self, card, context)
        if context.round_shuffle and not context.blueprint then
            local suit_cards = {}
            local non_suit_cards = {}
            for _, playing_card in ipairs(G.deck.cards) do
                if playing_card:is_suit(card.ability.extra.suit) then
                    suit_cards[#suit_cards + 1] = playing_card
                else
                    non_suit_cards[#non_suit_cards + 1] = playing_card
                end
            end
            for _, non_suit_card in ipairs(non_suit_cards) do
                suit_cards[#suit_cards + 1] = non_suit_card
            end
            G.deck.cards = suit_cards

            return {
                message = localize("anchor_sink"),
                colour = card.ability.extra.color,
            }
        end
    end
}

-- Faster than light
SMODS.Joker {
    key = "faster_than_light",
    unlocked = false,
    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 2 },
    config = { extra = { anti_ante = 1, skips = 3, skip_counter = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.anti_ante, card.ability.extra.skips + (G.GAME.cod_faster_than_light_penalty or 0), card.ability.extra.skip_counter } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            card.ability.extra.skip_counter = card.ability.extra.skip_counter + 1
            if card.ability.extra.skip_counter >= card.ability.extra.skips + (G.GAME.cod_faster_than_light_penalty or 0) then

                ease_ante(-card.ability.extra.anti_ante)
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
                G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.anti_ante
                
                card.ability.extra.skip_counter = 0
                G.GAME.cod_faster_than_light_penalty = G.GAME.cod_faster_than_light_penalty or 0
                G.GAME.cod_faster_than_light_penalty = G.GAME.cod_faster_than_light_penalty + 1

                -- Refresh big blind and boss blind to show correct chips requirements
                -- no idea what this code does, got it from reroll tag logic
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.3,
                    func = (function()

                        local par_big = G.blind_select_opts.big.parent
                        G.blind_select_opts.big:remove()
                        G.blind_select_opts.big = UIBox{
                        T = {par_big.T.x, 0, 0, 0, },
                        definition =
                            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                            UIBox_dyn_container({create_UIBox_blind_choice('Big')},false,get_blind_main_colour('Big'), mix_colours(G.C.BLACK, get_blind_main_colour('Big'), 0.8))
                            }},
                        config = {align="bmi",
                                    offset = {x=0,y=G.ROOM.T.y + 9},
                                    major = par_big,
                                    xy_bond = 'Weak'
                                }
                        }
                        par_big.config.object = G.blind_select_opts.big
                        par_big.config.object:recalculate()
                        G.blind_select_opts.big.parent = par_big
                        G.blind_select_opts.big.alignment.offset.y = 0

                        local par_boss = G.blind_select_opts.boss.parent
                        G.blind_select_opts.boss:remove()
                        G.blind_select_opts.boss = UIBox{
                        T = {par_boss.T.x, 0, 0, 0, },
                        definition =
                            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                            UIBox_dyn_container({create_UIBox_blind_choice('Boss')},false,get_blind_main_colour('Boss'), mix_colours(G.C.BLACK, get_blind_main_colour('Boss'), 0.8))
                            }},
                        config = {align="bmi",
                                    offset = {x=0,y=G.ROOM.T.y + 9},
                                    major = par_boss,
                                    xy_bond = 'Weak'
                                }
                        }
                        par_boss.config.object = G.blind_select_opts.boss
                        par_boss.config.object:recalculate()
                        G.blind_select_opts.boss.parent = par_boss
                        G.blind_select_opts.boss.alignment.offset.y = 0

                        return true
                    end)
                }))

                G.E_MANAGER:add_event(Event({
                    func = function()
                        save_run()
                        return true
                    end
                }))

                return {
                    message = localize("faster_than_light_jump"),
                    colour = G.C.GOLD,
                }
            else
                return {
                    message = localize("faster_than_light_charge"),
                    colour = G.C.GOLD,
                }
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10, G.PROFILES[G.SETTINGS.profile].career_stats.c_blinds_skipped or 0 } }
    end,
    check_for_unlock = function(self, args)
        if args.type == 'career_stat' and args.statname == 'c_blinds_skipped' then
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 10
        end
        return false
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

-- Paperclip
SMODS.Joker {
    key = "paperclip",
    unlocked = true,
    blueprint_compat = true,
    cod_confidential_compat = false,
    cod_envy_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 2 },
    config = { extra = { mult = 8, cod_paperclip = true, just_transformed = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blind.boss and not card.ability.extra.just_transformed and not context.blueprint then
            local destructable_jokers = {}
            for i = 1, #G.jokers.cards do
                if not (type(G.jokers.cards[i].ability.extra) == "table" and G.jokers.cards[i].ability.extra.cod_paperclip) and not SMODS.is_eternal(G.jokers.cards[i], card) and not G.jokers.cards[i].getting_sliced then
                    destructable_jokers[#destructable_jokers + 1] = G.jokers.cards[i]
                end
            end
            local joker_to_destroy = pseudorandom_element(destructable_jokers, 'cod_paperclip')

            if joker_to_destroy then
                joker_to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        (context.blueprint_card or card):juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    func = function()
                        local copied_joker = copy_card(card, nil, nil, nil, nil)
                        copied_joker:start_materialize()
                        copied_joker:add_to_deck()
                        copied_joker.ability.extra.just_transformed = true
                        G.jokers:emplace(copied_joker)
                        return true
                    end
                }))

                -- message idea: output the percentage of jokers that are paperclips, if all are: "Task Complete"
                return { message = localize("paperclip_copy") }
            end

        end
        card.ability.extra.just_transformed = false

        if context.joker_main then
			return {
                mult = card.ability.extra.mult
            }
        end
    end,
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

-- Elitist Joker
SMODS.Joker {
    key = "elitism",
    unlocked = false,
    blueprint_compat = false,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 2 },
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_cod_average'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_cod_average' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_cod_average')>0 and true
    end
}


-- Clemens
SMODS.Joker {
    key = "clemens",
    unlocked = false,
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 10 },
    soul_pos = { x = 9, y = 10 },
    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint and card ~= context.card then
            local key_to_ban = context.card.config.center.key

            G.GAME.banned_keys[key_to_ban] = true

            return {
                message = localize("clemens_ban"),
                colour = G.C.RED,
            }
        end
    end
}

-- Spam
SMODS.Joker {
    key = "spam",
    blueprint_compat = true,
    rarity = 1,
    cost = 3,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    config = { extra = { spam_cards = 2 } },
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
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 3 },
    config = { extra = { hands = 1, poker_hand = "High Card"} },
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

-- Unlucky joker
SMODS.Joker {
    key = "unlucky",
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 4 },
    config = { extra = { odds = 2, chips = 0, chips_mod = 3 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_unlucky')
        return { vars = { numerator, denominator, card.ability.extra.chips, card.ability.extra.chips_mod, } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, 'cod_unlucky', 1, card.ability.extra.odds) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
        if context.pseudorandom_result and not context.blueprint and not context.result then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS,
            }
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

-- Stargazer
SMODS.Joker {
    key = "stargazer",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 4 },
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Planet',
                                key_append = 'cod_stargazer'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
    end,
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
    unlocked = false,
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
    unlocked = false,
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
    rarity = 1,
    cost = 4,
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

-- The Sun
SMODS.Joker {
    key = "the_sun",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 5 },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and not context.blueprint then
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
                { handname = localize('k_all_hands'), chips = '...', mult = '...', level = '' })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = true
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { mult = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    return true
                end
            }))
            update_hand_text({ delay = 0 }, { chips = '+', StatusText = true })
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.9,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.8, 0.5)
                    G.TAROT_INTERRUPT_PULSE = nil
                    return true
                end
            }))
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.9, delay = 0 }, { level = '+1' })
            delay(1.3)
            SMODS.upgrade_poker_hands({ instant = true })
            update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
                { mult = 0, chips = 0, handname = '', level = '' })
            return {
                message = localize('sun_upgrade'),
                colour = G.C.RED
            }
        end
    end,
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

-- Shackles
SMODS.Joker {
    key = "shackles",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 1,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 5 },
    config = { card_limit = 1, extra = { xmult = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 1, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end,
}

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
    config = { extra = { mult = 1, cap = 25 } },
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

-- Delivery
SMODS.Joker {
    key = "delivery",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 6 },
    config = { extra = { dollars = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
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

-- Coin Toss
SMODS.Joker {
    key = "coin_toss",
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 1,
    cost = 1,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 6 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_coin_toss')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if context.scoring_name == "High Card" then
                card.ability.extra_value = card.ability.extra_value + card.sell_cost
                card:set_cost()
                if SMODS.pseudorandom_probability(card, 'cod_coin_toss', 1, card.ability.extra.odds) then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        colour = G.C.RED,
                        message = localize('coin_toss_tails'),
                    }
                else
                    return {
                        colour = G.C.GOLD,
                        message = localize('coin_toss_heads'),
                    }
                end
            end
        end
    end
}

-- Oops! All 1s
SMODS.Joker {
    key = "oops_all_1s",
    unlocked = true,
    blueprint_compat = true,
    perishable_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 6 },
    config = { extra = { mult = 0, mult_gain = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult} }
    end,
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                denominator = context.denominator * 2
            }
        end
        if context.pseudorandom_result and not context.blueprint and context.result then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

-- Call of the Void
SMODS.Joker {
    key = "call_of_the_void",
    unlocked = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 6 },
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'Spectral',
                                key_append = 'cod_call_of_the_void'
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true
        end
        if context.check_eternal and context.trigger.from_sell and context.other_card.area == G.consumeables then
            return {
                no_destroy = { override_compat = true }
            }
        end
    end,
}

-- Stone Tablet
SMODS.Joker {
    key = "stone_tablet",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 6 },
    pixel_size = { h = 82 },
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'cod_stone_tablet')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') and not context.other_card.seal then
                if SMODS.pseudorandom_probability(card, 'cod_stone_tablet', 1, card.ability.extra.odds) then
                    local random_seal = SMODS.poll_seal {key = "cod_stone_tablet", guaranteed = true}
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
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,
}

-- Globe
SMODS.Joker {
    key = "globe",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 2,
    atlas = 'atlas_cod_jokers',
    pos = { x = 7, y = 6 },
}

-- hook for straight wrapping
local wrap_around_straight_ref = SMODS.wrap_around_straight
function SMODS:wrap_around_straight()
    if next(SMODS.find_card('j_cod_globe')) then
        return true
    end
    return wrap_around_straight_ref()
end

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

-- Whistleblower
SMODS.Joker {
    key = "whistleblower",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 6 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "cod_confidential", set = 'Other' }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        stickers = {"cod_confidential"},
                        key_append = 'cod_whistleblower',
                        force_stickers = true,
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('whistleblower_leak'),
                colour = G.C.BLUE,
            }
        end
    end,
}

-- Coloring Joker
SMODS.Joker {
    key = "coloring",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 3,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 7 },
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local convert = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.debuff then
                    convert = true
                    local suit = pseudorandom_element({"Hearts", "Diamonds", "Clubs", "Spades"}, 'coloring_suit')
                    assert(SMODS.change_base(scored_card, suit))
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
                    message = localize('coloring_color_in'),
                    colour = pseudorandom_element({G.C.RED, G.C.BLUE, G.C.GREEN, G.C.GOLD, G.C.PURPLE, G.C.SUITS.Spades, G.C.EDITION}, 'coloring_text_color')
                }
            end
        end
    end,
}

-- Rorschach Test
SMODS.Joker {
    key = "rorschach_test",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 8 },
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local convert = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.debuff then
                    local rank_mod = pseudorandom('cod_rorschach_test', 0, 12)
                    if rank_mod > 0 then
                        convert = true
                        assert(SMODS.modify_rank(scored_card, rank_mod))
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
            if convert then
                return {
                    message = localize('rorschach_test_modify'),
                    colour = G.C.UI.TEXT_DARK
                }
            end
        end
    end,
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

-- Bonus Joker
SMODS.Joker {
    key = "bonus",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 7 },
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_bonus') then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_bonus') then
                return true
            end
        end
        return false
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
    unlocked = false,
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
            G.E_MANAGER:add_event(Event({
                func = function()
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

-- Cipher Wheel
SMODS.Joker {
    key = "cipher_wheel",
    unlocked = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 8 },
    pixel_size = { h = 71 },
    config = { extra = { hands = 3, active = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end,
    calculate = function(self, card, context)
        if context.press_play then
            card.ability.extra.active = true
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            card.ability.extra.active = false
        end
        if context.stay_flipped and context.to_area == G.hand and card.ability.extra.active and not context.blueprint then
            return {
                stay_flipped = true
            }
        end
        if context.setting_blind or context.hand_drawn then
            card.ability.extra.active = false
        end
    end
}

-- Penrose Steps
SMODS.Joker {
    key = "penrose_steps",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 8 },
    config = { extra = { steps = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.steps } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local stepped = false
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(playing_card) and not playing_card.getting_sliced then
                    assert(SMODS.modify_rank(playing_card, card.ability.extra.steps))
                    stepped = true
                end
            end

            if stepped then

                return {
                    message = localize('penrose_steps_step'),
                    colour = G.C.BLACK;
                }
            end

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
    config = { extra = { xmult_mod = 0.3, base_xmult = 1 } },
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

-- Versatile
SMODS.Joker {
    key = "versatile",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 9 },
    config = { extra = { chips = 15, mult = 3 } },
    loc_vars = function(self, info_queue, card)
        local left = 0
        local right = 0
        local passed_self = false
        if G.jokers then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    if G.jokers.cards[i] == card then
                        passed_self = true
                    else
                        if passed_self then
                            right = right + 1
                        else
                            left = left + 1
                        end
                    end
                end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, right*card.ability.extra.chips, left*card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local left = 0
            local right = 0
            local passed_self = false
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then
                    if G.jokers.cards[i] == card then
                        passed_self = true
                    else
                        if passed_self then
                            right = right + 1
                        else
                            left = left + 1
                        end
                    end
                end
            end
            return {
                chips = right*card.ability.extra.chips,
                mult = left*card.ability.extra.mult,
            }
        end
    end,
}

-- Book of the Dead
SMODS.Joker {
    key = "book_of_the_dead",
    blueprint_compat = false,
    cod_confidential_compat = false,
    rarity = 2,
    cost = 5,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 9 },
    config = { extra = { poker_hand = 'High Card' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.destroy_card and context.cardarea == G.play and context.scoring_name == card.ability.extra.poker_hand and not context.blueprint and context.destroying_card and G.GAME.current_round.hands_played == 0 then
            if context.destroying_card == context.scoring_hand[1] then
                return {
                    remove = true,
                    message = localize('book_of_the_dead_judge'),
                    colour = G.C.RED,
                }
            else
                return {
                    remove = true,
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local _poker_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if SMODS.is_poker_hand_visible(handname) and handname ~= card.ability.extra.poker_hand then
                    _poker_hands[#_poker_hands + 1] = handname
                end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'cod_book_of_the_dead')
            return {
                message = localize('k_reset')
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
        card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, 'cod_book_of_the_dead')
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

-- Conveyor Belt
SMODS.Joker {
    key = "conveyor_belt",
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 4, y = 9 },
    config = { extra = { hands = 4, force_selects = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands, card.ability.extra.force_selects } }
    end,
    calculate = function(self, card, context)
        if context.hand_drawn and not context.blueprint then

            G.hand:unhighlight_all()
            for _, playing_card in ipairs(G.hand.cards) do
                playing_card.ability.forced_selection = true
                G.hand:add_to_highlighted(playing_card)
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            for _, playing_card in ipairs(G.playing_cards) do
                playing_card.ability.forced_selection = nil
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)

        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.ability.forced_selection = nil
        end
    end,
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
    config = { extra = { xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and SMODS.last_hand_oneshot then
            SMODS.destroy_cards(card, nil, nil, true)
            return {
                message = localize('marshmallow_burnt')
            }
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
    unlocked = false,
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    atlas = 'atlas_cod_jokers',
    pos = { x = 8, y = 9 },
    soul_pos = { x = 9, y = 9 },
}

-- Treasure Map
SMODS.Joker {
    key = "treasure_map",
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 0, y = 10 },
    config = { extra = { treasure = 30, cards = {{rank="Ace",suit="Spades"},{rank="King",suit="Spades"},{rank="Queen",suit="Spades"},{rank="Jack",suit="Spades"},{rank="10",suit="Spades"}} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.cards[1].rank, 'ranks'), localize(card.ability.extra.cards[1].suit, 'suits_plural'), localize(card.ability.extra.cards[2].rank, 'ranks'), localize(card.ability.extra.cards[2].suit, 'suits_plural'), localize(card.ability.extra.cards[3].rank, 'ranks'), localize(card.ability.extra.cards[3].suit, 'suits_plural'), localize(card.ability.extra.cards[4].rank, 'ranks'), localize(card.ability.extra.cards[4].suit, 'suits_plural'), localize(card.ability.extra.cards[5].rank, 'ranks'), localize(card.ability.extra.cards[5].suit, 'suits_plural'), card.ability.extra.treasure, colours = { G.C.SUITS[card.ability.extra.cards[1].suit], G.C.SUITS[card.ability.extra.cards[2].suit], G.C.SUITS[card.ability.extra.cards[3].suit], G.C.SUITS[card.ability.extra.cards[4].suit], G.C.SUITS[card.ability.extra.cards[5].suit] } } }
    end,
    calculate = function(self, card, context)
        if context.before then

            local has_cards = {false, false, false, false, false}
            for i = 1,#context.full_hand do
                for c = 1,5 do
                    if context.full_hand[i]:is_suit(card.ability.extra.cards[c].suit) and context.full_hand[i]:get_id() == SMODS.Ranks[card.ability.extra.cards[c].rank].id then
                        has_cards[c] = true
                    end
                end
            end

            if has_cards[1] and has_cards[2] and has_cards[3] and has_cards[4] and has_cards[5] then

                SMODS.destroy_cards(card, nil, nil, true)

                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.treasure
                
                return {
                    dollars = card.ability.extra.treasure,
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
    set_ability = function(self, card, initial, delay_sprites)
        local cards = {}
        for i=1,5 do
            cards[i] = {}
            cards[i].suit = pseudorandom_element(SMODS.Suits, 'cod_treasure_map_suit').key
            cards[i].rank = pseudorandom_element(SMODS.Ranks, 'cod_treasure_map_rank').key
        end
        card.ability.extra.cards = cards
    end
}

-- Audience
SMODS.Joker {
    key = "audience",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 10 },
    config = { extra = { mult = 1 }},
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

-- Mirror
SMODS.Joker {
    key = "mirror",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 10 },
    calculate = function(self, card, context)
        if context.discard and not context.blueprint and #context.full_hand == 2 and context.other_card == context.full_hand[1] then
            local discard_hand = {}
            discard_hand[1] = context.full_hand[1]
            discard_hand[2] = context.full_hand[2]
            for i = 1, #context.full_hand do
                local percent = 1.15 - (i - 0.999) / (#context.full_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        discard_hand[i]:flip()
                        play_sound('card1', percent)
                        discard_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local rand = pseudorandom("cod_mirror")
                    if rand > 0.5 then
                        copy_card(discard_hand[1], discard_hand[2])
                    else
                        copy_card(discard_hand[2], discard_hand[1])
                    end
                    return true
                end
            }))
            for i = 1, #context.full_hand do
                local percent = 0.85 + (i - 0.999) / (#context.full_hand - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        discard_hand[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        discard_hand[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.5)
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

-- The Rivals
SMODS.Joker {
    key = "the_rivals",
    unlocked = false,
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 1, y = 11 },
    config = { extra = { Xmult = 3, type = 'Two Pair' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { localize('Two Pair', 'poker_hands') } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_no_hand' and G.GAME.hands['Two Pair'].played == 0
    end
}

-- Reverse card
SMODS.Joker {
    key = "reverse_card",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 2, y = 8 },
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                swap = true,
                message = localize("cod_reverse_card_swap"),
                colour = G.C.PURPLE,
            }
        end
    end,
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
            if SMODS.has_enhancement(context.other_card, 'm_stone') or SMODS.has_enhancement(context.other_card, 'm_gold') then
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
            if SMODS.has_enhancement(playing_card, 'm_stone') or SMODS.has_enhancement(playing_card, 'm_gold') then
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

-- Wooden Chest
SMODS.Joker {
    key = "wooden_chest",
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 5, y = 11 },
    config = { extra = { rounds = 0, total_rounds = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            if #G.jokers.cards <= G.jokers.config.card_limit then
                SMODS.add_card({ set = 'Joker', rarity = 'Uncommon' })
                return { message = localize('cod_open_chest') }
            else
                return { message = localize('k_no_room_ex') }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
}

-- Gilded Chest
SMODS.Joker {
    key = "gilded_chest",
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = 'atlas_cod_jokers',
    pos = { x = 6, y = 11 },
    config = { extra = { rounds = 0, total_rounds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.total_rounds, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and (card.ability.extra.rounds >= card.ability.extra.total_rounds) and not context.blueprint then
            if #G.jokers.cards <= G.jokers.config.card_limit then
                SMODS.add_card({ set = 'Joker', rarity = 'Rare' })
                return { message = localize('cod_open_chest') }
            else
                return { message = localize('k_no_room_ex') }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds + 1
            if card.ability.extra.rounds == card.ability.extra.total_rounds then
                local eval = function(card) return not card.REMOVED end
                juice_card_until(card, eval, true)
            end
            return {
                message = (card.ability.extra.rounds < card.ability.extra.total_rounds) and
                    (card.ability.extra.rounds .. '/' .. card.ability.extra.total_rounds) or
                    localize('k_active_ex'),
                colour = G.C.FILTER
            }
        end
    end,
}

-- Huge Joker
SMODS.Joker {
    key = "huge_joker",
    unlocked = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    pos = { x = 0, y = 0 },
    display_size = { w = 71 * 1.4, h = 95 * 1.4 },
    config = { card_limit = -1, extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 1, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end,
}

-- 8-bit Joker
SMODS.Joker {
    key = "8_bit_joker",
    unlocked = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = 'atlas_cod_jokers',
    pos = { x = 3, y = 11 },
    pixel_size = { w = 24, h = 32 },
    display_size = { w = 24 * 3, h = 32 * 3 },
    config = { extra = { chips = 64 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local id = context.other_card:get_id()
            if id == 2 or id == 4 or id == 8 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

-- Enhanced Joker
SMODS.Joker {
    key = "enhanced_joker",
    unlocked = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = 'atlas_cod_jokers',
    pos = { x = 9, y = 11 },
    config = { extra = { mult = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
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
    config = { extra = { xmult = 0.1 } },
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