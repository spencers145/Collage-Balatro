
SMODS.Atlas {
	key = "atlas_cod_blinds",
	path = "blinds.png",
	px = 34,
	py = 34,
    frames = 21,
    atlas_table = 'ANIMATION_ATLAS'
}

-- The Innocent
SMODS.Blind {
    key = "innocent",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 0 },
    boss = { min = 1 },
    boss_colour = HEX("7e05bf"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.end_of_round and context.main_eval then
                local current_score = G.GAME.chips
                local current_requirements = G.GAME.blind.chips
                if (current_score>current_requirements) then
                    blind.triggered = true
                    G.GAME.cod_bl_innocent_excess = G.GAME.cod_bl_innocent_excess or 0
                    G.GAME.cod_bl_innocent_excess = G.GAME.cod_bl_innocent_excess + current_score - current_requirements
                end
            end
        end
    end
}

-- hook to adjust blind score requirements
local get_blind_amount_ref = get_blind_amount
function get_blind_amount(ante)

    local chip_requirement = get_blind_amount_ref(ante)

    local innocent_karma = G.GAME.cod_bl_innocent_excess or 0
    chip_requirement = chip_requirement + innocent_karma

    return chip_requirement
end

-- The Rot
SMODS.Blind {
    key = "rot",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 1 },
    boss = { min = 2 },
    boss_colour = HEX("72663f"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.round_shuffle then

                local debuff_amount = math.ceil(#G.deck.cards / 5)

                for i=0,(debuff_amount-1) do
                    SMODS.debuff_card(G.deck.cards[#G.deck.cards-i], true, "cod_rot")
                end
            end
        end
    end,
    disable = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_rot")
        end
    end,
    defeat = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_rot")
        end
    end
}

-- The Spire
SMODS.Blind {
    key = "spire",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("c88d11"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.round_shuffle then
                for i=1,25 do
                    if G.deck.cards[i] then
                        SMODS.debuff_card(G.deck.cards[i], true, "cod_spire")
                    end
                end
            end
        end
    end,
    disable = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_spire")
        end
    end,
    defeat = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_spire")
        end
    end
}

-- The Snow
SMODS.Blind {
    key = "snow",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 5 },
    boss = { min = 1 },
    boss_colour = HEX("dfdfdf"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.round_shuffle then
                for i=1,#G.deck.cards do
                    if (i%3==1) then
                        SMODS.debuff_card(G.deck.cards[i], true, "cod_snow")
                    end
                end
            end
        end
    end,
    disable = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_snow")
        end
    end,
    defeat = function(self)
        for _, playing_card in pairs(G.playing_cards) do
            SMODS.debuff_card(playing_card, false, "cod_snow")
        end
    end
}

-- The Lost
SMODS.Blind {
    key = "lost",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 4 },
    boss = { min = 5 },
    boss_colour = HEX("ab85c8"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.end_of_round and context.main_eval then
                
                local planet = nil
                for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                    if v.config.hand_type == context.scoring_name then
                        planet = v.key
                    end
                end

                if planet then
                    blind.triggered = true
                    G.GAME.banned_keys[planet] = true
                end
            end
        end
    end,
}

-- The Ascetic
SMODS.Blind {
    key = "ascetic",
    dollars = 0,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 6 },
    boss = { min = 1, max = 2 },
    boss_colour = HEX("dfc87e"),
    calculate = function(self, blind, context)
        if blind.disabled then
            if context.end_of_round and context.main_eval then
                local boss_reward = 5
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + boss_reward
                return {
                    remove_default_message = true,
                    dollars = boss_reward,
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
        else
            if context.end_of_round and context.main_eval then
                blind.triggered = true
            end
        end
    end,
}

-- The Elk
SMODS.Blind {
    key = "elk",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 7 },
    boss = { min = 2 },
    boss_colour = HEX("7b4e25"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card.ability.played_this_ante then
                return {
                    stay_flipped = true
                }
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].facing == 'back' then
                G.hand.cards[i]:flip()
            end
        end
        for _, playing_card in pairs(G.playing_cards) do
            playing_card.ability.wheel_flipped = nil
        end
    end,
}

-- The Vein
SMODS.Blind {
    key = "vein",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 8 },
    boss = { min = 2 },
    boss_colour = HEX("883030"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.hand_drawn or context.move_card then
                if G.jokers.cards[1] then
                    SMODS.debuff_card(G.jokers.cards[1], true, "cod_vein")
                end
                for i=2,#G.jokers.cards do
                    SMODS.debuff_card(G.jokers.cards[i], false, "cod_vein")
                end
            end
        end
    end,
    disable = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, false, "cod_vein")
        end
    end,
    defeat = function(self)
        for _, joker in ipairs(G.jokers.cards) do
            SMODS.debuff_card(joker, false, "cod_vein")
        end
    end
}

-- The Elite
SMODS.Blind {
    key = "elite",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 9 },
    boss = { min = 6 },
    boss_colour = HEX("ee4ba8"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and not next(SMODS.get_enhancements(context.debuff_card)) then
                return {
                    debuff = true
                }
            end
        end
    end,
}

-- The Collective
SMODS.Blind {
    key = "collective",
    dollars = 5,
    mult = 2,
    atlas = 'atlas_cod_blinds',
    pos = { x = 0, y = 10 },
    boss = { min = 4 },
    boss_colour = HEX("698079"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers and next(SMODS.get_enhancements(context.debuff_card)) then
                return {
                    debuff = true
                }
            end
        end
    end,
}