
SMODS.Joker({
    key = "space_ticket",
    atlas = "jokers",
    pos = {x = 8, y = 6},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {level = 1}},
    artist_credits = {'kosze'},
    enhancement_gate = 'm_ortalab_iou',
    calculate = function(self, card, context)
        if context.after and context.main_eval then
            card.ability.extra.cosmic_check = false
            for _, played_card in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(played_card, 'm_ortalab_iou') then card.ability.extra.cosmic_check = true end
            end
        end
        if context.end_of_round and context.main_eval and not context.blueprint and card.ability.extra.cosmic_check then
            return {
                func = function()
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {handname = G.GAME.last_hand_played, level = G.GAME.hands[G.GAME.last_hand_played].level, mult = G.GAME.hands[G.GAME.last_hand_played].mult, chips = G.GAME.hands[G.GAME.last_hand_played].chips})                
                    level_up_hand(card, G.GAME.last_hand_played, nil, card.ability.extra.level)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                end,
                message = localize('ortalab_level_up'),
                colour = G.C.PURPLE
            }
        end
    end    
})