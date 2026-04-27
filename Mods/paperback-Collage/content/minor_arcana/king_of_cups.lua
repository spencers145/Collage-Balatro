PB_UTIL.MinorArcana {
  key = 'king_of_cups',
  atlas = 'minor_arcana_atlas',
  pos = { x = 6, y = 1 },
  paperback_credit = {
    coder = { 'srockw' }
  },

  can_use = function(self, card)
    return true
  end,

  use = function(self, card, area)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            play_sound("tarot1")
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        local the_card = pseudorandom_element(PB_UTIL.PAPERCLIP_MINOR_ARCANA_CATEGORIES.scoring, pseudoseed('king_of_cups_scoring'..G.GAME.round_resets.ante))
                        SMODS.add_card({key = the_card})
                        play_sound("card1")
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        local the_card = pseudorandom_element(PB_UTIL.PAPERCLIP_MINOR_ARCANA_CATEGORIES.held_in_hand, pseudoseed('king_of_cups_held'..G.GAME.round_resets.ante))
                        SMODS.add_card({key = the_card})
                        play_sound("card1")
                    end
                    return true
                end
            }))
            return true
        end
    }))
  end
}
