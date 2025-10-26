SMODS.Shader({key = 'greyscale', path = "greyscale.fs"})
SMODS.Shader({key = 'fluorescent', path = "fluorescent.fs"})
SMODS.Shader({key = 'anaglyphic', path = "anaglyphic.fs"})
SMODS.Shader({key = 'overexposed', path = "overexposed.fs"})


SMODS.Sound({
    key = 'anaglyphic',
    path = 'anaglyphic.ogg'
})

SMODS.Sound({
    key = 'fluorescent',
    path = 'fluorescent.ogg'
})

SMODS.Sound({
    key = 'greyscale',
    path = 'greyscale.ogg'
})

SMODS.Edition({
    key = "anaglyphic",
    discovered = false,
    unlocked = true,
    shader = 'anaglyphic',
    sound = { sound = "ortalab_anaglyphic", per = 0.85, vol = 0.8 },
    config = { xchips = 1.25, xmult = 1.25 },
    in_shop = true,
    weight = 1.5,
    extra_cost = 5,
    artist_credits = {'eremel'},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.xchips, self.config.xmult}}
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                xchips = card.edition.xchips,
                xmult = card.edition.xmult
            }     
        end
    end
})

--[[SMODS.Edition({
    key = "fluorescent",
    discovered = false,
    unlocked = true,
    shader = 'fluorescent',
    sound = { sound = "ortalab_fluorescent", per = 0.85, vol = 0.8 },
    config = { p_dollars = 4 },
    in_shop = true,
    weight = 12,
    extra_cost = 4,
    artist_credits = {'superb'},
    loc_vars = function(self, info_queue, card)
        return { vars = {self.config.p_dollars}, key = card and card.config and card.config.center.set == 'Joker' and 'e_ortalab_fluorescent_joker'}
    end,
    calculate = function(self, card, context)
        if (card.ability.set == 'Joker' and context.end_of_round and context.main_eval) or (context.main_scoring and context.cardarea == G.play) then
            return {
                dollars = card.edition.p_dollars
            }     
        end
    end
})]]

SMODS.Edition({
    key = "greyscale",
    shader = "greyscale",
    sound = { sound = "ortalab_greyscale", per = 0.95, vol = 1.4 },
    discovered = false,
    unlocked = true,
    config = {swap = true},
    in_shop = true,
    weight = 6,
    extra_cost = 3,
    badge_colour = HEX("858585"),
    artist_credits = {'eremel'},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.chips, self.config.mult, self.config.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                swap = true,
                message = localize('ortalab_swap'),
                colour = G.C.PURPLE
            }     
        end
    end
})

SMODS.Sound({
    key = 'overexposed',
    path = 'overexposed.ogg'
})

--[[SMODS.Edition({
    key = "overexposed",
    discovered = false,
    unlocked = true,
    shader = 'overexposed',
    sound = { sound = "ortalab_overexposed", per = 1.2, vol = 0.8 },
    config = { extra = {retriggers = 1 }},
    in_shop = true,
    weight = 3,
    extra_cost = 5,
    artist_credits = {'eremel'},
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end,
    calculate = function(self, card, context)
        if context.repetition_only or (context.retrigger_joker_check and context.other_card == card) then
            return {
                repetitions = card.edition.extra.retriggers,
                colour = G.C.GREEN,
            }     
        end
    end
})]]