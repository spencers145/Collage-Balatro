-- atlas definitions
SMODS.Atlas {
    key = "roffers",
    path = "Jokers.png",
    px = 71,
    py = 95,
}

--talisman compat dummy func
to_big = to_big or function (value)
    return value
end

-- load common util funcs
assert(SMODS.load_file("globals.lua"))()
--assert(SMODS.load_file("No Favorites.lua"))()

-- load all individual cards
local subdir = "cards"
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
for _, filename in pairs(cards) do
    if string.sub(filename, string.len(filename) - 3) == '.lua' then
        assert(SMODS.load_file(subdir .. "/" .. filename))()
    end
end

SMODS.current_mod.description_loc_vars = function()
    return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2 }
end
