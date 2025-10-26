SMODS.Joker {
    key = "bat",
    config = {
      extra = {
        used=false,
      }
    },
    rarity = 2,
    pos = { x = 7, y = 2},
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
          vars = {
            card.ability.extra.used,
          }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.used=false
        end


        if context.destroy_card and (context.cardarea == G.play or context.cardarea == 'unscored') and #context.full_hand == 1 and card.ability.extra.used==false then
            SMODS.calculate_effect({message = localize('artb_bonk'), colour = G.C.MULT}, card)
            card.ability.extra.used=true
            return {remove = true}
       end
    end
    }