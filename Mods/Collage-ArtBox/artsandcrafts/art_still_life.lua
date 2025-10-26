SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_still_life',
	set = 'art',
	name = 'Still Life',
    config = {
        mod_conv = "c_artb_gros_michel_collectable",
    },
	pos = { x = 1, y = 2 },
	cost = 3,
	unlocked = true,
	discovered = true,
  can_use = function(self, card)
		return G.consumeables and
    (#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
    or next(SMODS.find_card('c_artb_gros_michel_collectable', count_debuffed))
    or next(SMODS.find_card('c_artb_cavendish_collectable', count_debuffed)))
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "artb_gros_michel_explainer", set = "Other"}
        local n,d = SMODS.get_probability_vars(card, 1, 6, 'c_artb_art_still_life')
        return {vars = {n,d}}
    end,

    use = function(self, card, area)
      if next(SMODS.find_card('c_artb_gros_michel_collectable', count_debuffed)) then
          local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_gros_michel_collectable')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
      end

      if next(SMODS.find_card('c_artb_cavendish_collectable', count_debuffed)) then
          local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_cavendish_collectable')
          new_card:add_to_deck()
          G.consumeables:emplace(new_card)
      end

      if not next(SMODS.find_card('c_artb_gros_michel_collectable', count_debuffed))
        and not next(SMODS.find_card('c_artb_cavendish_collectable', count_debuffed))
        and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          if SMODS.pseudorandom_probability(card, pseudorandom('art_still_life'), 1, 5, 'art_still_life') then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
              if SMODS.pseudorandom_probability(card, pseudorandom('art_still_life_cavendish'), 1, 5, 'art_still_life_cavendish', true) then
                local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_cavendish_collectable')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
              else
                local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_gros_michel_collectable')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
              end
            return true end }))
          else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
                return true
            end }))
          end
      end
    end

    
})