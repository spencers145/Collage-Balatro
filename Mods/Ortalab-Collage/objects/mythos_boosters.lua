-- Boosters

SMODS.Atlas({
    key = 'mythos_booster',
    path = 'mythos_boosters.png',
    px = '71',
    py = '95'
})

local small_boosters = {keys = {'small_mythos_1', 'small_mythos_2'}, info = {
    atlas = 'mythos_booster',
    config = {choose = 1, extra = 2},
    artist_credits = {'kosze'},
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_mythos)
        ease_background_colour{new_colour = mix_colours(G.C.RED,darken(G.C.SET.ortalab_mythos,0.5),0.3), special_colour = darken(G.ARGS.LOC_COLOURS['ortalab_mythos_alt'],0.2), contrast = 2}
    end,
    draw_hand = false,
    select_card = 'consumeables',
    group_key = 'ortalab_mythos_pack',
    cost = 4,
    weight = 0.5,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.01,
            scale = 0.3,
            initialize = true,
            lifespan = 1.4,
            speed = 2.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.SET.ortalab_mythos, darken(G.C.SET.ortalab_mythos, 0.5), G.C.RED, darken(G.C.SET.ortalab_mythos, 0.2), G.ARGS.LOC_COLOURS['ortalab_mythos_alt']},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return create_card('ortalab_mythos', G.pack_cards, nil, nil, true,  true, nil, "mythospack")
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
    booster_args.ortalab_type = 'ortalab_mythos'
    SMODS.Booster(booster_args)
end

SMODS.Booster({
    key = 'mid_mythos',
    atlas = 'mythos_booster',
    pos = {x = 2, y = 0},
    config = {choose = 1, extra = 4},
    artist_credits = {'kosze'},
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_mythos)
        ease_background_colour{new_colour = mix_colours(G.C.RED,darken(G.C.SET.ortalab_mythos,0.5),0.3), special_colour = darken(G.ARGS.LOC_COLOURS['ortalab_mythos_alt'],0.2), contrast = 2}
    end,
    draw_hand = false,
    select_card = 'consumeables',
    group_key = 'ortalab_mythos_pack',
    cost = 6,
    weight = 0.4,
    ortalab_type = 'ortalab_mythos',
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.01,
            scale = 0.3,
            initialize = true,
            lifespan = 1.4,
            speed = 2.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.SET.ortalab_mythos, darken(G.C.SET.ortalab_mythos, 0.5), G.C.RED, darken(G.C.SET.ortalab_mythos, 0.2), G.ARGS.LOC_COLOURS['ortalab_mythos_alt']},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return create_card('ortalab_mythos', G.pack_cards, nil, nil, true,  true, nil, "mythospack")
    end,
})

SMODS.Booster({
    key = 'big_mythos',
    atlas = 'mythos_booster',
    pos = {x = 3, y = 0},
    config = {choose = 2, extra = 4},
    artist_credits = {'kosze'},
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SET.ortalab_mythos)
        ease_background_colour{new_colour = mix_colours(G.C.RED,darken(G.C.SET.ortalab_mythos,0.5),0.3), special_colour = darken(G.ARGS.LOC_COLOURS['ortalab_mythos_alt'],0.2), contrast = 2}
    end,
    draw_hand = false,
    select_card = 'consumeables',
    group_key = 'ortalab_mythos_pack',
    cost = 8,
    weight = 0.1,
    ortalab_type = 'ortalab_mythos',
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.01,
            scale = 0.3,
            initialize = true,
            lifespan = 1.4,
            speed = 2.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.C.SET.ortalab_mythos, darken(G.C.SET.ortalab_mythos, 0.5), G.C.RED, darken(G.C.SET.ortalab_mythos, 0.2), G.ARGS.LOC_COLOURS['ortalab_mythos_alt']},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        return create_card('ortalab_mythos', G.pack_cards, nil, nil, true,  true, nil, "mythospack")
    end,
})