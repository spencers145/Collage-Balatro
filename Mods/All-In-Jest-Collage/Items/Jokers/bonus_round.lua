local bonus_round = {
    object_type = "Joker",
    order = 311,
    
    key = "bonus_round",
    config = {
        extra = {
            retriggers = 1
        }
    },
    rarity = 2,
    pos = { x = 8, y = 12},
    atlas = 'joker_atlas',
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    enhancement_gate = "m_bonus",
  
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    end,
  
    calculate = function(self, card, context)
        if context.repetition and context.other_card then
            if SMODS.get_enhancements(context.other_card)["m_bonus"] then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.retriggers,
                    card = card,
                }
            end
        end
    end
}
return { name = {"Jokers"}, items = {bonus_round} }
