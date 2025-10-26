SMODS.Consumable {
    key = 'mint',
    set = 'Divine',
    pos = { x = 1, y = 0 },
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    config = { extra = { current = 0, max = 25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current, card.ability.extra.max } }
    end,
    can_use = function (self, card)
        -- Return true if there are any cards in hand
        return G.hand and #G.hand.cards > 0
    end,
    update = function (self, card, dt)
        -- Ran every frame
        if G.hand and #G.hand.cards == 0 then
            card.ability.extra.current = 0
            return
        end
        local total_chips = 0
        if not G.hand then
            goto no_hand
        end
        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c.ability.bonus or c.ability.perma_bonus then
                total_chips = total_chips + (c.ability.bonus or 0) + (c.ability.perma_bonus or 0)
            end
            -- Do not add rank to total chips if the enhancement has no_rank active
            if SMODS.has_no_rank(c) then
                goto continue
            end
            -- Card is (maybe) not enhanced, so it just adds (rank) chips, limit it to 10 except for ace, which is 11
            total_chips = total_chips + c.base.nominal
            ::continue::
        end
        ::no_hand::
        card.ability.extra.current = math.min(math.floor(total_chips/6), card.ability.extra.max)
    end,
    use = function(self, card, area, copier)
        -- Loop through all cards in hand
        local total_chips = 0
        for i = 1, #G.hand.cards do
            local c = G.hand.cards[i]
            if c.ability.bonus or c.ability.perma_bonus then
                total_chips = total_chips + (c.ability.bonus or 0) + (c.ability.perma_bonus or 0)
            end
            -- Do not add rank to total chips if the enhancement has no_rank active
            if SMODS.has_no_rank(c) then
                goto continue
            end
            -- Card is (maybe) not enhanced, so it just adds (rank) chips, limit it to 10 except for ace, which is 11
            total_chips = total_chips + c.base.nominal
            ::continue::
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')
                card:juice_up(0.3, 0.5)
                ease_dollars(math.min(math.floor(total_chips/6), card.ability.extra.max), true)
                return true
            end
        }))
        delay(0.6)
    end
}