SMODS.Joker{
	key = "laidback",
    name = "Laidback Joker",
    atlas = 'buf_jokers',
    pos = {
        x = 0,
        y = 0,
    },
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { Xmult = 4 }        
    },
    loc_txt = {set = 'Joker', key = 'j_buf_laidback'},
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    add_to_deck = function(from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1  -- Removes a joker slot when added 
        end
    end,
    remove_from_deck = function(from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1  -- Adds the slot back when sold or otherwise removed
        end
    end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.Xmult
            }
        end
	end
}