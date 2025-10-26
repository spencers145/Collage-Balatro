SMODS.Joker({
    key = "newton",
    atlas = "jokers",
    pos = {x = 3, y = 15},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {gain = 100}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = G.GAME.current_round.hands_played == 0 and -math.min(context.retrigger_joker and math.max(hand_chips - card.ability.extra.gain, 0) or hand_chips, card.ability.extra.gain) or card.ability.extra.gain,
            }
        end
    end    
})