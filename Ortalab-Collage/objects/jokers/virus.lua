SMODS.Joker({
	key = "virus",
	atlas = "jokers",
	pos = {x = 4, y = 3},
	rarity = 3,
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {duped_cards = 2, joker_triggered = false}},
    artist_credits = {'golddisco'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.duped_cards}}
    end,
    calculate = function(self, card, context) --Virus Logic
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)
        end
        if context.destroying_card and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            if #context.full_hand == 1 and context.destroying_card == context.full_hand[1] then
                local played_card = context.full_hand[1]
                local targets = {}
                targets[#targets+1] = pseudorandom_element(G.hand.cards, 'ortalab_virus')
                if #G.hand.cards > 1 then
                    targets[#targets+1] = pseudorandom_element(G.hand.cards, 'ortalab_virus')
                    while targets[2] == targets[1] do
                        targets[2] = pseudorandom_element(G.hand.cards, 'ortalab_virus_reroll')
                    end
                end
                for _, _card in ipairs(targets) do 
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after', delay = 0.7,
                        func = function()
                            _card:flip()
                            copy_card(played_card, _card, nil, G.playing_card)
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after', delay = 0.3,
                        func = function()
                            context.destroying_card:juice_up()                
                            return true
                        end
                    }))
                    SMODS.calculate_effect({message = localize('ortalab_infected'), colour = G.C.GREEN}, _card)
                end                

                G.E_MANAGER:add_event(Event({
                    trigger = 'after', delay = 0.7,
                    func = function()
                        for _, _card in ipairs(targets) do _card:flip() end                
                        return true
                    end
                }))

                return {
                    remove = true
                }
            end
        end
    end
})