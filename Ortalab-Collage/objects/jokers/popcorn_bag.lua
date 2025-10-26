SMODS.Joker({
	key = "popcorn_bag",
	atlas = "jokers",
	pos = {x = 3, y = 6},
    rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
    config = {extra = {a_mult = 0, a_mult_add = 5, cap = 40}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.a_mult, card.ability.extra.a_mult_add, card.ability.extra.cap}}
    end,
    calculate = function(self, card, context) --Popcorn Bag Logic
        if not context.blueprint and not context.retrigger_joker and context.end_of_round and context.main_eval then
            if card.ability.extra.a_mult + card.ability.extra.a_mult_add > card.ability.extra.cap then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize('ortalab_explode'),
                    colour = G.C.RED
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "a_mult",
                    scalar_value = "a_mult_add",
                    message_key = 'a_mult'
                })
            end
        end
        if context.joker_main then
            if card.ability.extra.a_mult > 0 then
                return {
                    mult = card.ability.extra.a_mult
                }
            end
        end
    end
})
