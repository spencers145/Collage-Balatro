SMODS.Joker({
	key = "watching_eye",
	atlas = "jokers",
	pos = {x=1,y=14},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {base_mult = 35, modifier = 3}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.base_mult, card.ability.extra.modifier}}
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local temp_Mult, temp_ID = 0, 0
            local open_palm_card = nil
            for i=1, #G.hand.cards do
                if temp_ID <= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then temp_Mult = G.hand.cards[i].base.nominal; temp_ID = G.hand.cards[i].base.id; open_palm_card = G.hand.cards[i] end
            end
            if next(SMODS.find_card('j_ortalab_wallet')) then
                for i=1, #G.play.cards do
                    if temp_ID <= G.play.cards[i].base.id and not SMODS.has_no_rank(G.play.cards[i]) then temp_Mult = G.play.cards[i].base.nominal; temp_ID = G.play.cards[i].base.id; open_palm_card = G.play.cards[i] end
                end
            end
            if open_palm_card == context.other_card then 
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        mult = card.ability.extra.base_mult - (temp_Mult*card.ability.extra.modifier),
                        card = card,
                    }
                end
            end
        end
    end
})