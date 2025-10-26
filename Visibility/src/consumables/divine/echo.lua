SMODS.Consumable {
    key = 'echo',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 0 },
    config = { extra = { cost = 5 } },
    loc_vars = function(self, info_queue, card)
        local total_sell_cost = 0
        if G.consumeables then
            for i = 1, #G.consumeables.cards do
                if card ~= G.consumeables.cards[i] then
                    total_sell_cost = total_sell_cost + G.consumeables.cards[i].sell_cost
                end
            end
        end
        return { vars = { total_sell_cost } }
    end,
    can_use = function (self, card)
        local less = 0
        for key, value in pairs(G.consumeables.cards) do
            if value == card then
                less = 1
                break
            end
        end
        return G.consumeables and #G.consumeables.cards > less
    end,
    use = function (self, card, area, copier)
        if G.consumeables.cards[1] then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local negative = 0
                    local total = 0
                    local checked = 0
                    local center = nil
                    local total_sell_cost = 0
                    for i = 1, #G.consumeables.cards do
                        local amt = G.consumeables.cards[i]:getAmt()
                        total = total + amt
                        total_sell_cost = total_sell_cost + G.consumeables.cards[i].sell_cost
                        if G.consumeables.cards[i].edition and G.consumeables.cards[i].edition.negative then negative = negative + amt end
                    end
                    local poll = pseudorandom(pseudoseed('divine_echo'))*total
                    for i = 1, #G.consumeables.cards do
                        local amt = G.consumeables.cards[i]:getAmt()
                        checked = checked + amt
                        if checked >= poll then
                        center = G.consumeables.cards[i]
                        break
                        end
                    end
                    ease_dollars(-total_sell_cost)
                    local card = copy_card(center, nil, nil, nil, true)
                    card.ability.amt = 1
                    card:set_edition({negative = true}, true)
                    card:add_to_deck()
                    G.consumeables:emplace(card) 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_duplicated_ex')})
                    return true
                end}))
        end
    end
}
