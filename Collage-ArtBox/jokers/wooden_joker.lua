SMODS.Joker {
    key = "wooden_joker",
    rarity = 1,
    pos = { x = 2, y = 4},
    atlas = 'joker_atlas',
    config = {extra = {repetitions = 2}},
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.repetitions,
          }
        }
    end,

    calculate = function(self, card, context)

		 if context.repetition and context.other_card and G.hand.cards[#G.hand.cards] and context.other_card == G.hand.cards[#G.hand.cards] then
            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra.repetitions,
                card = card
            }
        end
	end
    }