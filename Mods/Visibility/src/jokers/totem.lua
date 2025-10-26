SMODS.Joker {
    key = "totem",
    rarity = 2,
    cost = 5,
    eternal_compat = true,
    blueprint_compat = true,
    unlocked = true,
	discovered = false,
    pools = { ["Visibility"] = true },
    atlas = "TextureAtlasJokers",
    pos = { x = 9, y = 1 },
    config = { extra = { retriggers = 2 } },
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.retriggers, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
            context.other_card:get_id() == G.GAME.current_round.idol_card.id and
            context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
            return {
                repetitions = card.ability.extra.retriggers,
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { ref_table = "card.joker_display_values", ref_value = "retriggers", },
                { text = " Retriggers" },
            },
            reminder_text = {
                { text = "(" },
                { ref_table = "card.joker_display_values", ref_value = "idol_card", colour = G.C.FILTER },
                { text = ")" },
            },
            text_config = { colour = G.C.ORANGE },
            calc_function = function(card)
                local count = 0
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:is_suit(G.GAME.current_round.idol_card.suit) and scoring_card:get_id() and scoring_card:get_id() == G.GAME.current_round.idol_card.id then
                            count = count +
                                JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                        end
                    end
                end
                card.joker_display_values.retriggers = card.ability.extra.retriggers * count
                card.joker_display_values.idol_card = localize { type = 'variable', key = "jdis_rank_of_suit", vars = { localize(G.GAME.current_round.idol_card.rank, 'ranks'), localize(G.GAME.current_round.idol_card.suit, 'suits_plural') } }
            end,
            style_function = function(card, text, reminder_text, extra)
                if reminder_text and reminder_text.children[4] then
                    reminder_text.children[4].config.colour = lighten(G.C.SUITS[G.GAME.current_round.idol_card.suit], 0.35)
                end
                return false
            end
        }
    end
}