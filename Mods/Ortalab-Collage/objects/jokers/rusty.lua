SMODS.Joker({
	key = "rusty",
	atlas = "jokers",
	pos = {x = 0, y = 9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	in_pool = function ()
        for key, value in pairs(G.playing_cards) do
            if SMODS.has_enhancement(value, 'm_ortalab_rusty') then
                return true
            end
        end
        return false
    end,
	config = {extra = {gain = 0.15}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS['m_ortalab_rusty']
        return {vars = {card.ability.extra.gain}}
    end
})