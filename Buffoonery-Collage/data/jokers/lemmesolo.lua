SMODS.Joker{
	key = "lemmesolo",
    name = "Let Me Solo Her",
    atlas = 'buf_jokers',
    pos = {
        x = 4,
        y = 3,
    },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    config = {
        extra = { mult = 20, jokies = 5, rares = 2 }        
    },
    loc_txt = {set = 'Joker', key = 'j_buf_lemmesolo'},
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.jokies, card.ability.extra.rares}
        }
    end,
	update = function(self, card)
        if G.jokers and card.area == G.jokers then
			if #G.jokers.cards > 1 then
				card.debuff = true
			else
				card.debuff = false
			end
		end
    end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
		if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card and G.GAME.blind.boss then
			SMODS.calculate_effect({message = 'Boss Felled', colour = G.C.FILTER}, card)
			G.E_MANAGER:add_event(Event({
                    func = function() 
						local _rarity = nil
						local rares = card.ability.extra.rares - 1
                        for i = 1, card.ability.extra.jokies do
							if i == card.ability.extra.jokies - rares then _rarity = 0.99 end
                            local _card = create_card('Joker', G.jokers, nil, _rarity, nil, nil, nil, 'lem')
                            _card:add_to_deck()
                            G.jokers:emplace(_card)
                            _card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
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
		end
	end
}