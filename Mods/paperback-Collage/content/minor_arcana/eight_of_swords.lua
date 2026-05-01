PB_UTIL.MinorArcana {
  key = 'eight_of_swords',
  config = {
    max_highlighted = 5,
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 0, y = 5 },
  paperback = {
    requires_paperclips = true
  },
  paperback_credit = {
    coder = { 'dowfrin' }
  },
  can_use = function ()
    return G.hand and G.hand.cards and #G.hand.cards > 0
  end,

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.max_highlighted,
      }
    }
  end,

  use = function(self, card, area)
    local clip1 = PB_UTIL.poll_paperclip('eight_of_swords')
    local clip2 = PB_UTIL.poll_paperclip('eight_of_swords')
    local clip3 = PB_UTIL.poll_paperclip('eight_of_swords')
    PB_UTIL.use_consumable_animation(card, G.hand.cards, function()
      for _, v in ipairs(G.hand.cards) do
        PB_UTIL.set_paperclip(v, pseudorandom_element({clip1, clip2, clip3}, pseudoseed('eight_of_swords')))
      end
    end)
  end
}
