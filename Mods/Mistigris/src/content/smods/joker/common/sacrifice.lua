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
    key = "sacrifice",
    atlas = "jokers",
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = false,
    discovered = false,
    perishable_compat = true,
    config = { extra = { bonus_xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { stg.bonus_xmult } }
    end,
    rarity = 2,
    cost = 5,
    calculate = function(self, card, context)
        if context.selling_self then
            local victims = killable(card, G.jokers)
            local to_destroy = pseudorandom_element(victims, pseudoseed("sacrifice")) or nil
            if to_destroy then
                to_destroy.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        to_destroy:start_dissolve({ G.C.RED }, nil, 1.6)
                        return true
                    end
                }))
            end
        end

        if context.joker_main then
            return {
                Xmult = card.ability.extra.bonus_xmult,
            }
        end
    end,
}

return j
