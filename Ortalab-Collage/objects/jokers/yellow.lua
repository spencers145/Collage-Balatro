SMODS.Joker({
    key = "yellow",
    atlas = "jokers",
    pos = {x = 0, y = 14},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {gain = 1, mult = 0}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.before or context.pre_discard and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "gain",
                message_colour = G.C.RED,
                operation = function(ref_table, ref_value, initial, scaling)
                    ref_table[ref_value] = initial + (context.scoring_hand and #context.scoring_hand or #context.full_hand)*scaling
                end
            })
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.mult = 0
            return {
                message = localize('ortalab_joker_miles_reset')
            }
        end
    end    
})