SMODS.Joker {
    key = "blackbeard",
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    unlocked = true,
	discovered = false,
    pools = { ["Visibility"] = true },
    atlas = "TextureAtlasJokers",
    pos = { x = 4, y = 5 },
    config = { extra = { gain = 0.25, x_mult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.x_mult } }
    end,
    update = function (self, card, dt)
        if not G.consumeables or not G.consumeables.cards then
            card.ability.extra.x_mult = 1
            return
        end
        local x_mult = 1
        local dollars = 0
        for _, card in pairs(G.consumeables.cards) do
            dollars = dollars + card.sell_cost
        end
        card.ability.extra.x_mult = x_mult + (dollars * card.ability.extra.gain)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local x_mult = 1
            local dollars = 0
            for _, card in pairs(G.consumeables.cards) do
                dollars = dollars + card.sell_cost
            end
            x_mult = x_mult + (dollars * card.ability.extra.gain)
            if x_mult > 1 then
                return {
                    x_mult = x_mult
                }
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "mult" }
                    }
                }
            }
        }
    end
}