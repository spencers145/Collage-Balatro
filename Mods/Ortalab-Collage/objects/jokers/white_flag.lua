SMODS.Joker({
	key = "white_flag",
	atlas = "jokers",
	pos = {x = 8,y = 1},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {mult_add = 7}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult_add, card.ability.extra.mult_add*G.GAME.current_round.discards_left}}
    end,
    calculate = function (self, card, context) --Graffiti logic
        if context.joker_main and G.GAME.current_round.discards_left > 0 then
            return {
                mult = card.ability.extra.mult_add*G.GAME.current_round.discards_left,
                colour = G.C.MULT
            }
        end
    end
})

--[[SMODS.JimboQuip({
    key = 'white_flag',
    extra = {
        center = 'j_ortalab_white_flag',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_white_flag')) then
            if type == 'loss' then
                return true, { weight = 5 }
            end
		end
    end
})]]