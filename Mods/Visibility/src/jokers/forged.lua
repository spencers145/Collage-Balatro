SMODS.Joker {
    key = "forged",
    atlas = "TextureAtlasJokers",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    pools = { ["Visibility"] = true },
    pos = { x = 8, y = 4 },
    config = { extra = { chips = 75 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "count",          colour = G.C.ORANGE },
                { text = "x" },
                { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.BLUE },
                { text = ")" },
            },
            calc_function = function(card)
                local count = 0
                if G.jokers then
                    for _, joker_card in ipairs(G.jokers.cards) do
                        if joker_card.config.center.rarity and joker_card.config.center.rarity == 1 then
                            count = count + 1
                        end
                    end
                end
                card.joker_display_values.count = count
                card.joker_display_values.localized_text = localize("k_common")
            end,
            mod_function = function(card, mod_joker)
                return { chips = (card.config.center.rarity == 1 and mod_joker.ability.extra.chips * JokerDisplay.calculate_joker_triggers(mod_joker) or nil) }
            end
        }
    end
}