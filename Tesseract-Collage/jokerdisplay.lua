local jd_def = JokerDisplay.Definitions

jd_def["j_tes_blue_java"] = { -- Blue Java
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "exp" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_tes_mint"] = { -- Mint Condition
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
    end
}

jd_def["j_tes_chroma"] = {} -- Chroma
jd_def["j_tes_penrose"] = {} -- Penrose

jd_def["j_tes_waterfall"] = { -- Waterfall
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_tes_dada"] = { -- Dada Joker
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        card.joker_display_values.chips = (G.jokers and G.jokers.cards and #G.jokers.cards or 0) * card.ability.extra.chips_add
    end
}

jd_def["j_tes_impos"] = { -- Impossibility
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.joker_display_values", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(2,8)" },
    },
    calc_function = function(card)
        local x_mult = 1
        local has2, has8 = false, false
        local text, _, hand = JokerDisplay.evaluate_hand()
        for _, card in pairs(hand) do
            if card:get_id() then
                if card:get_id() == 2 then
                    has2 = true
                elseif card:get_id() == 8 then
                    has8 = true
                end
            end
        end
        if has2 and has8 then x_mult = 3 end
        card.joker_display_values.x_mult = x_mult
    end
}

jd_def["j_tes_bismuth"] = { -- Bismuth
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return (playing_card.config.center == G.P_CENTERS.m_wild) and
        joker_card.ability.extra.repetitions * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}

jd_def["j_tes_jimbette"] = { -- Jimbette
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "num" },
        { text = "/7 " },
        { ref_table = "card.joker_display_values", ref_value = "suit", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
        { text = ")" }
    },
    calc_function = function(card)
        card.joker_display_values.suit = localize("Hearts", 'suits_plural')
    end
}

jd_def["j_tes_conduit"] = { -- Conduit
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                             colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "mult_text", colour = G.C.CHIPS },
        { text = ", " },
        { ref_table = "card.joker_display_values", ref_value = "bonus_text", colour = G.C.MULT },
        { text = ")" },
    },
    calc_function = function(card)
        local chips, mult = 0, 0
        local text, _, hand = JokerDisplay.evaluate_hand()
        if text ~= 'Unknown' then
            for _, scoring in pairs(hand) do
                if scoring.ability.name then
                    if scoring.ability.name == 'Mult' then
                        chips = chips + card.ability.extra.chips
                    elseif scoring.ability.name == 'Bonus' then
                        mult = mult + card.ability.extra.mult
                    end
                end
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.chips = chips
        card.joker_display_values.mult_text = localize("k_mult")
        card.joker_display_values.bonus_text = "Bonus" -- TODO: add localization
    end
}

jd_def["j_tes_mahjong"] = { -- Mahjong Tile
    text = {
        { text = "+$" },
        { ref_table = "card.joker_display_values", ref_value = "money", retrigger_type = "mult" }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "hand", colour = G.C.ORANGE },
        { text = ")" },
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
        local money = 0
        local _, hands, _ = JokerDisplay.evaluate_hand()
        if(hands['Pair'] and next(hands['Pair'])) then
            money = card.ability.extra.dollars
        end
        card.joker_display_values.money = money
        card.joker_display_values.hand = localize('Pair', 'poker_hands')
    end
}

jd_def["j_tes_pineapple"] = { -- Pineapple
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def["j_tes_pie"] = { -- Apple Pie
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
}

jd_def["j_tes_blocks"] = { -- Letter Blocks
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "active" },
    },
    calc_function = function(card)
        local mult = card.ability.extra.mult
        if G.GAME.current_round.hands_played == 0 then
            local text, _, hand = JokerDisplay.evaluate_hand()
            for _, scoring in pairs(hand) do
                if scoring:is_face() or scoring:get_id() == 14 then
                    mult = mult + card.ability.extra.mult_gain
                end
            end
            card.joker_display_values.active = "("..localize("jdis_active")..")"
        else
            card.joker_display_values.active = "("..localize("jdis_inactive")..")"
        end
        card.joker_display_values.mult = mult
    end
}

jd_def["j_tes_reserve"] = { -- Reserve Leaflet
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
        { text = "x" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.RED },
        { text = ")" },
    },
    calc_function = function(card)
        local count = 0
        if G.jokers then
            for _, joker_card in ipairs(G.jokers.cards) do
                if joker_card.config.center.rarity and joker_card.config.center.rarity == 3 then
                    count = count + 1
                end
            end
        end
        card.joker_display_values.count = count
        card.joker_display_values.localized_text = localize("k_rare")
    end,
    mod_function = function(card, mod_joker)
        return { x_mult = (card.config.center.rarity == 3 and mod_joker.ability.extra.xmult ^ JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
    end
}