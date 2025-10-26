--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----
--!!!NOT CURRENTLY IMPLEMENTED!!!----
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!----

SMODS.Atlas({
    key = 'prismstakes',
    path = 'chips.png',
    px = '29',
    py = '29'
})
SMODS.Atlas({
    key = 'prismstickers',
    path = 'stickers.png',
    px = 71,
    py = 95
})
--[[SMODS.Stake({
    key = "platinum",
    above_stake = "gold",
    applied_stakes = { "gold" },
    prefix_config = {above_stake = { mod = false },applied_stakes = { mod = false }},
    atlas = 'prismstakes',
    pos = {x = 0, y = 0},
    colour = G.C.GREY,
    shiny = true,
    sticker_pos = {x = 0, y = 0},
    sticker_atlas = 'prismstickers',
    modifiers = function()
        G.GAME.modifiers.price_scaling = true
        G.GAME.price_scaling = 0
    end,
})]]

local orig_ease_ante = ease_ante
function ease_ante(mod, ante_end)
    while G.GAME.modifiers.price_scaling and G.GAME.round_resets.ante + mod >= (G.GAME.price_scaling + 1) * 2 do
        G.GAME.price_scaling = G.GAME.price_scaling + 1
    end
    orig_ease_ante(mod, ante_end)
end
