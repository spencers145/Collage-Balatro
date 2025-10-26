-- Brick Up
SMODS.Joker {
	key = "brick_up",
	atlas = "TextureAtlasJokers",
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	rarity = 2,
	pools = { ["Visibility"] = true },
	cost = 6,
	pos = { x = 1, y = 1 },
	config = { extra = { repetitions = 1 } },
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play and (SMODS.has_enhancement(context.other_card, 'm_stone') or SMODS.has_enhancement(context.other_card, 'm_vis_brick')) then
			return {
				repetitions = card.ability.extra.repetitions
			}
		end
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') or SMODS.has_enhancement(playing_card, 'm_vis_brick') then
                return true
            end
        end
        return false
    end
}