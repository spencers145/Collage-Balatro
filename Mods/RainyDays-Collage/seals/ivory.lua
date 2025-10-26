loc_colour() --first time running creates G.ARGS.LOC_COLOURS
G.ARGS.LOC_COLOURS.ivory = HEX('e0d59d')

SMODS.Seal {
  key = 'ivory',
  atlas = 'Seals',
  pos = { x = 0, y = 0 },
  badge_colour = G.ARGS.LOC_COLOURS.ivory,
  unlocked = true, 
  discovered = true,

  calculate = function(self, card, context)
    if context.before and G.GAME.current_round.hands_played == 0 then
      local played = false
      for i = 1, #context.full_hand do
        if context.full_hand[i] == card then
          played = true
          break
        end
      end
      
      if played and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          trigger = 'before',
          delay = 0.0,
          func = function()
            SMODS.add_card({ set = 'Constellation' })
            G.GAME.consumeable_buffer = 0
            return true
          end
        }))
        return { message = localize('rainydays_plus_constellation'), colour = G.C.SECONDARY_SET.Constellation }
      end
    end
  end,
  
  draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
      G.shared_seals[card.seal].role.draw_major = card
      G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
      G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
  end
}