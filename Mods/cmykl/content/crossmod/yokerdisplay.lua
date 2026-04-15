if JokerDisplay then
    local yok = JokerDisplay.Definitions
    
    yok["j_cmykl_humanity"] = { -- Humanity
        reminder_text = {
            { text = "(", colour = G.C.UI.TEXT_INACTIVE },
            { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.UI.TEXT_INACTIVE },
            { text = ")", colour = G.C.UI.TEXT_INACTIVE },
        },
        calc_function = function(card)
            card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_left <= 1 and G.GAME.current_round.discards_left == 0 and G.GAME.pool_flags.cmykl_nothanded == false and
                localize("jdis_active") or localize("jdis_inactive")
        end
    }

    yok["j_cmykl_rockjoker"] = { -- Rock Joker
        text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.CHIPS },
        calc_function = function(card)
            local playing_hand = next(G.play.cards)
            local chip = 0
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_hand or not playing_card.highlighted then
                    if playing_card.facing and not (playing_card.facing == 'back') and not playing_card.debuff and playing_card.ability.name == 'Stone Card' then
                        chip = chip + card.ability.extra.chips * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    end
                end
            end
            card.joker_display_values.chips = chip
        end
    }

    yok["j_cmykl_invitationcard"] = { -- Invitation Card
        text = {
            { text = "+" },
            { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.MULT },
        reminder_text = {
            { text = "(", colour = G.C.UI.TEXT_INACTIVE },
            { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.UI.TEXT_INACTIVE },
            { text = ")", colour = G.C.UI.TEXT_INACTIVE },
        },
        calc_function = function(card)
            card.ability.extra.mult = card.ability.extra.hype or 0
            card.joker_display_values.active = G.GAME and G.GAME.blind and G.GAME.blind.boss and
                localize("jdis_active") or localize("jdis_inactive")
        end
    }

    yok["j_cmykl_halftonejoker"] = { -- Halftone Joker
        text = {
            { text = "+$" },
            { ref_table = "card.joker_display_values", ref_value = "dollars", retrigger_type = "mult" },
        },
        text_config = { colour = G.C.GOLD },
        reminder_text = {
            { text = "(" },
            { text = "Three Suits", colour = G.C.ORANGE },
            { text = ")" }
        },
        calc_function = function(card)
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0,
                ['Suitless'] = 0
            }

            if text ~= 'Unknown' then

                for i = 1, #scoring_hand do
                    local c = scoring_hand[i]
                    if c.ability.name ~= 'Wild Card' then
                        if c:is_suit('Hearts', true) and suits["Hearts"] == 0 then
                            suits["Hearts"] = suits["Hearts"] + 1
                        elseif c:is_suit('Diamonds', true) and suits["Diamonds"] == 0 then
                            suits["Diamonds"] = suits["Diamonds"] + 1
                        elseif c:is_suit('Spades', true) and suits["Spades"] == 0 then
                            suits["Spades"] = suits["Spades"] + 1
                        elseif c:is_suit('Clubs', true) and suits["Clubs"] == 0 then
                            suits["Clubs"] = suits["Clubs"] + 1
                        end
                    end
                end

                for i = 1, #scoring_hand do
                    local c = scoring_hand[i]
                    if c.ability.name == 'Wild Card' or c.ability.name == 'Stone Card' and suits["Suitless"] == 0 then
                        suits["Suitless"] = 1 end
                    end
                end

            local suit_count = 0
            for _, count in pairs(suits) do
                if count > 0 then suit_count = suit_count + 1 end
            end

            local is_suit_condition_met = suit_count >= 3

            card.joker_display_values.dollars = is_suit_condition_met and card.ability.extra.dollars or 0
        end
    }

    yok["j_cmykl_stickerbomb"] = { -- Sticker Bomb
     extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_stickerbomb')
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        end
    }

    yok["j_cmykl_crystalgeode"] = { -- Crystal Geode
    text = {
            { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" },
            { text = "x",                              scale = 0.35 },
            { text = "$12",                             colour = G.C.GOLD },
        },
        extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        reminder_text = {
            { text = "(" },
            { text = "Stone Cards", colour = G.C.ORANGE },
            { text = ")" }
        },
        extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
            local count = 0
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            if text ~= 'Unknown' then
                for _, scoring_card in pairs(scoring_hand) do
                    if scoring_card.ability.name == 'Stone Card' then
                        count = count +
                            JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    end
                end
            end
            card.joker_display_values.count = count
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_stickerbomb')
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        end
    }

    yok["j_cmykl_polycoria"] = { -- Polycoria
    text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        },
        calc_function = function(card)
            local text, _, _ = JokerDisplay.evaluate_hand()
            local is_card_sharp_hand = text ~= 'Unknown' and G.GAME.hands and G.GAME.hands[text] and
                G.GAME.hands[text].played_this_round > 1
            card.joker_display_values.Xmult = (not is_card_sharp_hand) and card.ability.extra.Xmult or 1
        end

    }

    yok["j_cmykl_scrapbook"] = { -- Scrapbook
        text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "uniques", retrigger_type = "exp" }
                    }
                }
            },
            reminder_text = {
            { text = "(" },
            { text = "Uniques", colour = G.C.ORANGE },
            { text = ")" }
            },  
            calc_function = function(card)
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    local unique_suits = {}
                    local unique_editions = {}
                    local unique_enhancements = {}
                    local unique_seals = {}
                    for _, played_card in ipairs(scoring_hand) do
                        if (SMODS.get_enhancements(played_card)["m_stone"] or SMODS.get_enhancements(played_card)["m_wild"]) then
                            unique_suits["Suitless"] = true
                        elseif played_card.base.suit then
                            unique_suits[played_card.base.suit] = true
                        end 

                        if played_card.edition and played_card.edition.key then
                            unique_editions[played_card.edition.key] = true
                        end

                        if played_card.seal then
                            unique_seals[played_card.seal] = true
                        end

                        local enhancements = SMODS.get_enhancements(played_card)
                        for enh_key, _ in pairs(enhancements) do
                            unique_enhancements[enh_key] = true
                        end
                    end

                    local function count_keys(tbl)
                        local count = 0
                        for _ in pairs(tbl) do
                            count = count + 1
                        end
                        return count
                    end

                    local total_uniques = count_keys(unique_suits) + count_keys(unique_editions) + count_keys(unique_enhancements) + count_keys(unique_seals)
                    card.joker_display_values.uniques = (0.2 * total_uniques) + 1
                end
            end
    }

    yok["j_cmykl_apparition"] = { -- Apparition
        extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_apparition')
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        end
    }

    yok["j_cmykl_rebellion"] = { -- Rebellion
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        },
        reminder_text = {
            { text = "(", colour = G.C.UI.TEXT_INACTIVE },
            { ref_table = "card.joker_display_values", ref_value = "warn", colour = G.C.UI.TEXT_INACTIVE },
            { text = ")", colour = G.C.UI.TEXT_INACTIVE },
        },
        calc_function = function(card)
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            card.joker_display_values.warn = "..."
            if text ~= 'Unknown' then
                for _, scoring_card in ipairs(scoring_hand) do
                    if scoring_card:is_face() then
                        card.joker_display_values.warn = "Warning!"
                    end
                end
            end
        end

    }

    yok["j_cmykl_twister"] = { -- Twister
        extra = {
            {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "odds" },
                { text = ")" },
            }
        },
        reminder_text = {
            { text = "(" },
            { text = "Seals", colour = G.C.ORANGE },
            { text = ")" }
        },
        extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
            local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_Twister')
            card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
        end
    }

    yok["j_cmykl_stripedjoker"] = { -- Striped Joker
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.joker_display_values", ref_value = "Xmult", retrigger_type = "exp" }
                }
            }
        },
        calc_function = function(card)
            local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            card.joker_display_values.Xmult = 1
            if text ~= 'Unknown' then
                for _, scoring_hand in pairs(scoring_hand) do
                    if #scoring_hand >= 4 then
                        card.joker_display_values.Xmult = 1
                        local card1 = scoring_hand[1]:get_id()
                        local card3 = scoring_hand[3]:get_id()
                        local card5 = scoring_hand[5]:get_id()
                        local card2 = scoring_hand[2]:get_id()
                        local card4 = scoring_hand[4]:get_id()

                        matcher = (card1 == card3 and card1 == (card5 or card3) and card2 == card4 and card1 ~= card2)
                    end
                end
                if matcher then
                    card.joker_display_values.Xmult = card.ability.extra.Xmult
                end
            end
        end
    }

    yok["j_cmykl_themountain"] = {
        text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "spadesindeck", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.CHIPS },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Spades"], 0.35) },
            { text = ")" }
        },
        calc_function = function(card)
            card.joker_display_values.localized_text = localize("Spades", 'suits_plural')
        end
    }
    
    yok["j_cmykl_thedune"] = {
        text = {
            {
                border_nodes = {
                    { text = "X" },
                    { ref_table = "card.ability.extra", ref_value = "heartsindeck", retrigger_type = "exp" }
                }
            }
        },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
            { text = ")" }
        },
        calc_function = function(card)
            card.joker_display_values.localized_text = localize("Hearts", 'suits_plural')
        end
    }

    yok["j_cmykl_thevalley"] = {
        text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "clubsindeck", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.MULT },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Clubs"], 0.35) },
            { text = ")" }
        },
        calc_function = function(card)
            card.joker_display_values.localized_text = localize("Clubs", 'suits_plural')
        end
    }

    yok["j_cmykl_thecanyon"] = {
        text = {
                { text = "+$" },
                { ref_table = "card.ability.extra", ref_value = "diamondsindeck", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.GOLD },
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Diamonds"], 0.35) },
            { text = ")" }
        },
        calc_function = function(card)
            card.joker_display_values.localized_text = localize("Diamonds", 'suits_plural')
        end
    }

    yok["j_cmykl_medrano"] = {
        text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "medranorich", retrigger_type = "mult" }
        },
        text_config = { colour = G.C.CHIPS },
        reminder_text = {
            { text = "(" },
            { text = "Seals", colour = G.C.ORANGE },
            { text = ")" }
        },
    }
end