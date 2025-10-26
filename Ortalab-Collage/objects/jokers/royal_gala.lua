SMODS.Joker({
	key = "royal_gala",
	atlas = "jokers",
	pos = {x = 0,y = 4},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	yes_pool_flag = 'taliaferro_extinct',
	config = {extra = {xchips = 3, odds = 1000}},
    artist_credits = {'flowwey','grassy','salad','flare'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xchips, SMODS.get_probability_vars(card, 1, card.ability.extra.odds)}}
    end,
    calculate = function(self, card, context) --Royal Gala Logic
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if SMODS.pseudorandom_probability(card, 'royalgala', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
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
                xchips = card.ability.extra.xchips
            }
        end
    end
})

--[[SMODS.JimboQuip({
    key = 'royal_gala',
    extra = {
        center = 'j_ortalab_royal_gala',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_royal_gala')) then
            if type == 'win' then
                return true, { weight = 5 } 
            end
		end
    end
})]]