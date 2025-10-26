local editionInfo = {
    key = 'plasma',
    shader = 'plasma',
    config = { pow_mult = 1.1 },
    in_shop = true,
    weight = 2, 
    extra_cost = 5,
    apply_to_float = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.pow_mult } }
    end,
    get_weight = function(self)
        return (G.GAME.edition_rate - 1) * G.P_CENTERS["e_negative"].weight + G.GAME.edition_rate * self.weight
    end,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                pow_mult = card.edition.pow_mult
            }
        end
    end
}

return editionInfo
