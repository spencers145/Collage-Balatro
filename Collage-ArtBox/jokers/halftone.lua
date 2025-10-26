SMODS.Joker {
    key = "halftone",
    rarity = 2,
    pos = { x = 6, y = 0},
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)

		if context.repetition and context.cardarea == G.play and next(context.poker_hands["Straight"]) then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
	end
    }