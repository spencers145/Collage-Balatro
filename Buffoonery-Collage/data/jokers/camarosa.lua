SMODS.Joker {
    key = "camarosa",
    name = "Camarosa",
    atlas = 'buf_jokers',
    pos = {
        x = 5,
        y = 2,
    },
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	yes_pool_flag = 'gfondue_licked',
    config = {
        extra = { xmult = 1.15, odds = 1000},
    },
    loc_txt = {set = 'Joker', key = 'j_buf_camarosa'},
    loc_vars = function(self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'camarosa')
        return {
            vars = {card.ability.extra.xmult, n, d}
        }
    end,
	
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and SMODS.has_enhancement(context.other_card, 'm_sarc_strawberry') and not context.end_of_round then
            return {
				xmult = card.ability.extra.xmult,
                card = context.other_card
			}
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card then
            if SMODS.pseudorandom_probability(card, pseudorandom('camarosa'), 1, card.ability.extra.odds, 'camarosa') then
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
							func = function()
									G.jokers:remove_card(card)
									card:remove()
									card = nil
								return true; end})) 
						return true
					end
				})) 
				return {
					message = localize('k_eaten_ex'),
					colour = G.C.FILTER
				}
			else
				return {
					message = localize('k_safe_ex'),
					colour = G.C.GREEN
				}
			end
        end
    end
}