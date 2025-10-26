local jokerInfo = {
discovered = false,
    key = "slot_machine",
    pos = LOSTEDMOD.funcs.coordinate(10),
    atlas = 'losted_jokers',
    rarity = 3,
    cost = 7,
    unlocked = false,
    blueprint_compat = true,
    config = {
        extra = {
            mult = 12,
            dollars = 2,
            xmult = 2,
            odds_mult = 2,
            odds_dollars = 4,
            odds_xmult = 8,
            odds_bankruptcy = 500,
        }
    },
    loc_vars = function(self, info_queue, card)
        local prob_mod = G.GAME and G.GAME.probabilities and G.GAME.probabilities.normal or 1
        return {
            vars = {prob_mod, card.ability.extra.mult, card.ability.extra.dollars, card.ability.extra.xmult, card.ability.extra.odds_bankruptcy}
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
            local extra = card.ability.extra
            local prob_mod = G.GAME.probabilities.normal or 1
            local ret = {}
            local has_effect = false

            -- Check for bankruptcy first (1 in 500 chance to lose all money)
            if pseudorandom('slot_bankruptcy') < prob_mod / extra.odds_bankruptcy then
                local current_money = to_number(G.GAME.dollars or 0)
                if current_money > 0 then
                    ret.dollars = -current_money
                    has_effect = true
                end
            else
                -- Only give positive effects if bankruptcy didn't trigger
                if pseudorandom('slot_xmult') < prob_mod / extra.odds_xmult then
                    ret.x_mult = extra.xmult
                    has_effect = true
                end

                if pseudorandom('slot_dollars') < prob_mod / extra.odds_dollars then
                    ret.dollars = (ret.dollars or 0) + extra.dollars
                    has_effect = true
                end

                if pseudorandom('slot_mult') < prob_mod / extra.odds_mult then
                    ret.mult = extra.mult
                    has_effect = true
                end
            end

            if has_effect then
                card.lucky_trigger = true
                return ret
            end
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'hand' and args.handname == 'Three of a Kind' then
            local lucky_sevens = 0
            for _, card in ipairs(args.scoring_hand) do
                if card:get_id() == 7 and SMODS.has_enhancement(card, 'm_lucky') then
                    lucky_sevens = lucky_sevens + 1
                end
            end
            return lucky_sevens == 3
        end
        return false
    end
}

return jokerInfo
