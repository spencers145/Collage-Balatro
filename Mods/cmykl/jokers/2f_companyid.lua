SMODS.Joker{ --Company ID
    key = "companyid",
    config = {
        extra = {
            expenses = 0,
            chippy = 0,
        }
    },
    loc_txt = {
        ['name'] = '{C:planet}C{}ompany ID',
        ['text'] = {
            [1] = 'Gains {C:chips}+12{} Chips',
            [2] = 'if at least {C:money}$8{}',
            [3] = 'is spent during shop',
            [4] = '{C:inactive}(Currently{} {C:chips}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.chippy}}
    end,

    calculate = function(self, card, context)
        if context.money_altered and not context.blueprint then
            local spendy = to_number(context.amount)
            if spendy < 0 and card.ability.extra.expenses < 8 then
                card.ability.extra.expenses = card.ability.extra.expenses + (-spendy)
                if card.ability.extra.expenses >= 8 then
                    card.ability.extra.chippy = card.ability.extra.chippy + 12
                    return {
                        message = "Chipped In!"
                    }
                end
            end
        end
        if context.ending_shop then
            card.ability.extra.expenses = 0
        end
        if context.cardarea == G.jokers and context.joker_main  then
            
                return {
                    chips = card.ability.extra.chippy
                }
        end
    end
}