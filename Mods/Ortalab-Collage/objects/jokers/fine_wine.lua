SMODS.Joker({
	key = "fine_wine",
	atlas = "jokers",
	pos = {x = 2, y = 5},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	config = {extra = {discards = 1, original_odds = 3, odds = 3, gain = 1}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        local a, b = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {card.ability.extra.discards, a, b, card.ability.extra.gain}}
    end,
    calculate = function(self, card, context) --Fine Wine Logic
        --[[if not context.blueprint then
            if context.setting_blind and not card.getting_sliced then
                ease_discard(card.ability.extra.discards)
                card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.gain
                return {
                    message = localize('k_upgrade_ex')
                }
            end
            if context.end_of_round and not context.individual and not context.repetition then
                if SMODS.pseudorandom_probability(card, 'fine_wine', 1, card.ability.extra.odds) then
                    SMODS.destroy_cards(card, nil, nil, true)
                    return {
                        message = localize('k_drank_ex')
                    }
                else
                    return {
                        message = localize('k_safe_ex')
                    }
                end
            end
        end]]
        if not context.blueprint then
            if context.setting_blind and not card.getting_sliced then
                ease_discard(card.ability.extra.discards)
            end
            if context.end_of_round and not context.individual and not context.repetition then
                if SMODS.pseudorandom_probability(card, 'fine_wine', 1, card.ability.extra.odds) then
                    card.ability.extra.discards = card.ability.extra.discards + card.ability.extra.gain
                    card.ability.extra.odds = 2*card.ability.extra.odds
                    return {
                        message = localize("k_aged_ex")
                    }
                end
            end
        end
    end
})
