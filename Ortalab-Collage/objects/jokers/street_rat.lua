SMODS.Joker({
    key = "street_rat",
    atlas = "jokers",
    pos = {x = 3, y = 11},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {mod = 5}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mod}}
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            local pos
            for i, v in ipairs(card.area.cards) do
                if v == card then pos = i end
            end
            if card.area.cards[pos+1] and card.area.cards[pos+1].config.center.rarity == 1 and not SMODS.is_eternal(card.area.cards[pos+1], card) then
                local destroy_card = card.area.cards[pos+1]
                local sell_val = destroy_card.sell_cost
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        destroy_card:juice_up()                
                        return true
                    end
                }))
                return {
                    message = localize('ortalab_street_rat'),
                    colour = G.C.GOLD,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.4,
                            func = function()
                                destroy_card:start_dissolve()            
                                return true
                            end
                        }))
                    end,
                    extra = {
                        dollars = sell_val * card.ability.extra.mod
                    }
                }
            end
        end
    end    
})

