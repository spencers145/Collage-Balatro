---- local scapino = {
----     object_type = "Joker",
----     order = 106,

----     key = "scapino",
----     config = {
----         extra = {
----             reroll_sale = 2
----         }
----     },
----     rarity = 2,
----     pos = { x = 1, y = 4 },
----     atlas = 'joker_atlas',
----     cost = 6,
----     unlocked = true,
----     discovered = false,
----     blueprint_compat = false,
----     eternal_compat = true,
  
----     loc_vars = function(self, info_queue, card)
----         return {
----             vars = {
----                 card.ability.extra.reroll_sale
----             }
----         }
----     end,

----     add_to_deck = function(self, card, from_debuff)
----         G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + card.ability.extra.reroll_sale
----         G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost + card.ability.extra.reroll_sale)
----     end,
----     remove_from_deck = function(self, card, from_debuff)
----         G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - card.ability.extra.reroll_sale
----         G.GAME.current_round.reroll_cost = math.max(0, G.GAME.current_round.reroll_cost - card.ability.extra.reroll_sale)
----     end,
  
----     calculate = function(self, card, context)
      
----     end
  
---- }
---- return { name = {"Jokers"}, items = {scapino} }
