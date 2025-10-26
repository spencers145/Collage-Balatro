SMODS.Joker {
  key = "pedrillo",
  config = {
    extra = {
      rank = 'Queen',
    }
  },

  rarity = 4,
  pos = { x = 12, y = 3 },
  soul_pos = { x = 13, y = 3 },
  atlas = "jokers_atlas",
  cost = 20,
  unlocked = true,
  discovered = false,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  calculate = function(self, card, context)
    if context.before then
      -- Check scoring hand for any Queen
      for _, v in ipairs(context.scoring_hand) do
        if PB_UTIL.is_rank(v, card.ability.extra.rank) then
          -- Level up
          return {
            card = card,
            level_up = true,
            message = localize('k_level_up_ex')
          }
        end
      end
    end
  end,
}
