SMODS.Joker({
	key = "sunnyside",
	atlas = "jokers",
	pos = {x = 1, y = 3},
	rarity = 1,
	cost = 4,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {money = 5}},
    artist_credits = {'eremel'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    calculate = function(self, card, context) --The Mysterium Logic
        if context.setting_blind and not card.getting_sliced then
            if #G.consumeables.cards > 0 then
                local consumable = G.consumeables.cards[1]
                SMODS.scale_card(context.blueprint_card or card, {
                    ref_table = consumable.ability,
                    ref_value = "extra_value",
                    scalar_table = card.ability.extra,
                    scalar_value = "money",
                    scaling_message = {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                })
                consumable:set_cost()
                return nil, true
            end
        end
    end
})