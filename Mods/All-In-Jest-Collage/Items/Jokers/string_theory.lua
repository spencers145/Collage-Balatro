local get_straight_ref = get_straight

function get_straight(hand, min_length, skip, wrap)
    if not next(SMODS.find_card("j_aij_string_theory")) or #hand == 0 then return get_straight_ref(hand, min_length, skip, wrap)
    else
        local straight = {}
        for _,v in ipairs(hand) do
            straight[#straight+1] = v
        end
        local ret = {}
        ret[1] = straight
        return ret
    end
end
local string_theory = {
    object_type = "Joker",
    order = 94,
    
    key = "string_theory",
    config = {
      
    },
    rarity = 3,
    pos = { x = 14, y = 3 },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
  
    end,
  
    calculate = function(self, card, context)
        if context.poker_hands and context.scoring_hand and not next(context.poker_hands["Straight"]) then
            table.insert(context.poker_hands["Straight"], context.scoring_hand)
        end
    end
  
}
return { name = {"Jokers"}, items = {string_theory} }