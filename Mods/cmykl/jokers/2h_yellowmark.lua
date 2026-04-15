SMODS.Joker{ --Yellow Mark
    key = "yellowmark",
    config = {
        extra = {
            dollars = 0
        }
    },
    loc_txt = {
        ['name'] = '{C:money}Y{}ellow Mark',
        ['text'] = {
            'Earn {C:money}$2{} at end of',
            'round for each {C:attention}Voucher{}',
            'redeemed this run',
            '{C:inactive}(Currently{} {C:money}$#1#{}{C:inactive}){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = { (card.ability.extra.dollars) or 0}}
    end,

    calculate = function(self, card, context)
        local total = 0
        for _, _ in pairs(G.GAME.used_vouchers) do
            total = total + 1
        end
        card.ability.extra.dollars = 2 * total
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.dollars > 0 then
            return card.ability.extra.dollars
        end
    end,
}