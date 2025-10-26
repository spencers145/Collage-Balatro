local function get_played_hand_count_this_run()
    local hand_count = 0
    for name, handinfo in pairs(G.GAME.hands) do
        if handinfo.played > 0 then
            hand_count = hand_count + 1
        end
    end
    return hand_count
end

--- @type SMODS.Joker
local j = {
    key = "ufo",
    atlas = "jokers",
    pos = { x = 4, y = 0 },
    config = { extra = { Xmult_add = 0.2 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult_add, 1 + (stg.Xmult_add * get_played_hand_count_this_run()) }
        }
    end,
    discovered = false,
    blueprint_compat = false,
    rarity = 2,
    cost = 8,
    calculate = function(self, card, context)
        local mult = 1 + (card.ability.extra.Xmult_add * get_played_hand_count_this_run())
        if context.joker_main then
            return {
                Xmult = mult
            }
        end
    end
}

return j
