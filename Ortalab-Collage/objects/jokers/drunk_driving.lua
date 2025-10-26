SMODS.Joker({
	key = "drunk_driving",
	atlas = "jokers",
	pos = {x=9,y=2},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {mult = 0, gain = 2}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.mult, card.ability.extra.gain}}
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local face = false
            local number = false
            for _, card in pairs(context.scoring_hand) do
                if card:is_face() then face = true end
                if card:is_numbered() then number = true end
            end
            if face and number and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "gain",
                    message_colour = G.C.RED,
                    message_key = 'a_mult'
                })
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})