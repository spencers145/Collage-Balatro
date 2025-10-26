SMODS.Joker({
    key = "wallet",
    atlas = "jokers",
    pos = {x = 8, y = 0},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    artist_credits = {'eremel'},
})

function Ortalab.wallet_end_of_round(context, cards, wallet)
    for _, card in ipairs(cards) do
        card.wallet = wallet
        local reps = {1}
        local j = 1
        while j <= #reps do
            percent = (1-0.999)/(#context.cardarea.cards-0.998) + (j-1)*0.1
            if reps[j] ~= 1 then
                local _, eff = next(reps[j])
                SMODS.calculate_effect(eff, eff.card)
                percent = percent + 0.08
            end
            
            context.playing_card_end_of_round = true
            --calculate the hand effects
            local effects = {eval_card(card, context)}
            SMODS.calculate_quantum_enhancements(card, effects, context)
    
            context.playing_card_end_of_round = nil
            context.individual = true
            context.other_card = card
            -- context.end_of_round individual calculations
            
            SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
            SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })
            local flags = SMODS.trigger_effects(effects, card)

            context.individual = nil
            context.repetition = true
            context.card_effects = effects
            if reps[j] == 1 then
                SMODS.calculate_repetitions(card, context, reps)
            end
    
            context.repetition = nil
            context.card_effects = nil
            context.other_card = nil
            j = j + (flags.calculated and 1 or #reps)
        end
    end
end

local ortalab_trigger_effects = SMODS.calculate_effect
SMODS.calculate_effect = function(effect, scored_card, from_edition, pre_jokers)
    if scored_card and scored_card.wallet then
        local wallet = scored_card.wallet
        scored_card.wallet = nil
        if table.size(effect) > 0 then SMODS.calculate_effect({message = 'Wallet', colour = G.C.PURPLE, juice_card = wallet, message_card = scored_card}, scored_card) end
    end
    return ortalab_trigger_effects(effect, scored_card, from_edition, pre_jokers)
end