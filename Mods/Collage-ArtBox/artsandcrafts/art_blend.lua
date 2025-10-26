SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_blend',
	set = 'art',
	name = 'Blend',
	config = {
    min_highlighted = 2,
    max_highlighted = 2
    },
	pos = { x = 0, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = false,

    use = function(self, card, area)
      local left = G.hand.highlighted[1]
      local right = G.hand.highlighted[2]

	   for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
	local total = 0
	  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.15, func = function()
	  if(left.edition and not right.edition)then
			total = total + 1
			G.hand.highlighted[2]:set_edition(G.hand.highlighted[1].edition, true)
	  else
		if(right.edition and not left.edition)then
			total = total + 1
			G.hand.highlighted[1]:set_edition(G.hand.highlighted[2].edition, true)
		end
	  end

	  if(left.seal and not right.seal)then
			total = total + 1
			G.hand.highlighted[2]:set_seal(G.hand.highlighted[1].seal)
	  else
		if(right.seal and not left.seal)then
			total = total + 1
			G.hand.highlighted[1]:set_seal(G.hand.highlighted[2].seal)
		end
	  end

	  if(left.config.center ~= G.P_CENTERS.c_base and  right.config.center == G.P_CENTERS.c_base)then
			total = total + 1
			G.hand.highlighted[2]:set_ability(G.hand.highlighted[1].config.center.key)
			G.hand.highlighted[2].ability.extra=G.hand.highlighted[1].ability.extra
	  else
		if(right.config.center ~= G.P_CENTERS.c_base and  left.config.center == G.P_CENTERS.c_base)then
			total = total + 1
			G.hand.highlighted[1]:set_ability(G.hand.highlighted[2].config.center.key)
			G.hand.highlighted[1].ability.extra=G.hand.highlighted[2].ability.extra
		end
	  end
	  return true end }))

	  if total == 3 then
		unlock_card(G.P_CENTERS.b_femtoLabsCollection_hue)
	  end

	   for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
    
    end
})