---- local test_card = {
----     object_type = "Joker",
----     order = 296,
    
----     key = "test_card",
----     config = {
       
----     },
----     rarity = 2,
----     pos = { x = 16, y = 11},
----     atlas = 'joker_atlas',
----     cost = 6,
----     unlocked = true,
----     discovered = false,
----     blueprint_compat = false,
----     eternal_compat = true,

----     in_pool = function(self, args)
----         if G.deck then
----             if #G.deck.cards > 0 then
----                 for i = 1, #G.deck.cards do
----                     if G.deck.cards[i].edition ~= nil and not G.deck.cards[i].edition.negative then
----                         return true
----                     end
----                 end
----             end
----         end
----         return false
----     end,
  
----     loc_vars = function(self, info_queue, card)
  
----     end,
  
----     calculate = function(self, card, context)
----         if context.individual and context.cardarea == G.hand and not context.end_of_round then
----             if context.other_card.edition ~= nil then
----                 SMODS.calculate_effect(context.other_card.edition,context.other_card)
----             end
----         end
----         --if context.individual and context.cardarea == G.hand and not context.end_of_round then
----         --    if context.other_card.edition ~= nil then
----         --        local text,disp_text,poker_hands,scoring_hand= G.FUNCS.get_poker_hand_info(G.play.cards)
----         --        SMODS.score_card(context.other_card, {cardarea = G.play, full_hand = G.play.cards, scoring_hand = scoring_hand, scoring_name = text, poker_hands = poker_hands, post_joker = true, edition = true, pre_joker = true})
----         --    end
----         --end
----     end
  
---- }
---- return { name = {"Jokers"}, items = {test_card} }
