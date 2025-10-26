SMODS.Joker{
	key = 'primes',
	atlas = 'roffers',
	rarity = 3,
	cost = 7,
	blueprint_compat = true,
    discovered = false,
	perishable_compat = false,
	pos = { x = 4, y = 1 },
	config = { extra = { chips = 0, chip_mod = 17, min_cards = 3 } },
	loc_vars = function(self,info_queue,card)
		return {vars = {card.ability.extra.chip_mod, card.ability.extra.chips, card.ability.extra.min_cards}}
	end,
	calculate = function(self,card,context)
		if context.before and not context.blueprint then
            if #context.scoring_hand > 1 then
                local primes = 0
                for _, c in pairs(context.scoring_hand) do
                    local id = c:get_id()
                    if id == 2 or id == 3 or id == 5 or id == 7 then
                        primes = primes + 1
                    end

                    if primes >= card.ability.extra.min_cards then break end
                end

                if primes >= card.ability.extra.min_cards then
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
                    return {
                        message = localize('k_upgrade_ex')
                    }
                end
            end
        elseif context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
	end
}
