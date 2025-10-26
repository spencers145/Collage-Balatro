Ortalab = SMODS.current_mod


local load_order = {'jokers', 'enhancements', 'editions', 'loteria', 'zodiac', 'patches', 'decks', 'coupons', 'stakes', 'blinds', 'curses', 'mythos'}
Ortalab.load_table = {
    jokers = true,
    enhancements = false,
    editions = true,
    loteria = false,
    zodiac = false,
    patches = true,
    decks = true,
    coupons = true,
    stakes = false,
    blinds = true,
    curses = false,
    mythos = false,
}


loc_colour('red')
G.ARGS.LOC_COLOURS['Ortalab'] = HEX('990000')
G.ARGS.LOC_COLOURS.Ort_menu_colourA = HEX('4F6367')
G.ARGS.LOC_COLOURS.Ort_menu_colourB = HEX('C9013C')


for _, k in ipairs(load_order) do
    if Ortalab.load_table[k] then assert(SMODS.load_file('objects/'..k..'.lua'))() end
end
--assert(SMODS.load_file('objects/loteria_boosters.lua'))() -- load boosters
--assert(SMODS.load_file('objects/zodiac_boosters.lua'))() -- load boosters
--assert(SMODS.load_file('objects/mythos_boosters.lua'))() -- load boosters
assert(SMODS.load_file('objects/challenges.lua'))() -- load challenges

assert(SMODS.load_file('util/artists.lua'))()
assert(SMODS.load_file('util/functions.lua'))()
assert(SMODS.load_file('util/menu.lua'))()
assert(SMODS.load_file('util/friends.lua'))()

SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})

Ortalab.optional_features = function()
    return {
        retrigger_joker = true
        --quantum_enhancements = true
    }
end

SMODS.Atlas({
    key = 'logo',
    path = 'logo.png',
    px = 333,
    py = 216,
})
SMODS.Shader({
    key = 'background',
    path = 'new_background.fs'
})

if (SMODS.Mods['malverk'] or {}).can_load then
    AltTextures_Utils.default_atlas['ortalab_zodiac'] = 'ortalab_zodiac_cards'
    AltTextures_Utils.loc_keys['ortalab_zodiac'] = 'b_ortalab_zodiac_cards'
    AltTexture({
        key = 'alt_zodiac',
        set = 'ortalab_zodiac',
        path = 'zodiac_coloured.png',
        display_pos = 'c_ortalab_zod_virgo',
        loc_txt = {
            name = 'Rainbow Zodiac'
        }
    })

    AltTexture({
        key = 'alt_loteria_booster',
        set = 'Booster',
        path = 'loteria_boosters_alt.png',
        keys = {
            'p_ortalab_small_loteria_1', 'p_ortalab_small_loteria_2', 'p_ortalab_small_loteria_3', 'p_ortalab_small_loteria_4',
            'p_ortalab_mid_loteria_1', 'p_ortalab_mid_loteria_2', 'p_ortalab_big_loteria_1', 'p_ortalab_big_loteria_2'
        },
        display_pos = 'p_ortalab_small_loteria_1',
        loc_txt = {
            name = 'Plain Loteria Boosters'
        }
    })

    TexturePack{
        key = 'alt_orta',
        textures = {
            'ortalab_alt_zodiac',
            'ortalab_alt_loteria_booster'
        },
        loc_txt = {
            name = 'Ortalab Alternate Art',
            text = {
                'Alternate art for',
                'various {C:Ortalab}Ortalab{} objects'
            }
        }
    }
end

Ortalab.ui_config = {
    colour = G.C.L_GREY,
    outline_colour = G.ARGS.LOC_COLOURS.Ortalab,
    tab_button_colour = G.ARGS.LOC_COLOURS.Ortalab,
    back_colour = G.ARGS.LOC_COLOURS.Ortalab,
}