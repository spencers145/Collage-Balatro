SMODS.Joker({
	key = "futuristic",
	atlas = "jokers",
	pos = {x=4,y=6},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {xmult = 1.25}},
    artist_credits = {'kosze'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.xmult, card.ability.extra.rank and localize(card.ability.extra.rank, 'ranks') or localize('ortalab_rank'), localize('Straight', 'poker_hands')}}
	end,
    set_ability = function(self, card)
        if G.playing_cards and #G.playing_cards > 0 then
            card.ability.extra.rank = Ortalab.rank_from_deck('ortalab_futuristic')
        end
    end,
	calculate = function(self, card, context)
        if context.before then
            card.ability.extra.ranks = {}
            for _, pcard in ipairs(context.scoring_hand) do
                if not SMODS.has_no_rank(card) then
                    card.ability.extra.ranks[#card.ability.extra.ranks+1] = pcard.base.value
                end
            end
        end
        if context.cardarea == G.play and context.individual and Ortalab.futuristic_check(SMODS.merge_lists({SMODS.Ranks[context.other_card.base.value].next, SMODS.Ranks[context.other_card.base.value].prev}), card.ability.extra.ranks) then
            return {
                x_mult = card.ability.extra.xmult,
                message_card = context.other_card
            }
        end
    end
})

function Ortalab.futuristic_check(consecutive_ranks, ranks_in_hand)
    for _, rank in ipairs(consecutive_ranks) do
        if table.contains(ranks_in_hand, rank) then return true end
    end
    return false
end