SMODS.Consumable({
  key = 'mod_collectable',
  set = 'collectable',
  atlas = 'collectable_atlas',
  pos = { x = 5, y = 2 },
  soul_pos = { x = 5, y = 3 },
  discovered = true,
  config = {
    extra = {

    }
  },
  cost = 1,
  can_use = function(self, card)
    return #G.hand.highlighted == 1
  end,
  loc_vars = function(self, info_queue, card)
    if card.ability.extra.seal then
      info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
      return { vars = { localize { type = 'name_text', key = card.ability.extra.seal:lower() .. '_seal', set = 'Other' }, } }
    elseif card.ability.extra.enhancement then
      info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.enhancement]
      return { vars = { localize { type = 'name_text', key = card.ability.extra.enhancement, set = 'Enhanced' }, } }
    elseif card.ability.extra.edition then
      info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.edition]
      return { vars = { localize { type = 'name_text', key = card.ability.extra.edition, set = 'Edition' }, } }
    end
    return { key = self.key .. '_empty' }
  end,
  use = function(self, card, area)
    local mod_card = G.hand.highlighted[1]

    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))

    if card.ability.extra.enhancement then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          mod_card:flip()
          play_sound('card1')
          mod_card:juice_up(0.3, 0.3)
          return true
        end
      }))
      delay(0.2)
    end

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        if card.ability.extra.seal then
          mod_card:set_seal(card.ability.extra.seal, nil, true)
        elseif card.ability.extra.enhancement then
          mod_card:set_ability(card.ability.extra.enhancement)
        elseif card.ability.extra.edition then
          mod_card:set_edition(card.ability.extra.edition)
        end
        return true
      end
    }))

    if card.ability.extra.enhancement then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.15,
        func = function()
          mod_card:flip()
          play_sound('tarot2', 1, 0.6)
          mod_card:juice_up(0.3, 0.3)
          return true
        end
      }))
    end

    delay(0.5)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        G.hand:unhighlight_all(); return true
      end

    }))
  end,
  in_pool = function(self, args)
    return false
  end,
  set_sprites = function(self, card, front)
    local key = card.ability and card.ability.extra and
        (card.ability.extra.enhancement or card.ability.extra.seal or card.ability.extra.edition) or nil
    local ref_values = key and ArtBox.Collectables[key]
    if ref_values then
      card.children.center.atlas = G.ASSET_ATLAS[ref_values.atlas]
      card.children.center:set_sprite_pos(ref_values.pos)

      card.children.floating_sprite = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS[ref_values.atlas],
        ref_values.soul_pos)
      card.children.floating_sprite.role.draw_major = card
      card.children.floating_sprite.states.hover.can = false
      card.children.floating_sprite.states.click.can = false

      card.ability.extra.shader = ref_values.shader
    end
  end
})

local cc = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
  local card = cc(other, new_card, card_scale, playing_card, strip_edition)
  if card.config.center.key == 'c_artb_mod_collectable' then
    card:set_sprites(card.config.center)
  end
  return card
end

-- Overflow stacking compat

if Overflow then
  Overflow.blacklist["collectable"] = true
end
