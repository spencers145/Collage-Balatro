SMODS.Joker{ --License Plate
    key = "licenseplate",
    config = {
        extra = {
            mult = 6
        }
    },
    loc_txt = {
        ['name'] = '{X:inactive}L{}{X:white,C:default}icense{} {X:white,C:default}Plate{}',
        ['text'] = {
            [1] = 'Each played {C:attention}6{}, {C:attention}7{},',
            [2] = '{C:attention}8{}, {C:attention}9{}, or {C:attention}10{} gives',
            [3] = '{C:red}+6{} Mult when scored'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

     calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 6 or
                context.other_card:get_id() == 7 or
                context.other_card:get_id() == 8 or
                context.other_card:get_id() == 9 or
                context.other_card:get_id() == 10 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}