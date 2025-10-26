-- this file isn't actually loaded. i decided not to include this custom poker hand in the mod because i got lazy to implement all the jokers and planets. oh well.

local crowd = SMODS.PokerHand({
    key = "crowd",
    chips = 30,
    mult = 5,
    l_chips = 30,
    l_mult = 3,
    example = {
        { 'D_K', true },
        { 'C_K', true },
        { 'D_Q', true },
        { 'H_J', true },
        { 'S_Q', true }
    },
    loc_txt = {
        name = "Crowd",
        description = {
            "5 face cards with at least",
            "one Jack, Queen and King"
        }
    },
    evaluate = function(parts, hand) 
        local jacks, queens, kings, faces = 0, 0, 0, 0
        for i=1, #hand do
            if hand[i]:is_face() then faces = faces + 1 end
            if hand[i]:get_id() == 11 then jacks = jacks + 1 end
            if hand[i]:get_id() == 12 then queens = queens + 1 end
            if hand[i]:get_id() == 13 then kings = kings + 1 end
        end
        if faces >= 5 and jacks > 0 and queens > 0 and kings > 0 then
            return {hand}
        end
        return {}
    end
})

local crowdflush = SMODS.PokerHand({
    key = "crowd_flush",
    chips = 110,
    mult = 14,
    l_chips = 40,
    l_mult = 4,
    example = {
        { 'C_J', true },
        { 'C_K', true },
        { 'C_Q', true },
        { 'C_J', true },
        { 'C_K', true }
    },
    loc_txt = {
        name = "Crowd Flush",
        description = {
            "5 face cards that share the same suit,",
            "with at least one Jack, Queen and King"
        }
    },
    evaluate = function(parts, hand) 
        local jacks, queens, kings, faces = 0, 0, 0, 0
        for i=1, #hand do
            if hand[i]:is_face() then faces = faces + 1 end
            if hand[i]:get_id() == 11 then jacks = jacks + 1 end
            if hand[i]:get_id() == 12 then queens = queens + 1 end
            if hand[i]:get_id() == 13 then kings = kings + 1 end
        end
        if faces >= 5 and jacks > 0 and queens > 0 and kings > 0 and #parts._flush > 0 then
            return {hand}
        end
        return {}
    end,
    visible = true
})