local word_art = {
    object_type = "Joker",
    order = 41,
   

    key = "word_art",
    config = {
      extra = {
        xmult_per_card = 0.4
      }
    },
    rarity = 3,
    pos = { x = 13, y = 1 },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult_per_card
            }
        }
    end,
  
    calculate = function(self, card, context)
        local _cards = 0
        if context.full_hand then
            for _, p_card_in_full_hand in ipairs(context.full_hand) do
                if p_card_in_full_hand:get_id() == 11 or p_card_in_full_hand:get_id() == 12 or p_card_in_full_hand:get_id() == 13 or p_card_in_full_hand:get_id() == 14 then
                    _cards = _cards + 1
                end
            end
        end
        if _cards > 0 and context.joker_main then
            return {
                xmult = 1 + card.ability.extra.xmult_per_card * _cards
            }
        end
    end
  
}
return { name = {"Jokers"}, items = {word_art} }
