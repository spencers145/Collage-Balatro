local function killable(self, area)
    local t = {}
    for i = 1, #area.cards do
        local j = area.cards[i]
        if j ~= self and not j.ability["eternal"] and not j.getting_sliced then
            table.insert(t, j)
        end
    end
    return t
end

--- @type SMODS.Joker
local j = {
    key = "vortex",
    atlas = "jokers",
    pos = { x = 6, y = 0 },
    config = { extra = { Xmult = 1, Xmult_gain = 0.25 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.Xmult_gain, stg.Xmult } }
    end,
    eternal_compat = false,
    perishable_compat = false,
    blueprint_compat = true,
    discovered = false,
    rarity = 2,
    cost = 7,
    calculate = function(self, card, context)
        if context.ending_shop then
            if #G.consumeables.cards > 0 then
                local victims = killable(card, G.consumeables)
                local to_destroy = pseudorandom_element(victims, pseudoseed("vortex")) or nil
                if to_destroy then
                    to_destroy.getting_sliced = true
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                    return {
                        message = localize("k_upgrade_ex")
                    }
                end
            else
                if not context.blueprint then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card:start_dissolve({ G.C.RED }, nil, 1.6)
                            return true
                        end
                    }))
                    return {
                        message = localize("k_mstg_closed_ex"),
                        colour = G.C.RED
                    }
                end
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}

return j
