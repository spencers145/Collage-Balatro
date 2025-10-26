SMODS.Joker({
	key = "revolver",
	atlas = "jokers",
	pos = {x = 0, y = 1},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, modifier = 8}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.modifier, card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            if card.area.cards[1] == card then return end
            if not card.getting_sliced and not card.area.cards[1].ability.eternal and not card.area.cards[1].getting_sliced then 
                local sliced_card = card.area.cards[1]
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = 0
                    card:juice_up(0.8, 0.8)
                    sliced_card:start_dissolve({HEX("dc486f")}, nil, 1.6)
                    play_sound('ortalab_gun1', 0.96+math.random()*0.08)
                return true end }))

                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_table = sliced_card,
                    scalar_value = "sell_cost",
                    operation = function(ref_table, ref_value, initial, scaling)
                        ref_table[ref_value] = initial + ref_table.modifier*scaling
                    end,
                    scaling_message = {
                        message = localize{type = 'variable', key = 'a_chips', vars = {card.ability.extra.modifier*sliced_card.sell_cost}},
                        colour = G.C.BLUE,
                        no_juice = true
                    }
                })
            end
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end
})

SMODS.Sound({
    key = 'gun1',
    path = 'gun1.ogg'
})

--[[SMODS.JimboQuip({
    key = 'revolver',
    extra = {
        center = 'j_ortalab_revolver',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_revolver')) then
            if type == 'win' then
                return true, { weight = 5 } 
            end
		end
    end
})]]