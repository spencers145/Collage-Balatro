SMODS.Joker({
	key = "dawn",
	atlas = "jokers",
	pos = {x = 7, y = 1},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1},
    artist_credits = {'flare', 'gappie'},
    calculate = function(self, card, context) --Dawn Logic
        if context.first_hand_drawn then
            if not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end
        end
        if context.repetition and context.cardarea == G.play then
            if G.GAME.current_round.hands_played == 0 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end
})