SMODS.Joker {
    key = "conquian",
    discovered = false,
    unlocked = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 8, y = 3 },
    calculate = function(self, card, context)
        if context.after then
            -- Turn the left card...
            -- Into the right card
            -- - RTGame
            if #context.full_hand == 2 then
                -- Death commences
                local left_card = context.full_hand[1]
                local right_card = context.full_hand[2]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        left_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
                local percent = 1.15 - (1 - 0.999) / (1 - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        left_card:flip()
                        play_sound('card1', percent)
                        left_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.2)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        copy_card(right_card, left_card)
                        return true
                    end
                }))
                local percent = 0.85 + (1 - 0.999) / (1 - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        left_card:flip()
                        play_sound('tarot2', percent, 0.6)
                        left_card:juice_up(0.3, 0.3)
                        return true
                    end
                }))
                delay(0.5)
                return {
                    message = "Converted!"
                }
            end
        end
    end
}