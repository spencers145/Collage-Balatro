SMODS.Joker { --chroma
  key = 'chroma',

   in_pool = function(self, args)
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, 'm_wild') then
        return true
      end
    end
    return false
  end,
  
  discovered = false,
  rarity = 3,
  atlas = 'T.Jokers',
  pos = { x = 2, y = 0 },
  soul_pos = { x = 3, y = 0 },
  cost = 9,
  blueprint_compat = false,
  perishable_compat = true,
  eternal_compat = true,
  
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
  end,
  
  calculate = function(self, card, context)
    if context.before and context.main_eval and not context.blueprint then
      local wild = {}
      for _, scored_card in ipairs(context.scoring_hand) do
        if SMODS.has_enhancement(scored_card, 'm_wild') and (not scored_card.edition or not scored_card.edition.polychrome) then
          wild[#wild + 1] = scored_card
          scored_card:set_edition('e_polychrome', true, true)
          scored_card.delay_edition = true
          G.E_MANAGER:add_event(Event({
            func = function()
              scored_card.delay_edition = nil
              scored_card:juice_up()
              return true
            end
          }))
        end
      end
      
      if #wild > 0 then
        return {
          message = localize('polychrome', 'labels') .. '!',
          sound = 'polychrome1',
          volume = 0.7,
          pitch = 1.2,
          colour = G.C.DARK_EDITION
        }
      end
    end
  end
}