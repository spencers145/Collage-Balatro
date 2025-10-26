SMODS.Enhancement({
    key = "pinata",
    atlas = "enhancers_atlas",
    pos = {x=0,y=0},
    discovered = true,
    config = {
        extra = {
        money=8,
        odds=3,
        exploded=true,
      }
    },
    in_pool = function (self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pinata_blow_up')
        return {
          vars = {
            card.ability.extra.money,
            n,
            d,
          }
        }
    end,
    --function to create random tag is taken from paperback, hope you dont mind >w<
    ---@param seed string
    ---@param options table?
    ---@return table
    calculate = function(self, card, context)
      if context.after then
        if context.scoring_hand then
          for key, value in pairs(context.scoring_hand) do
            if card == value and SMODS.pseudorandom_probability(card, 'pinata_blow_up', 1, card.ability.extra.odds) then
              unlock_card(G.P_CENTERS.b_znm_pinata)
              return {
                func = function()
                  G.E_MANAGER:add_event(Event({
                  trigger = 'before',
                  delay = 1.1,
                      func = (function()
                        card:calculate_seal({remove_playing_cards = true, removed = {card}})
                        card:explode(nil, 0.4, true)
                        SMODS.calculate_context({remove_playing_cards = true, removed = {card}})
                        local pool = options or get_current_pool('Tag')
                        local tag_key = pseudorandom_element(pool, pseudoseed('pinata'))
                        while tag_key == 'UNAVAILABLE' do
                          tag_key = pseudorandom_element(pool, pseudoseed('pinata'))
                        end
                        local tag = Tag(tag_key)
                        if tag_key == "tag_orbital" then
                          local available_hands = {}
                          for k, hand in pairs(G.GAME.hands) do
                            if hand.visible then
                            available_hands[#available_hands + 1] = k
                            end
                          end
                          tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed('pinata' .. '_orbital'))
                        end
                          ease_dollars(card.ability.extra.money)
                            G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.0,
                                func = (function()
                                  add_tag(type(tag) == 'string' and Tag(tag) or tag)
                                  card:remove()
                                  --play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                                  --play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                                  return true
                                end)
                            }))
                        return true
                      end)
                  }))
                end
              }
            end
          end
        end
      end
      if context.remove_playing_cards then
        for k, val in ipairs(context.removed) do
        if val==card then

          local pool = options or get_current_pool('Tag')
          local tag_key = pseudorandom_element(pool, pseudoseed('pinata'))

          while tag_key == 'UNAVAILABLE' do
            tag_key = pseudorandom_element(pool, pseudoseed('pinata'))
          end

          local tag = Tag(tag_key)

          if tag_key == "tag_orbital" then
            local available_hands = {}

            for k, hand in pairs(G.GAME.hands) do
              if hand.visible then
               available_hands[#available_hands + 1] = k
              end
            end

            tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed('pinata' .. '_orbital'))
          end

          return {
            dollars=card.ability.extra.money,
            func = function()
              G.E_MANAGER:add_event(Event({
              trigger = 'before',
              delay = 0.0,
                  func = (function()
                    add_tag(type(tag) == 'string' and Tag(tag) or tag)
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                  end)
              }))
            end
          }
        end
      end

    end
    
    end
})