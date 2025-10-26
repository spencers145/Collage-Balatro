SMODS.Joker {
    key = "poker_face",
    blueprint_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    rarity = 3,
    cost = 8,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 1, y = 4 },
    config = { extra = { Xchips_gain = 0.2, Xchips = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky

        return { vars = { card.ability.extra.Xchips_gain, card.ability.extra.Xchips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card.lucky_trigger and not context.blueprint then
            card.ability.extra.Xchips = card.ability.extra.Xchips + card.ability.extra.Xchips_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
        end
        if context.joker_main then
            return {
                xchips = card.ability.extra.Xchips
            }
        end
    end,
    in_pool = function(self, args) --equivalent to `enhancement_gate = 'm_lucky'`
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_lucky') then
                return true
            end
        end
        return false
    end,
    joker_display_def = function(JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.ability.extra", ref_value = "Xchips", retrigger_type = "exp" }
                    },
                    border_colour = G.C.CHIPS
                }
            }
        }
    end
}