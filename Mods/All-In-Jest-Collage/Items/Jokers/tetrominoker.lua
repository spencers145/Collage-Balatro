local tetrominoker = {
    object_type = "Joker",
    order = 281,
    key = "tetrominoker",
    config = {
      extra = {
          odds = 4
      }
    },
    rarity = 3,
    pos = { x = 4, y = 11},
    atlas = 'joker_atlas',
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)

    end,
  
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 4 then
                return {
                    x_mult = 1.4,
                    card = card
                }
            end
        end
    end
  
}
return { name = {"Jokers"}, items = {tetrominoker} }
