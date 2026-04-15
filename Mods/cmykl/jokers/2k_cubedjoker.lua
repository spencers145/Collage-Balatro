
SMODS.Joker{ --Cubed Joker
    key = "cubedjoker",
    config = {
        extra = {
            mult = 2,
        }
    },
    loc_txt = {
        ['name'] = 'Cubed Joker',
        ['text'] = {
            [1] = '{C:red}+#1#{} Mult for each',
            [2] = '{C:attention}3{}, {C:attention}8{}, and {C:attention}9{} in',
            [3] = 'your full deck',
            [4] = '{C:inactive}(Currently{} {C:red}+#2#{}{C:inactive} Mult){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
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
        local count = 0
        if G.playing_cards then
            for key, value in pairs(G.playing_cards) do
                if value:get_id() == 3 or value:get_id() == 8 or value:get_id() == 9 then
                    count = count + 1
                end
            end
        end
        
        return {vars = {card.ability.extra.mult, card.ability.extra.mult*count}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for key, value in pairs(G.playing_cards) do
                if value:get_id() == 3 or value:get_id() == 8 or value:get_id() == 9 then
                    count = count + 1
                end
            end
            if count > 0 then
                return {
                    mult = card.ability.extra.mult*count
                }
            end
        end
    end
}