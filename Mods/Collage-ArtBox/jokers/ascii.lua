SMODS.Joker {
  key = "ascii",
  config = {
    extra = {
      mult = 2,
      ranks = {},
      rank_count = 0
    }
  },
  rarity = 3,
  pos = { x = 3, y = 4 },
  atlas = 'joker_atlas',
  cost = 8,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pixel_size = { w = 68, h = 92 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.hand and not context.other_card.debuff and not context.end_of_round then
      local rank = not SMODS.has_no_rank(context.other_card) and context.other_card:get_id()
      if rank and not card.ability.extra.ranks[tostring(rank)] then
        card.ability.extra.ranks[tostring(rank)] = true
        card.ability.extra.rank_count = card.ability.extra.rank_count + 1
      end

      if card.ability.extra.rank_count > 0 then
        return {
          mult = card.ability.extra.mult * card.ability.extra.rank_count,
          message_card = context.other_card
        }
      end
    end

    if context.after then
      card.ability.extra.ranks = {}
      card.ability.extra.rank_count = 0
    end
  end
}
