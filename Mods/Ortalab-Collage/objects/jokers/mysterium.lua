SMODS.Joker({
	key = "mysterium",
	atlas = "jokers",
	pos = {x = 2, y = 8},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 4, secret_hand_list = {}}},
	artist_credits = {'flowwey'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.x_mult}}
    end,
    calculate = function(self, card, context) --The Mysterium Logic
        if context.joker_main and G.GAME.ortalab.secret_hand_list[context.scoring_name] then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
    end
})