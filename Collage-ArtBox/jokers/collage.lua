SMODS.Joker {
    key = "collage",
    config = {
      extra = {
        chips_mod = 15,
        chips = 0,
        mult_mod = 3,
        mult = 0,
        xmult_mod = 0.2,
        xmult = 1,
      }
    },
    rarity = 2,
    pos = { x = 2, y = 1},
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.chips_mod,
            card.ability.extra.chips,
            card.ability.extra.mult_mod,
            card.ability.extra.mult,
            card.ability.extra.xmult_mod,
            card.ability.extra.xmult,
          }
        }
    end,

    calculate = function(self, card, context)

        

        if not context.blueprint and context.remove_playing_cards and context.removed and #context.removed > 0 then

            local choice = pseudorandom_element({ "1", "2", "3" }, pseudoseed('collage'))
            if choice=="1" then
                card.ability.extra.chips = card.ability.extra.chips + (#context.removed * card.ability.extra.chips_mod)

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_mod * #context.removed } } })
            elseif choice=="2" then
                card.ability.extra.mult = card.ability.extra.mult + (#context.removed * card.ability.extra.mult_mod)

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod * #context.removed } } })
            else
                card.ability.extra.xmult = card.ability.extra.xmult + (#context.removed * card.ability.extra.xmult_mod)

                card_eval_status_text(card, 'extra', nil, nil, nil,
                { message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult * #context.removed } } })
            end

        end

          if context.joker_main then
            return {
              chips = card.ability.extra.chips,
              mult = card.ability.extra.mult,
              x_mult = card.ability.extra.xmult
            }
        end
        
    end
}