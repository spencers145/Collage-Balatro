PB_UTIL.Sleeve {
  key = 'silver',
  deck_buff = 'b_paperback_silver',
  atlas = 'card_sleeves_atlas',
  pos = { x = 2, y = 0 },
  config = {
    consumables = {
      'c_paperback_king_of_cups',
      'c_paperback_eight_of_swords'
    }
  },
  unlocked = true,

  loc_vars = function(self)
    return {
      key = self:loc_key(),
      vars = {
        localize { type = 'name_text', key = 'c_paperback_king_of_cups', set = 'paperback_minor_arcana' },
        localize { type = 'name_text', key = 'c_paperback_eight_of_swords', set = 'paperback_minor_arcana' }
      }
    }
  end,
}