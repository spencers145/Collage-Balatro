---- local visage = {
----     object_type = "Joker",
----     order = 232,

----     key = "visage",
----     config = {
----         extra = {

----         }
----     },
----     rarity = 2,
----     pos = { x = 21, y = 8 },
----     atlas = 'joker_atlas',
----     cost = 8,
----     unlocked = true,
----     discovered = false,
----     blueprint_compat = true,
----     eternal_compat = true,

----     loc_vars = function(self, info_queue, card)
----         if G.jest_visage_last_sold and G.jest_visage_last_sold.cards[1] then
----             local other_joker = G.jest_visage_last_sold.cards[1]
----             local other_vars
----             if other_joker.config.center.loc_vars then
----                 other_vars = other_joker.config.center:loc_vars(info_queue, other_joker).vars
----             else
----                 other_vars, _, _ = other_joker:generate_UIBox_ability_table(true)
----             end
----             other_joker.config.center.specific_vars = other_vars
----             other_joker.config.center.specific_vars.aij_visage = true
----             info_queue[#info_queue + 1] = other_joker.config.center
----         end
----         return { vars = {} }
----     end,

----     calculate = function(self, card, context)
----         local other_joker = G.jest_visage_last_sold.cards[1]
----         return SMODS.blueprint_effect(card, other_joker, context)
----     end

---- }
---- local sell_card_ref = Card.sell_card
---- function Card:sell_card()
----     local ref = sell_card_ref(self)
----     if G.jokers and self.ability.set == 'Joker' then
----         G.jest_visage_last_sold.cards = {}
----         if not (self.ability.name == 'j_aij_visage' or self.ability.name == 'j_aij_clay_joker') then
----             local copied_card = copy_card(self, nil, 0) -- Creates a copy with 0 scale
----             G.jest_visage_last_sold:emplace(copied_card)
----         end
----     end
----     return ref
---- end

---- return { name = { "Jokers" }, items = { visage } }
