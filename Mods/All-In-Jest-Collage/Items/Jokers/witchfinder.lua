local witchfinder = {
    object_type = "Joker",
    order = 251,
    key = "witchfinder",
    config = {

    },
    rarity = 1,
    pos = { x = 23, y = 9 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_arcana_normal_1
    end,

    calculate = function(self, card, context)
        if context.starting_shop and not context.blueprint then
            G.E_MANAGER:add_event(Event {
                func = function()
                    local key = 'p_arcana_normal_' .. pseudorandom('witchfinder', 1, 4)
                    local booster = SMODS.add_booster_to_shop(key)
                    booster:set_cost()
                    return true
                end
            })

            return {
                message = localize('k_aij_p_arcana'),
            }
        end
    end

}
return { name = { "Jokers" }, items = { witchfinder } }
