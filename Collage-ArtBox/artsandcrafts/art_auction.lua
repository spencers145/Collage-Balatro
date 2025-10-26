SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_auction',
	set = 'art',
	name = 'Auction',
	config = {
    min_highlighted = 1,
    max_highlighted = 1,
	extra = {
		edition_cost=15,
		seal_cost=10,
		enhancement_cost=5,
		card_cost = 5,
	}
    },
	pos = { x = 5, y = 0 },
	cost = 3,
	unlocked = true,
	discovered = false,

	loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.edition_cost,
            card.ability.extra.seal_cost,
            card.ability.extra.enhancement_cost,
			card.ability.extra.card_cost
          }
        }
    end,

	 use = function(self, card, area)
	  local total_cash=card.ability.extra.card_cost
      local selected = G.hand.highlighted[1]
	  if selected.edition then
		total_cash=total_cash+card.ability.extra.edition_cost
	  end

	  if selected.seal then
		total_cash=total_cash+card.ability.extra.seal_cost
	  end

	  if selected.config.center ~= G.P_CENTERS.c_base then
		total_cash=total_cash+card.ability.extra.enhancement_cost
	  end

	  SMODS.destroy_cards(selected)

	  -- fucked up awful code
	  if #G.hand.highlighted > 1 then
		selected = G.hand.highlighted[2]
		if selected.edition then
			total_cash=total_cash+card.ability.extra.edition_cost
		end

		if selected.seal then
			total_cash=total_cash+card.ability.extra.seal_cost
		end

		if selected.config.center ~= G.P_CENTERS.c_base then
			total_cash=total_cash+card.ability.extra.enhancement_cost
		end
		SMODS.destroy_cards(selected)
	  end

	  G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            ease_dollars(total_cash, true)
            return true end }))
	 end
})