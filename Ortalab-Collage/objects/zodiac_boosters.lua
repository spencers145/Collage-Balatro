SMODS.Atlas({
    key = 'zodiac_booster',
    path = 'zodiac_boosters.png',
    px = '71',
    py = '95'
})

local small_boosters = {keys = {'small_zodiac_1', 'small_zodiac_2', 'small_zodiac_3', 'small_zodiac_4'}, info = {
    atlas = 'zodiac_booster',
    config = {choose = 1, extra = 2},
    artist_credits = {'gappie'},
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_zodiac)
        ease_background_colour{new_colour = G.C.SET.ortalab_zodiac, special_colour = G.C.BLACK, contrast = 2}
    end,
    draw_hand = false,
    group_key = 'ortalab_astral_pack',
    cost = 4,
    weight = 0.5,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_zodiac, lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return create_card('ortalab_zodiac', G.pack_cards, nil, nil, true, true, nil, "zodpack")
    end,
    }
}

for i, key in ipairs(small_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(small_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i - 1, y = 0 }
    booster_args.ortalab_type = 'ortalab_zodiac'
    SMODS.Booster(booster_args)
end

local mid_boosters = {keys = {'mid_zodiac_1', 'mid_zodiac_2'}, info = {
    atlas = 'zodiac_booster',
    config = {choose = 1, extra = 4},
    artist_credits = {'gappie'},
    create_card = function(self, card, i)
        return create_card('ortalab_zodiac', G.pack_cards, nil, nil, true, true, nil, "zodpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_zodiac)
        ease_background_colour{new_colour = G.C.SET.ortalab_zodiac, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'ortalab_astral_pack',
    draw_hand = false,
    cost = 6,
    weight = 0.4,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_zodiac, lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}

for i, key in ipairs(mid_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(mid_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i - 1, y = 1 }
    booster_args.ortalab_type = 'ortalab_zodiac'
    SMODS.Booster(booster_args)
end

local large_boosters = {keys = {'big_zodiac_1', 'big_zodiac_2'}, info = {
    atlas = 'zodiac_booster',
    config = {choose = 2, extra = 4},
    artist_credits = {'gappie'},
    create_card = function(self, card, i)
        return create_card('ortalab_zodiac', G.pack_cards, nil, nil, true, true, nil, "zodpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_zodiac)
        ease_background_colour{new_colour = G.C.SET.ortalab_zodiac, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'ortalab_astral_pack',
    draw_hand = false,
    cost = 8,
    weight = 0.2,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_zodiac, lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_zodiac, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}

for i, key in ipairs(large_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(large_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i + 1, y = 1 }
    booster_args.ortalab_type = 'ortalab_zodiac'
    SMODS.Booster(booster_args)
end

-- Util Functions

-- table of zodiacs and hand type pairings
local hand_types_typing = {
    c_ortalab_zod_aries = 'Four of a Kind',
    c_ortalab_zod_gemini = 'Pair',
    c_ortalab_zod_leo = 'Flush Five',
    c_ortalab_zod_libra = 'Full House',
    c_ortalab_zod_sag = 'Flush',
    c_ortalab_zod_aquarius = 'Two Pair',
    c_ortalab_zod_taurus = 'Three of a Kind',
    c_ortalab_zod_cancer = 'Flush House',
    c_ortalab_zod_virgo = 'Five of a Kind',
    c_ortalab_zod_scorpio = 'High Card',
    c_ortalab_zod_capr = 'Straight',
    c_ortalab_zod_pisces = 'Straight Flush'
}

-- retrieve the zodiac key for a known hand type
function zodiac_from_hand(hand_type)
    for key, hand in pairs(hand_types_typing) do
        if hand == hand_type then return key end
    end
end