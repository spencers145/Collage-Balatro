SMODS.Joker {
    key = "transparent_joker",
    config = {
      extra = {
        mult=2,
      }
    },
    rarity = 1,
    pos = { x = 3, y = 3},
    soul_pos = {x=4, y=3},
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.mult,
          }
        }
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and (#G.play.cards - #context.scoring_hand)>0 then
                return{
                    mult=card.ability.extra.mult * (#G.play.cards - #context.scoring_hand)
                }
        end
    end
}