---- local the_giant = {
----     object_type = "Blind",
----     key = 'the_giant',

----     boss = {
----         min = 4,
----     },
----     mult = 6,
----     boss_colour = HEX("7a73bb"),
----     atlas = 'blinds',
----     pos = { X = 0, y = 47},
----     order = 26,
----     dollars = 5,


----     calculate = function(self, card, context)
        
----     end,
----     set_blind = function(self)
----         ease_hands_played(2)
----     end,

----     disable = function(self)
----         ease_hands_played(-2)
----         G.GAME.blind.chips = G.GAME.blind.chips/3
----         G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
----     end,

----     defeat = function(self)
----         local temp = G.GAME.blind and G.GAME.blind.disabled
----         if temp then
----             return
----         end
----         if not temp then
----             ease_hands_played(-2)
----         end
----     end,

---- }
---- return { name = {"Blinds"}, items = {the_giant} }