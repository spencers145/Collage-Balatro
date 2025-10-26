SMODS.Joker({
	key = "crime_scene",
	atlas = "jokers",
	pos = {x = 6, y = 7},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {banned_cards = {}}},
	artist_credits = {'grassy'},
	remove_from_deck = function(self, card, from_debuff)
		for _, key in ipairs(card.ability.extra.banned_cards) do
            G.GAME.banned_keys[key] = nil
        end
	end,
})

local CardDissolve = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
    local crime_scene = SMODS.find_card('j_ortalab_crime_scene')
	if next(crime_scene) and self.ability.set == 'Joker' then
		sendDebugMessage("test")
		G.GAME.banned_keys[self.config.center_key] = true
        table.insert(crime_scene[1].ability.extra.banned_cards, self.config.center_key)
	end
	return CardDissolve(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

