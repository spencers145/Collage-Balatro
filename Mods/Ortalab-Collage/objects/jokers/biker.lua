SMODS.Joker({
    key = "biker",
    atlas = "jokers",
    pos = {x = 5, y = 8},
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {gain = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + 0.01
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
    end
})

--[[SMODS.JimboQuip({
    key = 'biker_1',
    extra = {
        center = 'j_ortalab_biker',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if next(SMODS.find_card('j_ortalab_biker')) then
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