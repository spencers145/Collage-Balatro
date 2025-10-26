SMODS.Joker({
	key = "pickaxe",
	atlas = "jokers",
	pos = {x = 9, y = 5},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
    config = {extra = {xmult = 1, gain = 0.2}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.gain}}
    end,
    in_pool = function(self, args)
        for _, card in ipairs(G.playing_cards) do
            if SMODS.has_no_rank(card) then return true end
        end
        return false
    end,
    calculate = function(self, card, context)
        if context.destroying_card and (context.destroying_card.config.center.no_rank or context.destroying_card.config.center_key == 'm_stone') and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "xmult",
                scalar_value = "gain",
                message_key = 'a_xmult'
            })
            return {
                remove = true,
                no_retrigger = true
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
    end
})