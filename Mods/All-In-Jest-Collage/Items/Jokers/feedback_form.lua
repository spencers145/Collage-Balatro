local feedback_form = {
    object_type = "Joker",
    order = 180,

    key = "feedback_form",
    config = {
      extra = {
          mult = 3
      }
    },
    rarity = 1,
    pos = { x = 23, y = 6},
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
            }
        }
    end,
  
    calculate = function(self, card, context)
        if context.joker_main then
            local different = true
            local enhancements = {}
            for i = 1, #context.scoring_hand do
                for k, v in pairs(SMODS.get_enhancements(context.scoring_hand[i])) do
                    if enhancements[k] == v then
                        different = false
                    end
                    enhancements[k] = v
                end
            end
            if different then
                return {
                    mult = card.ability.extra.mult * #context.scoring_hand
                }
            end
        end
    end
  
}
return { name = {"Jokers"}, items = {feedback_form} }
