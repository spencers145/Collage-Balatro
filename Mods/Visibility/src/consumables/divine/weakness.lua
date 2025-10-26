SMODS.Consumable {
    key = 'weakness',
    set = 'Divine',
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 5 },
    pools = { ["c_Visibility"] = true },
    atlas = "TextureAtlasConsumables",
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        local cards_in_true_order = {}

        for key, value1 in pairs(G.hand.cards) do
            for key, value2 in pairs(G.hand.highlighted) do
                if value1 == value2 then
                    table.insert(cards_in_true_order, value1)
                end
            end
        end

        for i = 1, #cards_in_true_order do
            local percent = 1.15 - (i - 0.999) / (#cards_in_true_order - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    cards_in_true_order[i]:flip()
                    play_sound('card1', percent)
                    cards_in_true_order[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        for i = 1, #cards_in_true_order do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                func = function()
                    -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                    assert(SMODS.modify_rank(cards_in_true_order[i], -i))
                    return true
                end
            }))
        end
        for i = 1, #cards_in_true_order do
            local percent = 0.85 + (i - 0.999) / (#cards_in_true_order - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.35,
                func = function()
                    cards_in_true_order[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    cards_in_true_order[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.6)
    end
}