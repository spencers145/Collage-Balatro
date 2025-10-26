SMODS.Joker {
	key = 'sd_card',
	config = { extra = { extra_slots = 1 } },
	rarity = 1,
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
    no_pool_flag = "sd_full",
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	display_size = { w = 71 * 0.5, h = 95 * 0.5 },
	pos = { x = 2, y = 4 },
	cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_slots } }
    end,
	add_to_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.extra_slots
		G.GAME.pool_flags.sd_full = true
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.extra_slots
    end,
	joker_display_def = function (JokerDisplay)
		--- @type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "extra_slots" },
				{ text = " consumable", colour = G.C.GREY }
			},
			text_config = { colour = G.C.ORANGE }
		}
	end
}

SMODS.Joker {
	key = 'the_cooler_sd_card',
	config = { extra = { extra_slots = 3 } },
	rarity = 3,
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
    yes_pool_flag = "sd_full",
    eternal_compat = true,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	display_size = { w = 71 * 0.5, h = 95 * 0.5 },
	pos = { x = 3, y = 4 },
	cost = 8,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_slots } }
    end,
	add_to_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.extra_slots
    end,
    remove_from_deck = function (self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.extra_slots
    end,
	joker_display_def = function (JokerDisplay)
		--- @type JDJokerDefinition
		return {
			text = {
				{ text = "+" },
				{ ref_table = "card.ability.extra", ref_value = "extra_slots" },
				{ text = " consumables", colour = G.C.GREY }
			},
			text_config = { colour = G.C.ORANGE }
		}
	end
}