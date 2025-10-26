SMODS.Joker {
    key = "plastic_joker",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    pos = { x = 9, y = 5 },
    atlas = "TextureAtlasJokers",
    credits = {
        idea = "WarpedCloset",
        art = "Monachrome",
    },
    unlocked = true,
    discovered = false,
    config = { extra = { xchips = 0.2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_vis_plastic

        local plastic_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_vis_plastic') then plastic_tally = plastic_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.xchips, 1 + card.ability.extra.xchips * plastic_tally } }
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_vis_plastic'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_vis_plastic') then
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local plastic_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_vis_plastic') then
                    plastic_tally = plastic_tally + 1
                end
            end
            return {
                x_chips = 1 + card.ability.extra.xchips * plastic_tally
            }
        end
    end,
    joker_display_def = function(JokerDisplay)
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
                local plastic_tally = 0
                for _, playing_card in ipairs(G.playing_cards) do
                    if SMODS.has_enhancement(playing_card, 'm_vis_plastic') then
                        plastic_tally = plastic_tally + 1
                    end
                end
                card.joker_display_values.x_chips = 1 + card.ability.extra.xchips * plastic_tally
            end
        }
    end
}