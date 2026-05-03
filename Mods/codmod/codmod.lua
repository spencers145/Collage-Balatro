SMODS.Atlas {
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

local config = SMODS.current_mod.config

assert(SMODS.load_file("src/core.lua"))()
assert(SMODS.load_file("src/config_page.lua"))()
assert(SMODS.load_file("src/draw.lua"))()
assert(SMODS.load_file("src/tarots.lua"))()
--assert(SMODS.load_file("src/decks.lua"))()
--assert(SMODS.load_file("src/stickers.lua"))()
--assert(SMODS.load_file("src/stakes.lua"))()

if CardSleeves then
    assert(SMODS.load_file("src/sleeves.lua"))()
end

if config.cod_blinds_enabled then assert(SMODS.load_file("src/blinds.lua"))() end
if config.cod_tags_enabled then assert(SMODS.load_file("src/tags.lua"))() end
if config.cod_jokers_enabled then assert(SMODS.load_file("src/jokers.lua"))() end

if config.cod_jokers_enabled and config.cod_blinds_enabled and config.cod_tags_enabled then assert(SMODS.load_file("src/challenges.lua"))() end