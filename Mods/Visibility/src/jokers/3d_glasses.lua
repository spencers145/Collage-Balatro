SMODS.Joker {
    key = "3d_glasses",
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    unlocked = true,
	discovered = false,
    pools = { ["Visibility"] = true },
    atlas = "TextureAtlasJokers",
    pos = { x = 0, y = 4 },
    config = { extra = { xchips = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xchips, localize('Diamonds', 'suits_plural'), localize('Hearts', 'suits_plural') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_red_suits = true
            for _, playing_card in ipairs(G.hand.cards) do
                if not playing_card:is_suit('Diamonds', nil, true) and not playing_card:is_suit('Hearts', nil, true) then
                    all_red_suits = false
                    break
                end
            end
            if all_red_suits then
                return {
                    xchips = card.ability.extra.xchips
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
                        { ref_table = "card.joker_display_values", ref_value = "x_chips", retrigger_type = "exp" }
                    },
                    border_colour = G.C.CHIPS
                }
            },
            calc_function = function (card)
                local all_red_suits = true
                for _, playing_card in ipairs(G.hand.cards) do
                    if not playing_card.highlighted and not playing_card:is_suit('Diamonds', nil, true) and not playing_card:is_suit('Hearts', nil, true) then
                        all_red_suits = false
                        break
                    end
                end
                card.joker_display_values.x_chips = all_red_suits and card.ability.extra.xchips or 1
            end
        }
    end
}