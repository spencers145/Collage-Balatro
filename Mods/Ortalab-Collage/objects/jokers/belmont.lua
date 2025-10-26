SMODS.Joker({
    key = "belmont",
    atlas = "jokers",
    pos = {x = 8, y = 8},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {mult = 4}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        local count = 0
        if G.playing_cards then count = Ortalab.curses_in_deck() end
        return {vars = {card.ability.extra.mult, card.ability.extra.mult * count}}
    end,
    in_pool = function(self)
        return Ortalab.curses_in_deck() > 0
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = Ortalab.curses_in_deck()
            return {
                mult = card.ability.extra.mult * count
            }
        end
    end    
})