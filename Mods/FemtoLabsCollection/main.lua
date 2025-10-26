----------------------------------------------
------------MOD CODE -------------------------

SMODS.current_mod.optional_features = { 
    retrigger_joker = true,
    cardareas = {
        unscored = true,
    },
 }

femtoLabsCollection = {}

SMODS.Atlas({key = "j_flc_jokers", path = "j_flc_jokers.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/jokers.lua")))()

SMODS.Atlas({key = "b_flc_decks", path = "b_flc_decks.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/decks.lua")))()

--SMODS.Atlas({key = "bl_flc_blinds", path = "bl_flc_blinds.png", px = 34, py = 34, frames = 21, atlas_table = "ANIMATION_ATLAS"})
--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/blinds.lua")))()

--SMODS.Atlas({key = "c_flc_twilight", path = "c_flc_twilight.png", px = 71, py = 95, atlas = "asset_atlas"})
--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/consumables.lua")))()

--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/sold_area.lua")))()

--SMODS.Atlas({key = "m_flc_enhancements", path = "m_flc_enhancements.png", px = 71, py = 95, atlas = "asset_atlas"})
--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/enhancements.lua")))()

--SMODS.Atlas({key = "p_flc_twilight", path = "p_flc_twilight.png", px = 71, py = 95, atlas = "asset_atlas"})

--SMODS.Atlas({key = "tag_flc_tags", path = "tag_flc_tags.png", px = 34, py = 34, atlas = "asset_atlas"})
--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/tags.lua")))()

--SMODS.Atlas({key = "v_flc_vouchers", path = "v_flc_vouchers.png", px = 71, py = 95, atlas = "asset_atlas"})
--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/vouchers.lua")))()

--assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/poker_hands.lua")))()

assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/challenges.lua")))()

--SMODS.Atlas({key = "v_flc_vouchers", path = "v_flc_vouchers.png", px = 71, py = 95, atlas = "asset_atlas"})
--assert(load(love.filesystem.read(SMODS.current_mod.path .. "lua_files/vouchers.lua")))()

--assert(load(love.filesystem.read(SMODS.current_mod.path .. "lua_files/editions.lua")))()

assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/localization/en-us.lua")))()

SMODS.Atlas({
    key = "modicon",
    path = "flc_icon.png",
    px = 34,
    py = 34
}):register()

SMODS.Sound({
    key = 'scraggly_slurp',
    path = 'slurp.ogg'
})

to_big = to_big or function(num) return num end

----------------------------------------------
------------MOD CODE END----------------------
