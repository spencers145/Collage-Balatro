SMODS.Joker {
    key = "origami",
    config = {
    },
    rarity = 2,
    pos = { x = 0, y = 1},
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          SMODS.calculate_effect({ message = localize('artb_plus_art') }, context.blueprint_card or card)
          G.E_MANAGER:add_event(Event({
            func = function()
              SMODS.add_card {
                set = 'art',
                key_append = 'origami'
              }
              G.GAME.consumeable_buffer = 0
              return true
            end
           }))
        end
    end
    }