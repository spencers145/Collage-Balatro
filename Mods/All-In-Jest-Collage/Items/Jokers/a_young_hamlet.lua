local a_young_hamlet = {
    object_type = "Joker",
    order = 362,

    key = "a_young_hamlet",
    config = {
        extra = {
            xmult = 1,
            xmult_mod = 0.05,
            discards = 5,
            discards_remaining = 5,
        }
    },
    rarity = 2,
    pos = { x = 20, y = 19 },
    atlas = 'joker_atlas',
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.xmult,
                card.ability.extra.xmult_mod,
                card.ability.extra.discards,
                card.ability.extra.discards_remaining,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            if card.ability.extra.discards_remaining <= 1 then
                card.ability.extra.discards_remaining = card.ability.extra.discards
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "xmult_mod",
                    operation = '+',
                })
            else
                card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                return nil, true
            end
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end

}
return { name = { "Jokers" }, items = { a_young_hamlet } }
