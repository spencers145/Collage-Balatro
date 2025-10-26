SMODS.Joker({
	key = "black_cat",
	atlas = "jokers",
	pos = {x=2,y=9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {xmult = 1, gain = 0.2, chips = 100}},
	artist_credits = {'kosze'},
	enhancement_gate = 'm_ortalab_recycled',
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.gain, card.ability.extra.xmult, card.ability.extra.chips}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
		if (context.tag_added and not context.tag_added.from_recycled) or (to_big(context.ortalab_black_cat_scale or 0) >= to_big(card.ability.extra.chips)) or (context.individual and context.other_card.recycled_tag) and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "xmult",
				scalar_value = "gain",
				message_key = 'a_xmult'
			})
		end
	end
})

--[[SMODS.JimboQuip({
    key = 'black_cat_1',
    extra = {
        center = 'j_ortalab_black_cat',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_black_cat')) then
            if type == 'win' then
                self.extra.text_key = self.key..'_win'
                return true, { weight = 5 } 
            elseif type == 'loss' then
                self.extra.text_key = self.key..'_loss'
                return true, { weight = 5 }
            end
		end
    end
})]]