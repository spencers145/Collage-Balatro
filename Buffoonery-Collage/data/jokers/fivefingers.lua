SMODS.Joker {
    key = "fivefingers",
    name = "Five Fingers",
    atlas = 'buf_jokers',
    pos = {
        x = 1,
        y = 3,
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	
    config = {
        extra = { Xmult = 2.5 },
		numetal = true
    },
    loc_txt = {set = 'Joker', key = 'j_buf_fivefingers'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
			if #context.scoring_hand == 5 and math.fmod(#G.jokers.cards, 5) == 0 then
				return {
					xmult = card.ability.extra.Xmult
				}
			end
        end
    end
}