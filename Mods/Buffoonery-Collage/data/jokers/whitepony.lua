SMODS.Joker {
    key = "whitepony",
    name = "White Pony",
    atlas = 'buf_jokers',
    pos = {
        x = 0,
        y = 1,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { mult = 3, mult_gain = 2 },
		numetal = true
    },
    loc_txt = {set = 'Joker', key = 'j_buf_whitepony'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.mult_gain}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card and G.GAME.blind.boss then
            card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.mult_gain
            return {
                message = localize('buf_doubled'),
                colour = G.C.MULT,
                card = card
            }
        end
    end
}