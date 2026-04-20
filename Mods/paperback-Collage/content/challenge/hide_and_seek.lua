SMODS.Challenge {
  key = "hide_and_seek",
  jokers = {
    {
      id = 'j_paperback_subterfuge',
      eternal = true
    },
    {
      id = 'j_paperback_the_world',
      eternal = true
    }
  },

  restrictions = {
    banned_cards = PB_UTIL.banned_challenge_centers {
      'c_paperback_two_of_pentacles',
      'c_paperback_nine_of_swords'
    }
  }
}
