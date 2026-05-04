PB_UTIL.Sleeve {
  key = 'proud',
  deck_buff = 'b_paperback_proud',
  atlas = 'card_sleeves_atlas',
  pos = { x = 1, y = 0 },

  config = {
    consumables = {
      'c_lovers',
      'c_lovers',
    }
  },
  unlocked = true,

  loc_vars = function(self)
    return {
      key = self:loc_key(),
      vars = {
        localize { type = 'name_text', key = 'c_lovers', set = 'Tarot' },
      }
    }
  end,

  apply = function(self, sleeve)
    -- Apply polychrome to all Aces
    G.E_MANAGER:add_event(Event {
      func = function()
        for _, v in ipairs(G.playing_cards or {}) do
          if v:get_id() == 14 then
            v:set_edition('e_polychrome', true, true)
          end
        end
        return true
      end
    })
  end
}
