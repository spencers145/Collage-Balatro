SMODS.Joker {
    key = "korny",
    name = "Korny Joker",
    atlas = 'buf_jokers',
    pos = {
        x = 1,
        y = 0,
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
	no_pool_flag = 'korny_dead',
    config = {
        extra = { 
		normalxmult = 2,
        bgxmult = 2.5,
		bsxmult = 3,
		odds = 10
		},
		numetal = true
    },
    loc_txt = {set = 'Joker', key = 'j_buf_korny'},
    loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'korny_info'}   --Credit original artwork author [Snakey] (adapted by me for balatro)
		end
        return {
            
            vars = {card.ability.extra.normalxmult, 
					card.ability.extra.bgxmult,
					card.ability.extra.bsxmult,
					1,
					card.ability.extra.odds
                }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			if G.GAME.blind:get_type() == 'Small' then
				return {
					xmult = card.ability.extra.normalxmult
				}
			end
			if G.GAME.blind:get_type() == 'Big' then
				return {
					xmult = card.ability.extra.bgxmult
				}
			end
			if G.GAME.blind:get_type() == 'Boss' then
				return {
					xmult = card.ability.extra.bsxmult
				}
			end
		end
		if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then
			local rand_min = 5
            if SMODS.pseudorandom_probability(card, pseudoseed('korny'), 1, math.random(rand_min, card.ability.extra.odds), 'korny') then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3,0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true; end }))
                        return true
                    end
                }))
				G.GAME.pool_flags.korny_dead = true
                return {
                    message = localize("buf_korny_dd"),
                    colour = G.C.RED,
                    card = card
                }
            else
                return {
                    message = localize("buf_korny_ok"),
                    colour = G.C.GREEN,
                    card = card
                }
            end
        end
    end
}