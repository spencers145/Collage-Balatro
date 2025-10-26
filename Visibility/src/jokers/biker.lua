SMODS.Joker {
    key = "biker",
    config = { extra = { mult = 50, d_size = 2 }},
    rarity = 3,
    unlocked = true,
    discovered = false,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 4, y = 3 },
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.d_size } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult"}
            },
            reminder_text = {
                { text = "-" },
                { ref_table = "card.ability.extra", ref_value = "d_size" },
                { text = " " },
                { ref_table = "card.joker_display_values", ref_value = "localized_text" }
            },
            text_config = { colour = G.C.MULT },
            reminder_text_config = { scale = 0.2, colour = G.C.GREY },
            calc_function = function (card)
                card.joker_display_values.localized_text = localize("k_hud_discards") 
            end
        }
    end
}