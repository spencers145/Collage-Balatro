SMODS.Joker {
    key = "minimalism",
    rarity = 2,
    pos = { x = 3, y = 1},
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    calculate = function(self, card, context)

		if context.repetition and context.cardarea == G.play and #context.scoring_hand<4 then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		end
	end
    }