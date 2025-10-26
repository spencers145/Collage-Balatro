SMODS.Joker({
    key = "heresy",
    atlas = "jokers",
    pos = {x = 9, y = 7},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {extra = {chips = 0, mult = 0, chip_gain = 5, mult_gain = 2}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chip_gain, card.ability.extra.mult_gain, card.ability.extra.chips, card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.playing_card_added and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_value = "chip_gain",
                message_colour = G.C.BLUE,
                operation = function(ref_table, ref_value, initial, scaling)
                    ref_table[ref_value] = initial + #context.cards * scaling
                end
            })
        end
        if context.remove_playing_cards and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_gain",
                message_colour = G.C.RED,
                operation = function(ref_table, ref_value, initial, scaling)
                    ref_table[ref_value] = initial + #context.removed * scaling
                end
            })
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end    
})