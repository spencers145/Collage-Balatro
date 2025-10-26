SMODS.Joker({
	key = "misfits",
	atlas = "jokers",
	pos = {x=4,y=11},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 2.5, count = 4}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.count}}
	end,
    calculate = function(self, card, context)
        if context.joker_main and #context.scoring_hand >= card.ability.extra.count then
            local suits = {}
            local ranks = {}
            local wild_suits = 0
            for _, played_card in ipairs(context.scoring_hand) do
                local suit = played_card.base.suit
                local rank = played_card.base.value
                if SMODS.has_any_suit(played_card) or Ortalab.suit_smear(played_card) then
                    wild_suits = wild_suits + 1
                elseif not SMODS.has_no_suit(played_card) then
                    suits[suit] = suit
                end
                if not SMODS.has_no_rank(played_card) then ranks[rank] = rank end
            end
            local ret1 = {}
            if table.size(suits) + wild_suits >= card.ability.extra.count then
                ret1 = {
                    xmult = card.ability.extra.xmult
                }
            end
            local ret2 = {}
            if table.size(ranks) >= card.ability.extra.count then
                ret2 = {
                    xmult = card.ability.extra.xmult
                }
            end
            return SMODS.merge_effects({ret1, ret2})
        end
    end
})