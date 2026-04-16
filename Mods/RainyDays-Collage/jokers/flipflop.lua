SMODS.Joker {
  key = 'flipflop',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('flipflop_even'),
  config = {
    extra = {
      plus_xmult = 2,
      plus_chips = 100,
      state = 0
    }
  },
  
  set_ability = function(self, card, initial, delay_sprites)
    card.ability.extra.state = pseudorandom_element({ 0, 1 }, pseudoseed('flipflop' .. G.GAME.round_resets.ante))
    if card.ability and card.ability.extra.state == 1 and (card.config.center.discovered or card.bypass_discovery_center) then
      card.children.center:set_sprite_pos(RainyDays.GetJokersAtlasTable('flipflop_odd'))
    end
  end,
  
  loc_vars = function(self, info_queue, card)
    return {
      key = card.ability.extra.state == 0 and 'j_RainyDays_flipflop_even' or 'j_RainyDays_flipflop_odd',
      vars = {
        card.ability.extra.plus_xmult,
        card.ability.extra.plus_chips
      }
    }
  end,
  
  set_sprites = function(self, card, front)
    if card.ability and card.ability.extra.state == 1 and (card.config.center.discovered or card.bypass_discovery_center) then
      card.children.center:set_sprite_pos(RainyDays.GetJokersAtlasTable('flipflop_odd'))
    end
  end,
  
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      if not context.blueprint then
        G.E_MANAGER:add_event(Event({ 
          trigger = 'before',
          delay = 0.1,
          blockable = false,
          blocking = false,
          func = function()
            card:flip()
            card.ability.extra.state = card.ability.extra.state == 1 and 0 or 1
            card.children.center:set_sprite_pos(RainyDays.GetJokersAtlasTable(card.ability.extra.state == 0 and 'flipflop_even' or 'flipflop_odd'))
            card:flip()
            return true
          end
        }))
      end
      return {
        chips = card.ability.extra.state == 1 and card.ability.extra.plus_chips or nil,
        xmult = card.ability.extra.state == 0 and card.ability.extra.plus_xmult or nil
      }
    end
  end
}