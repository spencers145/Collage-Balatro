SMODS.Joker({
    key = "dnd",
    atlas = "jokers",
    pos = {x = 6, y = 10},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pixel_size = {w = 41},
    config = {extra = {dollars = 1, gain = 1, last_reroll = 0}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.gain}}
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            card.ability.extra.last_reroll = G.GAME.round_scores.times_rerolled.amt
        end
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            if G.GAME.round_scores.times_rerolled.amt == card.ability.extra.last_reroll then
                card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.gain
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.GOLD
                }
            else
                card.ability.extra.last_reroll = G.GAME.round_scores.times_rerolled.amt
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.dollars > 0 then
            return card.ability.extra.dollars
        end
    end
})