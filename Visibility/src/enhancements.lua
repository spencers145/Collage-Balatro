local function event(config)
    local e = Event(config)
    G.E_MANAGER:add_event(e)
    return e
end

SMODS.Enhancement {
    key = 'brick',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 0, y = 0 },
    config = { mult = 10 },
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    in_pool = function (self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    calculate = function(self, card, context)
        if context.after and context.cardarea == G.play and context.scoring_hand and context.full_hand then
            local unscored = {}
            for key, card in pairs(context.full_hand) do
                local wasscored = false
                for key, scoredcard in pairs(context.scoring_hand) do
                    if scoredcard == card then
                        wasscored = true
                        break
                    end
                end
                if not wasscored and not card.destroyed then
                    table.insert(unscored, card)
                end
            end

            if #unscored > 0 then
                local pummeled = pseudorandom_element(unscored, pseudoseed("vis_brick_pummel"))
                SMODS.calculate_context({remove_playing_cards = true, removed = {pummeled}, scoring_hand = context.scoring_hand})
                pummeled.destroyed = true

                if SMODS.has_enhancement(pummeled, 'm_buf_porcelain') or SMODS.has_enhancement(pummeled, 'm_buf_porcelain_g') then
                    unlock_card(G.P_CENTERS.b_buf_porcelain)
                end
                
                event({trigger = 'before', delay = 1, func = function()
                    pummeled:start_dissolve()
                    play_sound('collage_pummel', 1, 0.7)
                    card_eval_status_text(
                        pummeled,
                        'extra',
                        nil, nil, nil,
                        {message = "Pummeled!", colour = G.C.ORANGE, instant = true}
                    )
                    delay(0.6)
                    return true
                end})
            end
        end
    end,
}

--[[SMODS.Enhancement {
    key = 'table_cloth',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 1, y = 0 },
    config = { card_limit = 1 --[[x_chips = 1.35]] --},
    --[[always_scores = true,
    --loc_vars = function(self, info_queue, card)
        --return { vars = { card.ability.xchips } }
    --end,
}]]

SMODS.Enhancement {
    key = 'notebook',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 3, y = 0 },
    config = { extra = { hand_balance = 10 } },
    in_pool = function (self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_balance } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            --[[local percentage_mult = mult * (card.ability.extra.hand_balance / 100)
            local percentage_chips = hand_chips * (card.ability.extra.hand_balance / 100)
            mult = mult - math.floor(percentage_mult)
            hand_chips = hand_chips - math.floor(percentage_chips)
            local balance = math.floor((percentage_mult + percentage_chips) / 2)
            mult = mult + balance
            hand_chips = hand_chips + balance
            G.E_MANAGER:add_event(Event({
                delay = 0.25,
                trigger = 'after',
                func = (function()
                    -- scored_card:juice_up()
                    -- update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  0.7,
                        func = (function() 
                                ease_colour(G.C.UI_CHIPS, G.C.BLUE, 0.8)
                                ease_colour(G.C.UI_MULT, G.C.RED, 0.8)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay =  1,
                        func = (function() 
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
            return { 
                message = "12%",
                loc_vars = { card.ability.extra.hand_balance }, colour =  {0.8, 0.45, 0.85, 1} 
            }]]
            --[[return {
                aij_balance_percent = card.ability.extra.hand_balance * 0.01
            }]]
        end
        if context.final_scoring_step then
            local iamfirst = false
            local total_notebooks = 0
            for key, value in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(value, 'm_vis_notebook') then
                    if not iamfirst then
                        if value ~= card then
                            return
                        else
                            iamfirst = true
                        end
                    end

                    total_notebooks = total_notebooks + 1
                end
            end

            return {
                aij_balance_percent = total_notebooks * 0.1
            }
        end
    end,
}

SMODS.Enhancement {
    key = 'plastic',
    atlas = "TextureAtlasEnhancements",
    pos = { x = 2, y = 0 },
    config = { h_x_chips = 1.35 },
    in_pool = function (self, args)
        return false
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips } }
    end,
}