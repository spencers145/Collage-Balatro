-- Boosters

SMODS.Atlas({
    key = 'loteria_booster',
    path = 'loteria_boosters.png',
    px = '71',
    py = '95'
})

local small_boosters = {keys = {'small_loteria_1', 'small_loteria_2', 'small_loteria_3', 'small_loteria_4'}, info = {
    atlas = 'loteria_booster',
    config = {choose = 1, extra = 3},
    artist_credits = {'kosze','gappie'},
    create_card = function(self, card)
        return create_card('ortalab_loteria', G.pack_cards, nil, nil, true,  true, nil, "lotpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_loteria)
        ease_background_colour{new_colour = G.C.SET.ortalab_loteria, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'ortalab_loteria_pack',
    draw_hand = true,
    cost = 4,
    weight = 1,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_loteria, lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
}}

for i, key in ipairs(small_boosters.keys) do
    local booster_args = {}
    for k,v in pairs(small_boosters.info) do
        booster_args[k] = v
    end
    booster_args.key = key
    booster_args.pos = { x = i - 1, y = 0 }
    booster_args.ortalab_type = 'ortalab_loteria'
    SMODS.Booster(booster_args)
end

local mid_boosters = {keys = {'mid_loteria_1', 'mid_loteria_2'}, info = {
    atlas = 'loteria_booster',
    config = {choose = 1, extra = 5},
    artist_credits = {'kosze','gappie'},
    create_card = function(self, card)
        return create_card('ortalab_loteria', G.pack_cards, nil, nil, true,  true, nil, "lotpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_loteria)
        ease_background_colour{new_colour = G.C.SET.ortalab_loteria, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'ortalab_loteria_pack',
    draw_hand = true,
    cost = 6,
    weight = 1,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_loteria, lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2)},
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
    booster_args.ortalab_type = 'ortalab_loteria'
    SMODS.Booster(booster_args)
end

local large_boosters = {keys = {'big_loteria_1', 'big_loteria_2'}, info = {
    atlas = 'loteria_booster',
    config = {choose = 2, extra = 5},
    artist_credits = {'kosze','gappie'},
    create_card = function(self, card)
        return create_card('ortalab_loteria', G.pack_cards, nil, nil, true,  true, nil, "lotpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_loteria)
        ease_background_colour{new_colour = G.C.SET.ortalab_loteria, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'ortalab_loteria_pack',
    draw_hand = true,
    cost = 8,
    weight = 1,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.ARGS.LOC_COLOURS.ortalab_loteria, lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.4), lighten(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2), darken(G.ARGS.LOC_COLOURS.ortalab_loteria, 0.2)},
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
    booster_args.ortalab_type = 'ortalab_loteria'
    SMODS.Booster(booster_args)
end