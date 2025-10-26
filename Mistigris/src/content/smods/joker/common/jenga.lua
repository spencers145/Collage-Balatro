-- Utility Code 
--- @type SMODS.Joker
local j = {
    key = "jenga",
    atlas = "jokers",
    pos = { x = 3, y = 0 },
    blueprint_compat = true,
    discovered = false,
    config = { extra = { base_normal = 1, mult_add = 4, mult = 4, normal = 1, odds = 50 } },
    loc_vars = function(self, table, card)
        local norm = (G.GAME.probabilities.normal and G.GAME.probabilities.normal or 1)
        local stg = card.ability.extra
        return { vars = { stg.mult, stg.normal * norm, stg.odds, stg.mult_add, stg.base_normal * norm }, }
    end,
    rarity = 1,
    cost = 4,
    set_ability = function(self, card, initial, delay_sprites)
        if initial then
            card.ability.extra.base_normal = (G.GAME.probabilities.normal and card.ability.extra.base_normal * G.GAME.probabilities.normal or card.ability.extra.base_normal)
            card.ability.extra.normal = card.ability.extra.base_normal
            card.ability.extra.mult = card.ability.extra.mult_add
        end
    end,
    calculate = function(self, card, context)
        local true_normal = card.ability.extra.normal * G.GAME.probabilities.normal
        if context.before and not context.blueprint then
            local is_reset = pseudorandom("jenga") <
                true_normal / card.ability.extra.odds;
            if is_reset then
                card.ability.extra.mult = card.ability.extra.mult_add
                card.ability.extra.normal = card.ability.extra.base_normal
                return {
                    message = localize("k_reset"),
                }
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
                card.ability.extra.normal = card.ability.extra.normal + card.ability.extra.base_normal
                return {
                    message = localize("k_upgrade_ex"),
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

return j
