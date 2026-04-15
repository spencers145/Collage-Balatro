function count_keys(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end
SMODS.Joker{ --Scrapbook
    key = "scrapbook",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Scrapbook',
        ['text'] = {
            [1] = '{X:red,C:white}X0.2{} Mult for each',
            [2] = 'unique {C:attention}suit{}, {C:attention}edition{},',
            [3] = '{C:attention}enhancement{}, and {C:attention}seal{}',
            [4] = 'in scored cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
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
    if context.cardarea ~= G.jokers or not context.joker_main then return end

    local unique_suits = {}
    local unique_editions = {}
    local unique_enhancements = {}
    local unique_seals = {}

    for _, played_card in ipairs(context.scoring_hand) do

        if (SMODS.get_enhancements(played_card)["m_stone"] or SMODS.get_enhancements(played_card)["m_wild"]) then
            unique_suits["Suitless"] = true
        elseif played_card.base.suit then
            unique_suits[played_card.base.suit] = true
        end 

        if played_card.edition and played_card.edition.key then
            unique_editions[played_card.edition.key] = true
        end

        if played_card.seal then
            unique_seals[played_card.seal] = true
        end

        local enhancements = SMODS.get_enhancements(played_card)    
        for enh_key, _ in pairs(enhancements) do
            unique_enhancements[enh_key] = true
        end
    end

    local total_uniques =
        count_keys(unique_suits) +
        count_keys(unique_editions) +
        count_keys(unique_enhancements) +
        count_keys(unique_seals)


    return {
        Xmult = (0.2 * total_uniques) + 1
    }

end
}