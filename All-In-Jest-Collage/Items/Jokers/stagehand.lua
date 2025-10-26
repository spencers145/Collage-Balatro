local stagehand = {
    object_type = "Joker",
    order = 290,

    key = "stagehand",
    rarity = 1,
    pos = { x = 13, y = 11 },
    atlas = 'joker_atlas',
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (G.jokers and #G.jokers.cards or 0) + (G.consumeables and #G.consumeables.cards or 0)
            }
        }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers then

            return {
                dollars = #G.jokers.cards + #G.consumeables.cards
            }
        end
        --[[if context.other_joker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_joker:juice_up(0.5, 0.5)
                    return true
                end
            }))
            return {
                xmult = card.ability.extra.xmult
            }
        end]]
    end

}
return { name = { "Jokers" }, items = { stagehand } }
