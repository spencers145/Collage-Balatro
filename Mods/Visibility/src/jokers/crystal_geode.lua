SMODS.Joker {
	key = 'crystal_geode',
	config = { extra = { balance_percentage = 8, hand_balance = 0 } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 4, y = 4 },
	discovered = false,
	unlocked = true,
	eternal_compat = true,
	blueprint_compat = false,
	cost = 9,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.balance_percentage } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_no_suit(context.other_card) and SMODS.has_no_rank(context.other_card) then
                card.ability.extra.hand_balance = card.ability.extra.hand_balance + card.ability.extra.balance_percentage
            end
        end
        if context.final_scoring_step and card.ability.extra.hand_balance > 0 then
            local percentage_mult = mult * (card.ability.extra.hand_balance / 100)
            local percentage_chips = hand_chips * (card.ability.extra.hand_balance / 100)
            local saved = card.ability.extra.hand_balance
            card.ability.extra.hand_balance = 0
            mult = mult - math.floor(percentage_mult)
            hand_chips = hand_chips - math.floor(percentage_chips)
            local balance = math.floor((percentage_mult + percentage_chips) / 2)
            mult = mult + balance
            hand_chips = hand_chips + balance
            update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
            G.E_MANAGER:add_event(Event({
                delay = 0.6,
                trigger = 'after',
                func = (function()
                    -- scored_card:juice_up()
                    play_sound('gong', 0.94, 0.3)
                    play_sound('gong', 0.94*1.5, 0.2)
                    play_sound('tarot1', 1.5)
                    ease_colour(G.C.UI_CHIPS, {0.8, 0.45, 0.85, 1})
                    ease_colour(G.C.UI_MULT, {0.8, 0.45, 0.85, 1})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay =  0.8,
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
                        delay =  1.3,
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
                message = localize { type = 'variable', key = 'k_pbalanced', vars = { saved } },
                loc_vars = { saved }, colour =  {0.8, 0.45, 0.85, 1} 
            }
        end
	end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_no_suit(playing_card) and SMODS.has_no_rank(playing_card) then
                return true
            end
        end
        return false
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { ref_table = "card.joker_display_values", ref_value = "hand_balance" },
                { text = "% Hand Balance" }
            },
            text_config = { colour = G.C.PURPLE },
            calc_function = function (card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= "Unknown" then
                    for _, scoring_card in pairs(scoring_hand) do
                        if SMODS.has_no_suit(scoring_card) and SMODS.has_no_rank(scoring_card) then
                            count = count + JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.hand_balance = count * card.ability.extra.balance_percentage
            end
        }
    end
}