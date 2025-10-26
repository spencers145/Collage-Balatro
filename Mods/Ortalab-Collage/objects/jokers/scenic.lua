SMODS.Joker({
	key = "scenic",
	atlas = "jokers",
	pos = {x = 5, y = 4},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	artist_credits = {'kosze'},
	config = {extra = {levels = 1, hand_1 = 'Straight', hand_2 = 'Straight Flush'}},
	loc_vars = function(self, info_queue, card)
		return {vars = {localize(card.ability.extra.hand_1, 'poker_hands'), localize(card.ability.extra.hand_2, 'poker_hands')}}
	end,
	--[[calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and context.beat_boss then
			return {
				level_up = card.ability.extra.levels,
				level_up_hand = card.ability.extra.hand_1,
				extra = {
					level_up = card.ability.extra.levels,
					level_up_hand = card.ability.extra.hand_2
				}
			}
		end
	end]]
})

--[[SMODS.JimboQuip({
    key = 'scenic_route',
    extra = {
        center = 'j_ortalab_scenic',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_scenic')) then
            if type == 'loss' then
                return true, { weight = 5 }
            end
		end
    end
})]]