SMODS.Joker{ --Matching Color Chip
    key = "matchingcolorchip",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = '{V:1}M{}atching Color Chip',
        ['text'] = {
            [1] = 'Gains {C:red}+2{} Mult when a',
            [2] = 'scoring hand has at least {C:attention}3{}',
            [3] = 'cards of the {C:attention}same suit{}',
            [4] = '{C:inactive}(Currently{} {C:red}+#1#{} {C:inactive}Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            card.ability.extra.mult, 
            colours = { HEX('e974db') }
            },
    }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and not context.blueprint then
            local sCount = 0
            local cCount = 0
            local dCount = 0
            local hCount = 0
            for i, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit("Spades") then
                    sCount = sCount + 1
                end
                if playing_card:is_suit("Clubs") then
                    cCount = cCount + 1
                end
                if playing_card:is_suit("Diamonds") then
                    dCount = dCount + 1
                end
                if playing_card:is_suit("Hearts") then
                    hCount = hCount + 1
                end
            end
            if (sCount >= 3) or (cCount >= 3) or (dCount >= 3) or (hCount >= 3)  then
                card.ability.extra.mult = (card.ability.extra.mult) + 2
            end
            return {
                            mult = card.ability.extra.mult
                        }
                    end
                end
}