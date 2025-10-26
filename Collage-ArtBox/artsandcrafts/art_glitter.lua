SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_glitter',
	set = 'art',
	name = 'Glitter',
	pos = { x = 0, y = 1 },
	cost = 3,
	unlocked = true,
	discovered = false,
    loc_vars = function(self, info_queue)
        -- comment out these two because players already know what they are
		--info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        --info_queue[#info_queue+1] = G.P_CENTERS.e_holo
        info_queue[#info_queue+1] = G.P_CENTERS.e_bunc_fluorescent
        info_queue[#info_queue+1] = G.P_CENTERS.e_bunc_glitter
	end,
    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards > 0 then
            for k, v in ipairs(G.hand.cards) do
            if not v.edition then 
                return true 
            end
        end
        else
            return false
        end
    end,
	use = function(self, card, area, copier)
        local cards = {}
        for k, v in ipairs(G.hand.cards) do
            if not v.edition then cards[#cards + 1] = v end
          end
        local _card = pseudorandom_element(cards, pseudoseed('glitter'))
        local edition = poll_edition('glitter', nil, true, true, {'e_bunc_glitter', 'e_bunc_fluorescent', 'e_foil', 'e_holo'})
        
    
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                _card:set_edition(edition, true)
            return true end }))
        card:juice_up(0.3, 0.5)
    end,
})