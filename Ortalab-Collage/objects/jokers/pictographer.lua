SMODS.Joker({
	key = "pictographer",
	atlas = "jokers",
	pos = {x=3,y=10},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {money = 25, count = 4, current = 0}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.money, card.ability.extra.count, card.ability.extra.current%card.ability.extra.count}}
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'ortalab_loteria' and not context.blueprint then
            if not context.retrigger_joker and not context.blueprint then 
                card.ability.extra.current = (card.ability.extra.current%card.ability.extra.count) + 1
                SMODS.calculate_effect({message = card.ability.extra.current..'/'..card.ability.extra.count, colour = G.ARGS.LOC_COLOURS.ortalab_loteria}, card)
            end
            if card.ability.extra.current >= card.ability.extra.count then
                if not context.retrigger_joker then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.5,
                        func = function()                
                            SMODS.calculate_effect({
                                message = localize('ortalab_joker_miles_reset'),
                                colour = G.ARGS.LOC_COLOURS.ortalab_loteria
                            }, card)
                            return true
                        end
                    }))  
                end        
                return {
                    dollars = card.ability.extra.money,
                }
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.current = 0
            return {
                message = localize('ortalab_joker_miles_reset'),
                colour = G.ARGS.LOC_COLOURS.ortalab_loteria
            }
        end
    end
})