SMODS.Joker{ --Invitation Card
    key = "invitationcard",
    config = {
        extra = {
            hype = 0
        }
    },
    loc_txt = {
        ['name'] = 'Invitation Card',
        ['text'] = {
            [1] = 'Stores {C:red}+2{} Mult for each',
            [2] = 'scored card, unleashes',
            [3] = 'Mult during {C:attention}Boss Blind{}',
            [4] = '{C:inactive}(Currently {}{C:red}+#1#{}{C:inactive} Mult){}',
            [5] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hype}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not G.GAME.blind.boss and not context.blueprint then
            card.ability.extra.hype = (card.ability.extra.hype) + 2
            return {
                message = "Hype!"
            }
        end
        if G.GAME.blind and G.GAME.blind.boss then
            if context.cardarea == G.jokers and context.joker_main  then
                    return {
                        message = "Celebrate!",
                        mult = card.ability.extra.hype
                    }
            end
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss  then
                return {
                    message = "End!",
                    func = function()
                    card.ability.extra.hype = 0
                    return true
                end
                }
        end
    end
}