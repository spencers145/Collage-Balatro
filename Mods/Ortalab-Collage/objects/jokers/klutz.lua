SMODS.Joker({
    key = "klutz",
    atlas = "jokers",
    pos = {x = 2, y = 14},
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {hand_size = 1, hands = -1, discards = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hand_size, card.ability.extra.hands, card.ability.extra.discards}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_hands_played(card.ability.extra.hands)
        ease_discard(card.ability.extra.discards)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
        ease_hands_played(-1*card.ability.extra.hands)
        ease_discard(-1*card.ability.extra.discards)
        G.hand:change_size(-1*card.ability.extra.hand_size)
    end,
})

--[[SMODS.JimboQuip({
    key = 'klutz',
    extra = {
        center = 'j_ortalab_klutz',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_klutz')) then
            if type == 'loss' then
                return true, { weight = 5 }
            end
		end
    end
})]]