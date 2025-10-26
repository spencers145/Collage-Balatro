SARC = {}
SARC.config = SMODS.current_mod.config
--[[SMODS.current_mod.optional_features = {
    cardareas = {
        discard = true,
    }
}]] --

G.SP = {}
G.SP.C = {}
G.SP.FUNCS = {}
local sarcpot = SMODS.current_mod.path

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            align = 'cm',
            padding = 0.05,
            emboss = 0.05,
            r = 0.1,
            colour = G.C.BLACK
        },
        nodes = {{
            n = G.UIT.R,
            config = {
                align = 'cm',
                minh = 1
            },
            nodes = {{
                n = G.UIT.T,
                config = {
                    text = localize('sarc_requires_restart'),
                    colour = G.C.RED,
                    scale = 0.5,
                    padding = 0.2
                }
            }}
        }, {
            n = G.UIT.R,
            config = {
                align = 'cm'
            },
            nodes = {{
                n = G.UIT.C,
                nodes = {create_toggle {
                    label = localize('sarc_enable_jokers'),
                    ref_table = SARC.config,
                    ref_value = 'jokers_enabled'
                }, create_toggle {
                    label = localize('sarc_enable_consumables'),
                    ref_table = SARC.config,
                    ref_value = 'consumables_enabled'
                }, create_toggle {
                    label = localize('sarc_enable_vouchers'),
                    ref_table = SARC.config,
                    ref_value = 'vouchers_enabled'
                }, create_toggle {
                    label = localize('sarc_enable_decks'),
                    ref_table = SARC.config,
                    ref_value = 'decks_enabled'
                }}
            }}
        }}
    }
end

SMODS.Atlas {
    key = 'modicon',
    px = 32,
    py = 32,
    path = 'modicon.png'
}
SMODS.Atlas {
    key = 'tags',
    px = 32,
    py = 32,
    path = 'tags.png'
}
SMODS.Atlas {
    key = "sarcpot_atlas",
    path = "sarcpot_atlas.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "vouchers",
    path = "vouchers.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "consumables",
    path = "consumables.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "enhancements",
    path = "enhancements.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = "boosters",
    path = "boosters.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'decks',
    px = 71,
    py = 95,
    path = 'decks.png'
}
G.SP.C.travel_1 = HEX("DEB940")
G.SP.C.travel_2 = HEX("fab411")
G.SP.C.navy = HEX("50638f")
G.SP.C.light_navy = HEX("5f70a3")
SMODS.ConsumableType({
    key = "travel",
    primary_colour = G.SP.C.travel_1,
    secondary_colour = G.SP.C.travel_2,
    loc_txt = {
        name = "Travel Card",
        collection = "Travel Cards",
        undiscovered = {
            name = 'Unknown Travel Card',
            text = {'Find this card in an unseeded', 'run to find out what it does'}
        }
    },
    collection_rows = {5, 4},
    shop_rate = 0,
    default = 'c_sarc_brittle_hollow'
})
if SARC.config.jokers_enabled == true then
    local path = SMODS.current_mod.path .. 'joker/'
    for _, v in pairs(NFS.getDirectoryItems(path)) do
        assert(SMODS.load_file('joker/' .. v))()
    end

end
if SARC.config.vouchers_enabled == true then
    local path = SMODS.current_mod.path .. 'vouchers/'
    assert(SMODS.load_file('vouchers/advantage'))()
    assert(SMODS.load_file('vouchers/nat_20'))()
    assert(SMODS.load_file('vouchers/compass'))()
    assert(SMODS.load_file('vouchers/journey'))()

end

if SARC.config.consumables_enabled == true then
    local path = SMODS.current_mod.path .. 'consumables/'
    for _, v in pairs(NFS.getDirectoryItems(path)) do
        assert(SMODS.load_file('consumables/' .. v))()
    end
    local path = SMODS.current_mod.path .. 'boosters/'
    for _, v in pairs(NFS.getDirectoryItems(path)) do
        assert(SMODS.load_file('boosters/' .. v))()
    end
    local path = SMODS.current_mod.path .. 'enhancements/'
    for _, v in pairs(NFS.getDirectoryItems(path)) do
        assert(SMODS.load_file('enhancements/' .. v))()
    end
    local path = SMODS.current_mod.path .. 'tags/'
    for _, v in pairs(NFS.getDirectoryItems(path)) do
        assert(SMODS.load_file('tags/' .. v))()
    end
end

local path = SMODS.current_mod.path .. 'sarcpot_utils/'
for _, v in pairs(NFS.getDirectoryItems(path)) do
    assert(SMODS.load_file('sarcpot_utils/' .. v))()
end
if SARC.config.decks_enabled == true then
    if SARC.config.consumables_enabled == true then
        local path = SMODS.current_mod.path .. 'decks/'
        for _, v in pairs(NFS.getDirectoryItems(path)) do
            assert(SMODS.load_file('decks/' .. v))()
        end
    end
end

local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.brittle_hollow_count = 0
    ret.undertale_count = 0
    ret.undertale_limit = 2

    return ret
end

function SMODS.current_mod.reset_game_globals(run_start)
    if run_start == true then
        G.GAME.kingdom_count = 0
        G.GAME.brittle_hollow_count = 0
        G.GAME.undertale_count = 0
        G.GAME.undertale_limit = 2

    end
end

function SARC.level_up(card, hand, levels)
    -- print(G.GAME.brittle_hollow_count)
    levels = levels or 1
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 0.8,
        delay = 0.3
    }, {
        handname = hand,
        chips = G.GAME.hands[hand].chips,
        mult = G.GAME.hands[hand].mult,
        level = G.GAME.hands[hand].level
    })

    level_up_hand(nil, hand, true, levels)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            G.TAROT_INTERRUPT_PULSE = true
            return true
        end
    }))
    update_hand_text({
        delay = 0
    }, {
        mult = G.GAME.hands[hand].mult,
        StatusText = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            return true
        end
    }))
    update_hand_text({
        delay = 0
    }, {
        chips = G.GAME.hands[hand].chips,
        StatusText = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            G.TAROT_INTERRUPT_PULSE = nil
            return true
        end
    }))
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 0.9,
        delay = 0
    }, {
        level = G.GAME.hands[hand].level
    })
    delay(1.3)
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 1.1,
        delay = 0
    }, {
        mult = 0,
        chips = 0,
        handname = '',
        level = ''
    })
end
function SARC.get_rand_hand_index(amount, exclude, exclude_enhancement, exclude_seal, exclude_edition)
    local available_indexes = {}
    local random_indexes = {}
    local exclude_set = {}

    if exclude then
        for _, index in pairs(exclude) do
            exclude_set[index] = true
        end
    end

    for i = 1, #G.hand.cards do
        if exclude_enhancement then
            if SMODS.has_enhancement(G.hand.cards[i], 'c_base') then
                exclude_set[i] = true
            end
        end
        if exclude_seal then
            if G.hand.cards[i].seal then
                exclude_set[i] = true
            end
        end
        if exclude_edition then
            if G.hand.cards[i].edition then
                exclude_set[i] = true
            end
        end
        if not exclude_set[i] then
            table.insert(available_indexes, i)

        end
    end
    for i = 1, amount do
        if #available_indexes == 0 then
            break
        end
        local rand_index_in_available = math.random(1, #available_indexes)

        local selected_index = available_indexes[rand_index_in_available]
        table.insert(random_indexes, selected_index)

        table.remove(available_indexes, rand_index_in_available)
    end
    return random_indexes
end
function SARC.level_up_multiple(card, hand_list, custom_hand_text, levels)
    levels = levels or 1
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 0.8,
        delay = 0.3
    }, {
        handname = custom_hand_text,
        chips = "...",
        mult = "...",
        level = "..."
    })
    for i = 1, #hand_list do
        level_up_hand(nil, hand_list[i], true, levels)

    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            G.TAROT_INTERRUPT_PULSE = true
            return true
        end
    }))
    update_hand_text({
        delay = 0
    }, {
        mult = "+",
        StatusText = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            return true
        end
    }))
    update_hand_text({
        delay = 0
    }, {
        chips = "+",
        StatusText = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.9,
        func = function()
            play_sound('tarot1')
            if card then
                card:juice_up(0.8, 0.5)
            end
            G.TAROT_INTERRUPT_PULSE = nil
            return true
        end
    }))
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 0.9,
        delay = 0
    }, {
        level = "+" .. levels
    })
    delay(1.3)
    update_hand_text({
        sound = 'button',
        volume = 0.7,
        pitch = 1.1,
        delay = 0
    }, {
        mult = 0,
        chips = 0,
        handname = '',
        level = ''
    })
end
function SARC.get_available_suits()
    local suits = {}
    for _, v in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(v) and not SMODS.has_any_suit(v) then
            if not suits[v.base.suit] then
                suits[v.base.suit] = true
            end
        end
    end
    local size = SARC.get_table_size(suits)
    return suits, size
end

function SARC.get_table_size(tbl)
    local count = 0
    for _ in pairs(tbl) do -- Iterate over all key-value pairs
        count = count + 1
    end
    return count
end

function SARC.get_popular_suit()
    local suits = {}
    local current_max = 0
    local popular_suits = {}
    local selected_suit
    for _, v in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(v) then
            if suits[v.base.suit] then
                suits[v.base.suit] = suits[v.base.suit] + 1
            else
                suits[v.base.suit] = 1
            end
        end
    end
    for _, v in pairs(suits) do
        if v > current_max then
            current_max = v
        end
    end
    for k, v in pairs(suits) do
        if v == current_max then
            table.insert(popular_suits, k)
        end
    end
    selected_suit = popular_suits[math.random(#popular_suits)]
    return selected_suit
end

function SARC.get_popular_rank()
    local rank = {}
    local current_max = 0
    local popular_ranks = {}
    local selected_rank
    for k, v in ipairs(G.playing_cards) do
        -- print(v.base.value)
        if not SMODS.has_no_rank(v) == true then
            if rank[v.base.value] then
                rank[v.base.value] = rank[v.base.value] + 1
            else
                rank[v.base.value] = 1
            end
        end
    end
    for _, v in pairs(rank) do
        if v > current_max then
            current_max = v
        end
    end
    for k, v in pairs(rank) do
        if v == current_max then
            table.insert(popular_ranks, k)
        end
    end
    selected_rank = popular_ranks[math.random(#popular_ranks)]
    return selected_rank
end

-- Stolen from All in Jest

function SARC.balance_percent(card, percent)
    local chip_mod = percent * hand_chips
    local mult_mod = percent * mult
    local avg = (chip_mod + mult_mod) / 2
    hand_chips = hand_chips + (avg - chip_mod)
    mult = mult + (avg - mult_mod)
    local text = localize('k_balanced')

    update_hand_text({
        delay = 0
    }, {
        mult = mult,
        chips = hand_chips
    })
    card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = text,
        colour = {0.8, 0.45, 0.85, 1},
        sound = 'gong'
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function()
            ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
            ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                blocking = false,
                delay = 4.3,
                func = (function()
                    ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
                    ease_colour(G.C.UI_MULT, G.C.RED, 2)
                    return true
                end)
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blockable = false,
                blocking = false,
                no_delete = true,
                delay = 6.3,
                func = (function()
                    G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2],
                        G.C.BLUE[3], G.C.BLUE[4]
                    G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3],
                        G.C.RED[4]
                    return true
                end)
            }))
            return true
        end)
    }))
    delay(0.6)
    return hand_chips, mult
end
-- these are also from All in Jest
function SARC.apply_multiplier(t, key, factor, tag)
    t.temp_mult_val = t.temp_mult_val or {}
    t.temp_mult_val[key] = t.temp_mult_val[key] or {}
    t.temp_mult_val[key][tag] = factor
    SARC.update_multiplied_value(t, key)
end

function SARC.remove_multiplier(t, key, tag)
    if t.temp_mult_val and t.temp_mult_val[key] then
        t.temp_mult_val[key][tag] = nil
        SARC.update_multiplied_value(t, key)
    end
end

function SARC.update_multiplied_value(t, key)
    local base = t["base_" .. key] or t[key]
    t["base_" .. key] = base -- Save original if not already
    local result = base
    for _, mult in pairs(t.temp_mult_val[key] or {}) do
        result = result * mult
    end
    t[key] = result
end

