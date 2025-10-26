SMODS.Joker({
	key = "mill",
	atlas = "jokers",
	pos = {x=4,y=10},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {xmult = 1, gain = 0.2, target = 3}},
    artist_credits = {'kosze'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.gain, card.ability.extra.target}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.using_consumeable or context.press_play then
            card.ability.extra.count = 0
        end
        if context.change_suit and not context.blueprint and not context.retrigger_joker and not Ortalab.harp_usage then
            card.ability.extra.count = card.ability.extra.count + 1
            if card.ability.extra.count == card.ability.extra.target then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "xmult",
                    scalar_value = "gain",
                    message_key = 'a_xmult'
                })
            end
        end
    end
})