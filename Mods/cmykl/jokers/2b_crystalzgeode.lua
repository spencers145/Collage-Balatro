--[[SMODS.Joker{ --Crystal Geode
    key = "crystalgeode",
    config = {
        extra = {
            odds = 3,
            dollars = 12
        }
    },
    loc_txt = {
        ['name'] = 'Crystal Geode',
        ['text'] = {
            [1] = 'if {C:attention}Stone Card{} is scored,',
            [2] = '{C:green}#1# in #2#{} chance to',
            [3] = 'destroy it and earn {C:money}$12{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 1
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl__010quartzgeode') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
    if context.destroy_card and context.destroy_card.should_destroy  then
        return { remove = true }
    end
    if context.individual and context.cardarea == G.play then
        if SMODS.get_enhancements(context.other_card)["m_stone"] == true then
            if SMODS.pseudorandom_probability(card, 'group_0_95bc3758', 1, card.ability.extra.odds, 'mined') then
                context.other_card.should_destroy = true
                SMODS.calculate_effect({message = "Shiny!"}, card)
                return {
                    dollars = card.ability.extra.dollars,
                }
            end
        end
    end
end
}
]]