---- SMODS.Joker {
----   key = "master_spark",
----   config = {
----     extra = {
----       ready = false
----     }
----   },
----   rarity = 3,
----   pos = { x = 11, y = 7 },
----   atlas = "jokers_atlas",
----   cost = 8,
----   blueprint_compat = false,
----   eternal_compat = false,
----   perishable_compat = true,
----   paperback = {
----     requires_custom_suits = true,
----     requires_spectrum_or_suit = true
----   },

----   loc_vars = function(self, info_queue, card)
----     info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
----   end,

----   calculate = function(self, card, context)
----     if not context.blueprint and context.before and context.main_eval then
----       if PB_UTIL.contains_spectrum(context.poker_hands) then
----         card.ability.extra.ready = true
----       end
----     end

----     if not context.blueprint and context.destroy_card and context.cardarea == G.hand then
----       if card.ability.extra.ready then
----         return { remove = true, juice_card = card }
----       end
----     end

----     if not context.blueprint and context.after and context.main_eval and card.ability.extra.ready then
----       card.ability.extra.ready = false

----       for i, v in ipairs(context.full_hand) do
----         local silent = i < #context.full_hand
----         if not v.edition then
----           G.E_MANAGER:add_event(Event {
----             func = function()
----               if silent then v:juice_up(1, 0.5) end
----               v:set_edition('e_polychrome', true, silent)
----               return true
----             end
----           })
----         end
----       end

----       PB_UTIL.destroy_joker(card)

----       return {
----         message = localize('paperback_polychrome_ex'),
----         colour = G.C.DARK_EDITION
----       }
----     end
----   end
---- }
