SMODS.Joker {
    key = "minuteman",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = "TextureAtlasJokers",
    config = { extra = { mult = 20 }, },
    credits = {
        idea = "WarpedCloset",
        remix = "Monachrome"
    },
    pos = { x = 1, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_played == 0 then
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
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.MULT },
            calc_function = function(card)
                card.joker_display_values.mult = G.GAME.current_round.hands_played == 0 and card.ability.extra.mult or 0
            end,
        }
    end
}