--[[PB_UTIL.Sleeve {
  key = 'proud',
  deck_buff = 'b_paperback_proud',
  atlas = 'card_sleeves_atlas',
  pos = { x = 1, y = 0 },
  unlocked = true,

  apply = function(self, sleeve)
    if self:is_buffed() then
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
    else
      G.E_MANAGER:add_event(Event({
        func = function ()
          for i = 1, 1 do
            SMODS.add_card({key = 'c_lovers'})
          end

          SMODS.add_card({key = 'j_paperback_pride_flag'})
          return true
        end
      }))
    end
  end
}
]]