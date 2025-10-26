SMODS.Joker({
	key = "taliaferro",
	atlas = "jokers",
	pos = {x = 5, y = 2},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	no_pool_flag = 'taliaferro_extinct',
	config = {extra = {chips = 100, odds = 6}},
    artist_credits = {'flare','grassy'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, SMODS.get_probability_vars(card, 1, card.ability.extra.odds)}}
    end,
    calculate = function(self, card, context) --Taliaferro Logic NOTE: MUST ADD POOL FLAGS
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if SMODS.pseudorandom_probability(card, 'taliaferro', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                G.GAME.pool_flags.taliaferro_extinct = true
                return {
                    message = localize('k_extinct_ex')
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})