SMODS.Joker{ --Humanity
    key = "humanity",
    config = {
        extra = {
            hands = 1,
            nothanded = 0,
            sell_value = 0,
            round = 0
        }
    },
    loc_txt = {
        ['name'] = 'Humanity',
        ['text'] = {
            [1] = '{C:blue}+1{} hand this round',
            [2] = 'when {C:attention}0{} hands and',
            [3] = 'discards remaining'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    calculate = function(self, card, context)       
        if context.cardarea == G.jokers and context.joker_main  then
            if (G.GAME.current_round.hands_left == 0 and G.GAME.current_round.discards_left == 0 and not (G.GAME.pool_flags.cmykl_nothanded or false)) then
                G.GAME.pool_flags.cmykl_nothanded = true
                return {
                        func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Saved!"})
                G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + card.ability.extra.hands
                return true
            end
                }
            end
        end
        if context.setting_blind then
                G.GAME.pool_flags.cmykl_nothanded = false
                return {
                }
        end
    end
}