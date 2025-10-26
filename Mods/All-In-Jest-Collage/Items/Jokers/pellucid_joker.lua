---- local pellucid_joker = {
----     object_type = "Joker",
----     order = 142,

----     key = "pellucid_joker",
----     config = {
      
----     },
----     rarity = 2,
----     pos = { x = 11, y = 5 },
----     atlas = 'joker_atlas',
----     cost = 6,
----     unlocked = true,
----     discovered = false,
----     blueprint_compat = false,
----     eternal_compat = true,
  
----     loc_vars = function(self, info_queue, card)
  
----     end,
  
----     calculate = function(self, card, context)
      
----     end
  
---- }
---- local start_dissolve_ref = Card.start_dissolve
---- function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
----   local ref = start_dissolve_ref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
----   if G.jokers and self.ability.set == 'Joker' and self.edition ~= nil then
----     local has_pellucid_joker = SMODS.find_card("j_aij_pellucid_joker")
----     if has_pellucid_joker then
----         for k, v in pairs(has_pellucid_joker) do
----             local _card = create_playing_card({
----                 front = pseudorandom_element(G.P_CARDS, pseudoseed('pellucid_joker')),
----                 center = G.P_CENTERS.c_base}, v, true, nil, {G.C.SECONDARY_SET.Enhanced}, true)
----             _card:set_edition(self.edition)
----             _card:start_materialize()
----             G.E_MANAGER:add_event(Event({
----                 trigger = 'after',
----                 delay = 0.3,
----                 func = function()
----                     G.deck:emplace(_card)
----                     G.deck.config.card_limit = G.deck.config.card_limit + 1
----                     return true
----                 end}))
----             playing_card_joker_effects({_card})
----         end
----     end
----   end
----   return ref
---- end
---- return { name = {"Jokers"}, items = {pellucid_joker} }
