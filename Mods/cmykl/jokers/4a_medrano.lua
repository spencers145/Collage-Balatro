
SMODS.Joker{ --Medrano
    key = "medrano",
    config = {
        extra = {
            medranorich = 0
        }
    },
    loc_txt = {
        ['name'] = '{X:dark_edition}Medrano{}',
        ['text'] = {
            [1] = 'Gains {C:blue}+50{} Chips when',
            [2] = 'a {C:attention}seal{} is triggered',
            [3] = '{C:inactive}(Currently{} {C:blue}+#1#{} {C:inactive}Chips){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
    soul_pos = {
        x = 1,
        y = 0
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' 
            or args.source == 'buf' or args.source == 'jud' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.medranorich}}
    end,

    calculate = function(self, card, context)
        -- these seals fucking suck and i gotta manually check for each
        if context.cardarea == G.hand and context.end_of_round and not context.blueprint then
            if context.other_card.seal == "Blue" then
                card.ability.extra.medranorich = (card.ability.extra.medranorich) + 50
                return {
                    message = "!"
                }
            end
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.seal == "Gold" then
                card.ability.extra.medranorich = (card.ability.extra.medranorich) + 50
                return {
                message = "!"
            }
            end
        end

        -- thankfully most of the modded seals only need this :pray:
        if context.cmykl_seal_trigger and not context.blueprint and G.GAME.blind.in_blind then
            card.ability.extra.medranorich = card.ability.extra.medranorich + 50
            return {
                message = "!"
            }
        end

        if context.cardarea == G.jokers and context.joker_main  then
                return {
                    chips = card.ability.extra.medranorich
                }
        end
    end
}