--[[SMODS.Joker {
    key = "denial",
    name = "Arstotzkan Denial",
    atlas = 'buf_jokers',
    pos = {
        x = 2,
        y = 1,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { mult = 0, chips = 0 }        
    },
    loc_txt = {set = 'Joker', key = 'j_buf_denial'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.chips }
        }
    end,
    
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
            }
        end
    end,
	update = function(self, card, dt)
        card.ability.extra.mult = 0
		card.ability.extra.chips = 0
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if v:get_seal() == "Red" then
                    card.ability.extra.mult =  card.ability.extra.mult + 5
				elseif v:get_seal() == "Blue" then
					card.ability.extra.chips = card.ability.extra.chips + 30
                end
            end
        end
    end
}
]]