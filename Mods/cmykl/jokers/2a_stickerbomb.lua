SMODS.Joker{ --Sticker Bomb
    key = "stickerbomb",
    config = {
        extra = {
            odds = 12
        }
    },
    loc_txt = {
        ['name'] = 'Sticker Bomb',
        ['text'] = {
            'Scored Cards has',
            'a {C:green}#1# in #2#{} chance',
            'of getting a',
            '{C:attention}random seal{} applied'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_cmykl_stickerbomb') 
        return {vars = {new_numerator, new_denominator}}
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_4d071917', 1, card.ability.extra.odds, 'j_cmykl_stickerbomb') then
                      local random_seal = SMODS.poll_seal({mod = 10, guaranteed = true})
                if random_seal then
                    context.other_card:set_seal(random_seal, true)
                end
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.BLUE})
                  end
            end
        end
    end
}