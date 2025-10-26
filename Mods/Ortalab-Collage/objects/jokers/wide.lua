SMODS.Joker({
    key = "wide",
    atlas = "jokers",
    pos = {x = 8, y = 14},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {extra = {mult = 0, gain = 2, rank = "Ace"}},
    artist_credits = {'kosze'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, card.ability.extra.mult, localize(card.ability.extra.rank, 'ranks')}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card.base.value == card.ability.extra.rank then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "gain",
                    message_colour = G.C.RED
                })
            end
        end
    end    
})

local hover = Card.hover
function Card:hover()
    hover(self)
    if self.config.center_key == 'j_ortalab_wide' and self.T.w == G.CARD_W and not Ortalab.config.wide_joker and self.config.center.discovered then
        ease_value(self.T, 'w', self.T.w, nil, nil, nil, nil, 'elastic')
        ease_value(self.T, 'h', -(self.T.h/2), nil, nil, nil, nil, 'elastic')
    end
end

local stop_hover = Card.stop_hover
function Card:stop_hover()
    stop_hover(self)
    if self.config.center_key == 'j_ortalab_wide' and self.T.w > G.CARD_W and not Ortalab.config.wide_joker and self.config.center.discovered then
        ease_value(self.T, 'w', G.CARD_W - self.T.w)
        ease_value(self.T, 'h', G.CARD_H - self.T.h)
    end
end