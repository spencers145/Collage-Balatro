SMODS.Joker({
	key = "sandstone",
	atlas = "jokers",
	pos = {x = 5, y = 9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    enhancement_gate = 'm_ortalab_sand',
	config = {extra = {xmult = 1, gain = 0.1}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_ortalab_sand']
        return {vars = {card.ability.extra.xmult, card.ability.extra.gain}}
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for _, scoring_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scoring_card, 'm_ortalab_sand') and not scoring_card.debuff then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "gain",
                        message_key = 'a_xmult'
                    })
                    juice_card(scoring_card)
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
})