SMODS.Joker {
    key = "playing_piece",
    rarity = 1,
    cost = 4,
    blueprint_compat = true,
    unlocked = true,
	discovered = false,
    pools = { ["Visibility"] = true },
    atlas = "TextureAtlasJokers",
    pos = { x = 2, y = 6 },
    config = { extra = { rank = { 2, 3 } } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(tostring(card.ability.extra.rank[1]), 'ranks'), localize(tostring(card.ability.extra.rank[2]), 'ranks') } }
    end,
    credits = {
        idea = "WarpedCloset",
    },
    calculate = function(self, card, context)
        if context.after then
            if next(context.poker_hands["Flush"]) then
                local condition_met = false
                local converted_rank = card.ability.extra.rank[1]
                if converted_rank == 'Jack' then converted_rank = 11
                elseif converted_rank == 'Queen' then converted_rank = 12
                elseif converted_rank == 'King' then converted_rank = 13
                elseif converted_rank == 'Ace' then converted_rank = 14
                end
                for _, playing_card in ipairs(context.scoring_hand) do
                    if playing_card:get_id() == converted_rank then
                        converted_rank = card.ability.extra.rank[2]
                        if converted_rank == 'Jack' then converted_rank = 11
                        elseif converted_rank == 'Queen' then converted_rank = 12
                        elseif converted_rank == 'King' then converted_rank = 13
                        elseif converted_rank == 'Ace' then converted_rank = 14
                        end
                        for _, playing_card in ipairs(context.scoring_hand) do
                            if playing_card:get_id() == converted_rank then
                                condition_met = true
                                break
                            end
                        end
                        break
                    end
                end
                local spawned = false
                if condition_met then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.2,
                        func = function ()
                            if #G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit then 
                                SMODS.add_card({ set = "Divine", area = G.consumeables }) 
                                spawned = true
                            end
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.3,
                    func = function ()
                        if not spawned then return true end
                        card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_plus_divine'), colour = G.C.SECONDARY_SET.Divine })
                        return true
                    end
                }))
                
            end
        end
        if context.end_of_round and context.game_over == false then
            card.ability.extra.rank[1] = pseudorandom("playing_piece_rank_1", 2, 14)
            card.ability.extra.rank[2] = pseudorandom("playing_piece_rank_2", 2, 14)
            while card.ability.extra.rank[1] == card.ability.extra.rank[2] do
                card.ability.extra.rank[2] = pseudorandom("playing_piece_rank_2", 2, 14)
            end
            for i, rank in ipairs(card.ability.extra.rank) do
                if rank == 11 then card.ability.extra.rank[i] = 'Jack'
                elseif rank == 12 then card.ability.extra.rank[i] = 'Queen'
                elseif rank == 13 then card.ability.extra.rank[i] = 'King'
                elseif rank == 14 then card.ability.extra.rank[i] = 'Ace'
                end
            end
        end
    end,
    set_ability = function (self, card, initial, delay_sprites)
        card.ability.extra.rank[1] = pseudorandom("playing_piece_rank_1", 2, 14)
        card.ability.extra.rank[2] = pseudorandom("playing_piece_rank_2", 2, 14)
        while card.ability.extra.rank[1] == card.ability.extra.rank[2] do
            card.ability.extra.rank[2] = pseudorandom("playing_piece_rank_2", 2, 14)
        end
        for i, rank in ipairs(card.ability.extra.rank) do
            if rank == 11 then card.ability.extra.rank[i] = 'Jack'
            elseif rank == 12 then card.ability.extra.rank[i] = 'Queen'
            elseif rank == 13 then card.ability.extra.rank[i] = 'King'
            elseif rank == 14 then card.ability.extra.rank[i] = 'Ace'
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "divine_count", retrigger_type = "exp" },
                { text = " Divine" }
            },
            reminder_text = {
                { text = "("},
                { ref_table = "card.ability.extra.rank", ref_value = 1, },
                { text = " and "},
                { ref_table = "card.ability.extra.rank", ref_value = 2 },
                { text = ")"}
            },
            text_config = { colour = G.C.SECONDARY_SET.Divine },
            calc_function = function (card)
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Flush" then 
                    card.joker_display_values.divine_count = 0
                    return
                end
                local condition_met = false
                local converted_rank = card.ability.extra.rank[1]
                if converted_rank == 'Jack' then converted_rank = 11
                elseif converted_rank == 'Queen' then converted_rank = 12
                elseif converted_rank == 'King' then converted_rank = 13
                elseif converted_rank == 'Ace' then converted_rank = 14
                end
                for _, playing_card in ipairs(scoring_hand) do
                    if playing_card:get_id() == converted_rank then
                        converted_rank = card.ability.extra.rank[2]
                        if converted_rank == 'Jack' then converted_rank = 11
                        elseif converted_rank == 'Queen' then converted_rank = 12
                        elseif converted_rank == 'King' then converted_rank = 13
                        elseif converted_rank == 'Ace' then converted_rank = 14
                        end
                        for _, playing_card in ipairs(scoring_hand) do
                            if playing_card:get_id() == converted_rank then
                                condition_met = true
                                break
                            end
                        end
                        break
                    end
                end
                card.joker_display_values.divine_count = condition_met and 1 or 0
            end
        }
    end
}