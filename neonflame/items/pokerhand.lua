---- SMODS.PokerHand {
----    key = "nflame_generic",
----    visible = false,
----    chips = 50,
----    mult = 10,
----    l_mult = 1,
----    l_chips = 10,

----    example = {
----       { "C_Q", true },
----       { "S_2", true },
----       { "C_6", true },
----       { "D_7", true },
----       { "H_J", true }
----    },

----    -- it should ALWAYS take prio
----    order_offset = 99999,

----    evaluate = function(parts, hand)
----       if next(SMODS.find_card("j_nflame_genplanet")) then return { hand } end
----    end
---- }

---- SMODS.Joker {
----    name = "Blind Telescope",
----    key = "genplanet",

----    atlas = "jokers1",
----    pos = { x = 3, y = 1 },
   
----    rarity = 2,
----    cost = 7,
----    blueprint_compat = false,
----    eternal_compat = true,
----    perishable_compat = true,

----    add_to_deck = function(self, card)
----        G.GAME.hands['nflame_generic'].visible = true
----    end,

----    remove_from_deck = function(self, card, from_debuff)
----       G.GAME.hands['nflame_generic'].visible = false
----    end,
---- }


---- local ref_levelup = level_up_hand
---- function level_up_hand(card, hand, instant, amount, ...)
----    local rt = ref_levelup(card, hand, instant, amount, ...)
----    if next(SMODS.find_card("j_nflame_genplanet")) and hand ~= "nflame_generic" then
----       ref_levelup(card, "nflame_generic", true, amount, ...)
----    end

----    return rt
---- end
