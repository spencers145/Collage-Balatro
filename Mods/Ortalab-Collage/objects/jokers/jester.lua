SMODS.Joker({
	key = "jester",
	atlas = "jokers",
	pos = {x = 0, y = 0},
	rarity = 1,
	cost = 2,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 25}},
    artist_credits = {'crimson'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips, 
            }
        end
    end
})

--[[SMODS.JimboQuip({
    key = 'generic_1',
    extra = {
        center = 'j_ortalab_jester',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'win' then
            self.extra.text_key = self.key..'_win'
            return true, { weight = 1 } 
        elseif type == 'loss' then
            self.extra.text_key = self.key..'_loss'
            return true, { weight = 1 }
        end
    end
})]]

--[[SMODS.JimboQuip({
    key = 'generic_2',
    extra = {
        center = 'j_ortalab_jester',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'win' then
            self.extra.text_key = self.key..'_win'
            return true, { weight = 1 } 
        elseif type == 'loss' then
            self.extra.text_key = self.key..'_loss'
            return true, { weight = 1 }
        end
    end
})]]

--[[SMODS.JimboQuip({
    key = 'generic_3',
    extra = {
        center = 'j_ortalab_jester',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'win' then
            self.extra.text_key = self.key..'_win'
            return true, { weight = 1 } 
        elseif type == 'loss' then
            self.extra.text_key = self.key..'_loss'
            return true, { weight = 1 }
        end
    end
})]]