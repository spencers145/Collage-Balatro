
SMODS.Atlas {
	key = "atlas_cod_stakes",
	path = "stakes.png",
	px = 29,
	py = 29
}

-- Platinum
SMODS.Stake {
    name = "Platinum Stake",
    key = "platinum",
    applied_stakes = { "stake_gold" },
    prefix_config = {
        applied_stakes = { mod = false },
        above_stake = { mod = false }
    },
    atlas = 'atlas_cod_stakes',
    pos = { x = 0, y = 0 },
    sticker_atlas = 'atlas_cod_stickers',
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.modifiers.enable_cod_envy = true
        G.GAME.modifiers.enable_cod_dormant = true
        G.GAME.modifiers.enable_cod_claustrophobic = true
        G.GAME.modifiers.enable_cod_confidential = true
        G.GAME.modifiers.enable_cod_expensive = true
        G.GAME.modifiers.enable_cod_imprisoned = true
    end,
    colour = HEX("d4fbf3"),
    shiny = true,
    unlocked = false,
}