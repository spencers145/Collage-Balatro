local bad_guy = {
    object_type = "Joker",
    order = 368,
    
    key = "bad_guy",
    config = {

    },

    rarity = 2,
    pos = { x = 1, y = 20},
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
  
    loc_vars = function(self, info_queue, card)
        if not card.edition or (card.edition and not card.edition.key == 'e_foil') then
        info_queue[#info_queue+1] = G.P_CENTERS.e_foil end
    end,
  
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss and #G.hand.cards > 0 then
            -- steal the sarc function. i really am the bad guy....................
            local indices = SARC.get_rand_hand_index(2,nil,nil,nil,true)

            for key, value in pairs(indices) do
                G.hand.cards[value]:set_edition('e_foil')
            end

            return {
                message = localize('k_aij_foiled_again'),
            }
        end
    end
  
}
return { name = {"Jokers"}, items = {bad_guy} }
