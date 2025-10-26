PB_UTIL.MinorArcana {
  key = 'four_of_swords',
  config = {
    max_highlighted = 2,
  },
  atlas = 'minor_arcana_atlas',
  pos = { x = 3, y = 4 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.max_highlighted,
      }
    }
  end,

  use = function(self, card, area)
    local pool = {}

    for _, v in pairs(SMODS.Ranks) do
      if v.face then
        pool[#pool + 1] = v
      end
    end

    for _, playing_card in ipairs(G.playing_cards) do
      if PB_UTIL.is_rank(playing_card, 'paperback_Apostle') then
        table.insert(pool, SMODS.Ranks.paperback_Apostle)
        break
      end
    end

    PB_UTIL.use_consumable_animation(card, G.hand.highlighted, function()
      for _, v in ipairs(G.hand.highlighted) do
        local rank = pseudorandom_element(pool, pseudoseed('four_of_swords'))
        assert(SMODS.change_base(v, nil, rank.key))
      end
    end)
  end
}
