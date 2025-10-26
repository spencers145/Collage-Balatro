--[[SMODS.Sticker:take_ownership('pinned',
{
    atlas = 'TextureAtlasStickers',
    pos = { x = 0, y = 0 },
    badge_colour = HEX("FFFFFF"),
}, false)

SMODS.Sticker:take_ownership('pinned', {
    atlas = 'TextureAtlasStickers',
    badge_colour = HEX 'fda200',
    pos = { x = 0, y = 0 },
    rate = 0,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end
}, true)]]