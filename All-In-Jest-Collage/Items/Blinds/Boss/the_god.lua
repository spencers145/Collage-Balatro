---- local the_god = {
----     object_type = "Blind",
----     key = 'the_god',
    
----     boss = {
----         min = 1,
----     },
----     mult = 2,
----     boss_colour = HEX("9badaf"),
----     atlas = 'blinds',
----     pos = { X = 0, y = 48},
----     order = 31,
----     dollars = 5,


----     calculate = function(self, card, context)
        
----     end,
----     -- just ortalab's The Tarot
----     debuff_hand = function(self, cards, hand, handname, check)
----         local _,_,_,scoring_hand,_ = G.FUNCS.get_poker_hand_info(cards)
----         local always_scores_count = 0
----         for _, card in pairs(cards) do
----             if card.config.center.always_scores then always_scores_count = always_scores_count + 1 end
----         end
----         if #scoring_hand + always_scores_count ~= #cards then return true end
----     end,

---- }
---- return { name = {"Blinds"}, items = {the_god} }