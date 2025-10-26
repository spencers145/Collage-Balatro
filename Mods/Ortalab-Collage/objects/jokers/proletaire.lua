SMODS.Joker({
    key = "proletaire",
    atlas = "jokers",
    pos = {x = 0, y = 15},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {xmult = 1, gain = 0.75}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, card.ability.extra.xmult + (self.count_cursed_jokers()*card.ability.extra.gain)}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult + (self.count_cursed_jokers()*card.ability.extra.gain)
            }
        end
    end,
    count_cursed_jokers = function()
        local cursed_cards = 0
        if not G.jokers then return cursed_cards end
        for _, card in pairs(SMODS.merge_lists({G.jokers.cards, G.consumeables.cards})) do
            if card.ability.set == 'Joker' and card.curse then cursed_cards = cursed_cards + 1 end
        end
        return cursed_cards
    end    
})