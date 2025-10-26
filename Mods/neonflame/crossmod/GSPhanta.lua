SMODS.Joker {
    key = "miafey",
    name = "Mia Fey",

    atlas = "layerjoker",
    pos = { x = 4, y = 0 },
    soul_pos = { x = 5, y = 0},

    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    demicolon_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, context)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_phanta_ghostcard
    end,

    calculate = function(self, card, context)
        if context.before then
	    card.gainmult = 0
	    for _, c in pairs(G.play.cards) do
	        if SMODS.has_enhancement(c, "m_phanta_ghostcard") then
		    card.gainmult = card.gainmult + (c.ability.h_x_mult or 0)
		end
	    end
	end

	if context.individual and context.cardarea == G.play then
	    context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.gainmult
	    return {
	        extra = {
		    message = localize('k_upgrade_ex'),
		    colour = G.C.MULT
		}
	    }
	end
    end
}