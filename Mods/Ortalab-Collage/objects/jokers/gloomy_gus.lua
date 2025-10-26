SMODS.Joker({
    key = "gloomy_gus",
    atlas = "jokers",
    pos = {x = 9, y = 14},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {hand_size = 3, discard_limit = 2}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hand_size, card.ability.extra.discard_limit + G.GAME.ortalab.extra_discard_size}}
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
        card.ability.extra.prev_discard = G.GAME.starting_params.discard_limit
        SMODS.change_discard_limit(card.ability.extra.discard_limit - G.GAME.starting_params.discard_limit)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
        SMODS.change_discard_limit(card.ability.extra.prev_discard - card.ability.extra.discard_limit)
    end
})

local can_disc = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
    local gloomy = SMODS.find_card('j_ortalab_gloomy_gus')
    if next(gloomy) then
        if G.GAME.starting_params.discard_limit ~= 1 then
            gloomy[1].ability.extra.prev_discard = gloomy[1].ability.extra.prev_discard + G.GAME.starting_params.discard_limit - gloomy[1].ability.extra.discard_limit
            SMODS.change_discard_limit(gloomy[1].ability.extra.discard_limit - G.GAME.starting_params.discard_limit)
        end
    end
    can_disc(e)
end