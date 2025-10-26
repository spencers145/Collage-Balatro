SMODS.Joker({
    key = "rea",
    atlas = "jokers",
    pos = {x = 0, y = 12},
    soul_pos = {x = 1, y = 12},
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {base = 1, increase = 0.15}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.base, card.ability.extra.increase}}
    end,
    calculate = function(self, card, context)
        if context.before then
            local modifiers = {
                editions = {},
                enhancements = {},
                seals = {},
                curses = {}
            }
            for _, playing_card in ipairs(context.scoring_hand) do
                local playing_card_info = {
                    enhancement = playing_card.ability.set == 'Enhanced' and playing_card.config.center or nil,
                    edition = playing_card.edition and playing_card.edition.type or nil,
                    seal = playing_card.seal or nil,
                    curse = playing_card.curse or nil
                }
                if playing_card_info.enhancement then modifiers.enhancements[playing_card_info.enhancement] = true end
                if playing_card_info.edition then modifiers.editions[playing_card_info.edition] = true end
                if playing_card_info.seal then modifiers.seals[playing_card_info.seal] = true end
                if playing_card_info.curse then modifiers.curses[playing_card_info.curse] = true end
            end
            card.ability.extra.modifier_count = 0
            for _, t in pairs(modifiers) do
                card.ability.extra.modifier_count = card.ability.extra.modifier_count + table.size(t)
            end
        end
        if context.individual and context.cardarea == G.play then
            return {
                xmult = card.ability.extra.base + (card.ability.extra.increase * card.ability.extra.modifier_count)
            }
        end
    end    
})

--[[SMODS.JimboQuip({
    key = 'rea_loss',
    extra = {
        center = 'j_ortalab_rea',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
        if type == 'loss' then
            self.extra.text_key = self.key..'_'..math.random(1,2)
            return true, { weight = 1 }
        end
    end
})]]