local null_joker = {
    object_type = "Joker",
    order = 87,

    key = "null_joker",
    config = {
        extra = { prob = 0.01 }
    },
    rarity = 3,
    pos = { x = 7, y = 3 },
    atlas = 'joker_atlas',
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.prob}}
    end,

    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.prob
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        if not from_debuff then
            G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.prob
        end
    end,

    calculate = function(self, card, context)

    end
}
return { name = {"Jokers"}, items = {null_joker} }
