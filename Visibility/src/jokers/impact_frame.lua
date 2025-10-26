SMODS.Joker {
   key = "impact_frame",
    atlas = "TextureAtlasJokers",
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    pools = { ["Visibility"] = true },
    pos = { x = 7, y = 5 },
    config = { extra = { mult = 25 } },
    loc_vars = function(self, info_queue, card)
        local impact_frame_card = G.GAME.current_round.vis_impact_frame_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.mult, localize(impact_frame_card.rank, 'ranks'), localize(impact_frame_card.suit, 'suits_plural'), colours = { G.C.SUITS[impact_frame_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.vis_impact_frame_card.id and
            context.other_card:is_suit(G.GAME.current_round.vis_impact_frame_card.suit) then
            return {
                mult = card.ability.extra.mult,
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "vis_impact_frame_card", colour = G.C.FILTER },
                { text = ")" },
            },
            text_config = { colour = G.C.MULT },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit(G.GAME.current_round.vis_impact_frame_card.suit) and scoring_card:get_id() and scoring_card:get_id() == G.GAME.current_round.vis_impact_frame_card.id then
                            count = count +
                                JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.mult = card.ability.extra.mult * count
                card.joker_display_values.vis_impact_frame_card = localize { type = 'variable', key = "jdis_rank_of_suit", vars = { localize(G.GAME.current_round.vis_impact_frame_card.rank, 'ranks'), localize(G.GAME.current_round.vis_impact_frame_card.suit, 'suits_plural') } }
            end,
            style_function = function(card, text, reminder_text, extra)
                if reminder_text and reminder_text.children[4] then
                    reminder_text.children[4].config.colour = lighten(G.C.SUITS[G.GAME.current_round.vis_impact_frame_card.suit], 0.35)
                end
                return false
            end
        }
    end
}
