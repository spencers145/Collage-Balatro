SMODS.Shader {
  key = 'dichrome',
  path = 'dichrome.fs'
}

SMODS.Sound {
  key = 'dichrome',
  path = 'dichrome.ogg'
}

SMODS.Edition {
  key = 'dichrome',
  shader = 'dichrome',
  config = {
    amount = 1
  },
  sound = {
    sound = 'paperback_dichrome',
    per = 1,
    vol = 0.4
  },
  discovered = false,
  weight = 6,     -- a bit less rare than polychrome
  in_shop = true,
  extra_cost = 5, -- As expensive as polychrome

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card.edition or {}).amount or self.config.amount
      }
    }
  end,

  calculate = function(self, card, context)
    if context.setting_blind and card.ability.set ~= 'Default' then
      G.E_MANAGER:add_event(Event {
        trigger = 'after',
        delay = 1,
        func = function()
          local res = PB_UTIL.get_lowest_hand_discard()
          -- Pick hands over discards
          local func = res.hands and ease_hands_played or ease_discard
          local message = res.hands and 'a_hands' or 'paperback_a_discards'

          func(card.edition.amount, true)

          SMODS.calculate_effect({
            message = localize {
              type = 'variable',
              key = message .. (res.amt < 0 and '_minus' or ''),
              vars = { card.edition.amount }
            },
            colour = res.hands and G.C.CHIPS or G.C.MULT,
            instant = true
          }, card)
          return true
        end
      })
    end
  end
}

-- Prevent Dichrome edition being added to non-jokers
local poll_edition_ref = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed, _options)
  local removed1, removed2, removed3, pos1, pos2, pos3

  if _no_neg or G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins < 4 then
    for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
      if v.key == 'e_paperback_dichrome' then
        pos1 = i
        removed1 = table.remove(G.P_CENTER_POOLS.Edition, i)
        break
      elseif v.key == 'e_ortalab_anaglyphic' then
        pos2 = i
        removed2 = table.remove(G.P_CENTER_POOLS.Edition, i)
      end
    end
  end

  if G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins < 4 then
    for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
      if v.key == 'e_ortalab_greyscale' then
        pos3 = i
        removed3 = table.remove(G.P_CENTER_POOLS.Edition, i)
        break
      end
    end
  end

  local ret = poll_edition_ref(_key, _mod, _no_neg, _guaranteed, _options)

  if removed1 and pos1 then
    table.insert(G.P_CENTER_POOLS.Edition, pos1, removed1)
  end
  if removed2 and pos2 then
    table.insert(G.P_CENTER_POOLS.Edition, pos2, removed2)
  end
  if removed3 and pos3 then
    table.insert(G.P_CENTER_POOLS.Edition, pos3, removed3)
  end

  return ret
end
