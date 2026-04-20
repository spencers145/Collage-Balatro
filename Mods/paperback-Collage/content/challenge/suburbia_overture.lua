SMODS.Challenge {
  key = 'suburbia_overture',
  jokers = {
    { id = "j_paperback_the_normal_joker", eternal = true },
  },
  rules = {
    custom = {
      { id = "paperback_banned_non_common_jokers" }
    }
  },

  restrictions = {
    banned_cards = PB_UTIL.banned_challenge_centers {
      'c_paperback_nine_of_cups',
      'c_paperback_king_of_wands',
      'c_soul',
    },

    banned_tags = {
      { id = 'tag_rare' },
      { id = 'tag_uncommon' },
    },
  },

  apply = function(self)
    G.E_MANAGER:add_event(Event {
      func = function()
        for k, v in pairs(G.P_CENTERS) do
          if v.is_rarity and not v.is_rarity(1) then
            G.GAME.paperback.banned_run_keys[k] = true
          end
        end
        return true
      end
    })
  end
}
