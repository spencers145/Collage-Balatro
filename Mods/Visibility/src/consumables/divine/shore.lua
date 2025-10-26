SMODS.Consumable {
    key = 'shore',
    set = 'Divine',
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 5, y = 0 },
    config = { extra = { e_money = 8, en_money = 2, seal_money = 4, current = 0 } },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.e_money, card.ability.extra.seal_money, card.ability.extra.en_money, card.ability.extra.current } }
    end,
    update = function (self, card, dt)
        --[[
        -- Ran every frame
        if G.hand and #G.hand.cards == 0 then
            card.ability.extra.current = 0
            return
        end
        local total_dollars = 0
        if not G.hand then
            goto no_hand
        end
        for k, v in pairs(G.hand.cards) do
            local card_enhancement = v.config.center.key
            local card_seal = v.seal
            local card_edition = v.edition
            if card_edition then
                total_dollars = total_dollars + 8
            end
            if card_seal then
                total_dollars = total_dollars + 4
            end
            if card_enhancement ~= "c_base" then
                total_dollars = total_dollars + 2
            end
        end
        ::no_hand::
        card.ability.extra.current = total_dollars
        ]]
    end,
    use = function (self, card, area, copier)
        local dissolved = 0
        local choices = {}

        for k, v in pairs(G.hand.cards) do
            choices[k] = v
        end
        
        pseudoshuffle(choices, pseudoseed("vis_shore_shuffle"))

        for k, v in pairs(choices) do
            local card_enhancement = v.config.center.key
            local card_seal = v.seal
            local card_edition = v.edition
            if not card_edition and not card_seal and card_enhancement == "c_base" then
                v:start_dissolve()
                dissolved = dissolved + 1
            end
            if dissolved >= 5 then break end
        end
        if dissolved > 0 then
            ease_dollars(dissolved * 2)
        end
        delay(0.6)
        --[[
        -- Remove all Enhancements, Seals and Editions from all cards in your hand, gain 2$ for every removed Enhancement and 4$ for every removed Seal, 8$ for every removed Edition
        local total_dollars = 0
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                play_sound('card1')
                for k, v in pairs(G.hand.cards) do
                    v:flip()
                    v:juice_up(0.3, 0.3)
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                -- SMODS.modify_rank will increment/decrement a given card's rank by a given amount
                for k, v in pairs(G.hand.cards) do
                    local card_enhancement = v.config.center.key
                    local card_seal = v.seal
                    local card_edition = v.edition
                    if card_edition then
                        total_dollars = total_dollars + 8
                        v:set_edition(nil, true)
                    end
                    if card_seal then
                        total_dollars = total_dollars + 4
                        v.seal = nil
                    end
                    if card_enhancement ~= "c_base" then
                        total_dollars = total_dollars + 2
                        v:set_ability("c_base", nil)
                    end
                end
                ease_dollars(total_dollars)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.9,
            func = function()
                play_sound('tarot2')
                for k, v in pairs(G.hand.cards) do
                    v:flip()
                    v:juice_up(0.3, 0.3)
                end
                return true
            end
        }))
        delay(1.2)
        ]]
    end,
    can_use = function (self, card)
        return G.hand and #G.hand.cards > 0
    end
}