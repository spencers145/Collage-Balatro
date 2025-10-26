assert(SMODS.load_file("luafiles/ZucchiniJokers.lua"))()
assert(SMODS.load_file("luafiles/ZucchiniDecks.lua"))()
assert(SMODS.load_file("luafiles/ZucchiniChallenges.lua"))()




-- icon loading code

SMODS.Atlas{
    key = "modicon",
    path = "znm_icon.png", -- the file in BOTH assets/1x and assets/2x
    px = 32,
    py = 32
}