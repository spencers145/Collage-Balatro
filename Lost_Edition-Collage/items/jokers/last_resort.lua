local try_destroy_attached_card = function(card)
    if card.ability.extra.attached_card then
        card.ability.extra.attached_card:start_dissolve()
        card.ability.extra.attached_card = nil
    end
end

local jokerInfo = {
discovered = false,
    key = "last_resort",
    pos = LOSTEDMOD.funcs.coordinate(15),
    atlas = 'losted_jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    blueprint_compat = false,
    config = { extra = { shot_taken = true, attached_card = nil, shots_left = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'sarc_ultrakill_explainer', set = 'Other'}
        info_queue[#info_queue+1] = {key = 'ortalab_temporary_explainer', set = 'Other'}
        local string1 = card.ability.extra.shots_left > 1 and card.ability.extra.shots_left or "Last"
        local string2 = card.ability.extra.shots_left > 1 and " bullets left..." or " one..."
        return { vars = { string1, string2 } }
    end,
    calculate = function(self, card, context)
        if card.ability.extra.attached_card == [["]].."MANUAL_REPLACE"..[["]] then
            for key, value in pairs(G.consumeables.cards) do
                if value.ability and value.ability.extra and value.ability.extra.custom_property == "belongs to last resort" then
                    card.ability.extra.attached_card = value
                    card.ability.extra.attached_card.sell_cost = 0
                    local eval = function()
                        return G.GAME.current_round.discards_used == 0 and not card.ability.extra.shot_taken and not G.RESET_JIGGLES
                    end
                    juice_card_until(card, eval, true)
                    break
                end
            end
        end

        if context.setting_blind then
            card.ability.extra.shot_taken = false
        end
        
        if context.first_hand_drawn then
            local go = false
            for key, value in pairs(G.hand.cards) do
                if value.seal then
                    go = true                    
                end
            end

            --print(#G.consumeables.cards + G.GAME.consumeable_buffer)
            --print(G.consumeables.config.card_limit)
            if go and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                local eval = function()
                    return G.GAME.current_round.discards_used == 0 and not card.ability.extra.shot_taken and not G.RESET_JIGGLES
                end
                card.ability.extra.attached_card = SMODS.add_card({key = 'c_sarc_ultrakill'--[[, edition = 'e_negative']]})
                card.ability.extra.attached_card.sell_cost = 0
                card.ability.extra.attached_card.ability.extra.custom_property = "belongs to last resort"
                card.ability.extra.attached_card.ability.temporary = "Last Resort"
                juice_card_until(card, eval, true)
                return {
                    message = "Take the shot?"
                }
            else
                card.ability.extra.shot_taken = true
            end
        end

        if context.using_consumeable and context.consumeable == card.ability.extra.attached_card then
            card.ability.extra.shot_taken = true
            card.ability.extra.attached_card = nil
            card.ability.extra.shots_left = card.ability.extra.shots_left - 1
            if card.ability.extra.shots_left > 0 then
                return {
                    message = "That's " .. (3 - card.ability.extra.shots_left) .. "."
                }
            else
                return {
                    message = "I'm out!",
                    func = function ()
                        G.E_MANAGER:add_event(Event({
                            func = function ()
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                    end
                }
            end
            
        end
        
        if not card.ability.extra.shot_taken and (context.end_of_round or (context.selling_card and (context.card == card or context.card == card.ability.extra.attached_card)) --[[or context.discard or context.before]]) then
            card.ability.extra.shot_taken = true
            try_destroy_attached_card(card)
            return {
                message = "Not this time..." 
            }
        end
    end
}

return jokerInfo