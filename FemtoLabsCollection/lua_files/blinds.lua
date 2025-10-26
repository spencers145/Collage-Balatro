local valley = SMODS.Blind{
	name = "flc_Valley",
	slug = "flc_valleyvalley", 
	key = 'flc_valley',
	atlas = 'bl_flc_blinds',
	pos = {x = 0, y = 0},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('a3832d'),
	loc_txt = {
        	['default'] = {
			name = "The Valley",
			text = {
				"all played hands",
				"have its cards destroyed"
			}
		}
	}
}

valley.after_hand = function(self, card)
    if G.GAME.facing_blind and not G.GAME.blind.disabled then
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.8,
            func = (function()
                if card.ability.name == 'Glass Card' then 
                    card:shatter()
                    card.shattered = true
                else
                    card:start_dissolve(nil, false)
                    card.destroyed = true
                end
                delay(0.1)
                return true
            end)}))
        return true
    end
end

valley.after_discard = function(self, card)
    return false
end

--------

local bell = SMODS.Blind{
	name = "flc_Bell",
	slug = "flc_bell", 
	key = 'flc_bell',
	atlas = 'bl_flc_blinds',
	pos = {x = 0, y = 1},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 3, max = 10},
	boss_colour = HEX('5953A0'),
	loc_txt = {
        	['default'] = {
			name = "The Bell",
			text = {
				"Played cards lose all",
				"modifiers after hand scores"
			}
		}
	}
}

bell.after_hand = function(self, card, id)
    if G.GAME.facing_blind and not G.GAME.blind.disabled then
        local do_debuff = false
        do_debuff = (card.config.center ~= G.P_CENTERS.c_base) or card.edition or card.seal or card.ability.perma_bonus or card.ability.perma_mult

        if do_debuff then 
            delay(0.8)
            G.GAME.blind.triggered = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.0, func = function() 
                if card.config.center ~= G.P_CENTERS.c_base then
                    card:set_ability('c_base', nil, true)
                    card:juice_up()
                    card.vampired = nil
                end
                if card.edition then
                    card:set_edition(nil, true)
                end
                if card.seal then
                    card:set_seal(nil, false, true)
                    card.seal = nil
                end
                if card.ability.perma_bonus then
                    card.ability.perma_bonus = 0
                end

                if card.ability.perma_mult then
                    card.ability.perma_mult = 0
                end

				if card.ability.perma_x_mult then
                    card.ability.perma_x_mult = 0
                end

				if card.ability.perma_x_chips then
                    card.ability.perma_x_chips = 0
                end

                if card.ability.perma_h_chips then
                    card.ability.perma_h_chips = 0
                end

                if card.ability.perma_h_mult then
                    card.ability.perma_h_mult = 0
                end

				if card.ability.perma_h_x_mult then
                    card.ability.perma_h_x_mult = 0
                end

				if card.ability.perma_h_x_chips then
                    card.ability.perma_h_x_chips = 0
                end

				if card.ability.perma_p_dollars then
                    card.ability.perma_p_dollars = 0
                end

				if card.ability.perma_h_dollars then
                    card.ability.perma_h_dollars = 0
                end

				for k, v in pairs(SMODS.Stickers) do
					if card.ability[k] then card.ability[k]:apply(card, false) end
				end

                play_sound('cancel', 0.7 + 0.05 * id, 0.7) 
                SMODS.juice_up_blind()
                return true end })) 
        end
    end
end

--------

local crow = SMODS.Blind{
	name = "flc_Crow",
	slug = "flc_crow", 
	key = 'flc_crow',
	atlas = 'bl_flc_blinds',
	pos = {x = 0, y = 2},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('4D4660'),
	loc_txt = {
        	['default'] = {
			name = "The Crow",
			text = {
				"Cannot play cards",
				"higher than 9s"
			}
		}
	}
}

crow.debuff_hand = function(self, cards, hand, handname, check)
    local FUCK = false

    for i=1, #cards do
        if cards[i]:get_id() > 9 then
            FUCK = true
            break
        end
    end

	G.GAME.blind.triggered = true

    return FUCK
end

--------

local fern = SMODS.Blind{
	name = "flc_Fern",
	slug = "flc_fern", 
	key = 'flc_fern',
	atlas = 'bl_flc_blinds',
	pos = {x = 0, y = 4},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 4, max = 10},
	boss_colour = HEX('7D811F'),
	loc_txt = {
        	['default'] = {
			name = "The Fern",
			text = {
				"Must have Enhanced",
                "cards held in hand"
			}
		}
	}
}

fern.debuff_hand = function(self, cards, hand, handname, check)
    local FUCK = true

    for i=1, #G.hand.cards do
        if G.hand.cards[i].ability.set == 'Enhanced' and not G.hand.cards[i].highlighted then
            FUCK = false
            break
        end
    end

    return FUCK
end

--------

local teal = SMODS.Blind{
	name = "flc_TealTempest",
	slug = "flc_teal_tempest",
	key = 'flc_teal_tempest',
	atlas = 'bl_flc_blinds',
	pos = {x = 0, y = 3},
	dollars = 8, 
	mult = 1, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10, showdown = true},
	boss_colour = HEX('399290'),
	loc_txt = {
        	['default'] = {
			name = "Teal Tempest",
			text = {
				"XMult effects",
                "do not trigger"
			}
		}
	}
}

teal.debuff_xmult = function(self)
    return not G.GAME.blind.disabled
end

local eval_cardRef = eval_card

function eval_card(card, context)
    local ret, post = eval_cardRef(card, context)
    if G.GAME.blind and G.GAME.blind.config.blind.debuff_xmult and G.GAME.blind.config.blind:debuff_xmult() then
        if ret.x_mult then ret.x_mult = nil end
        if ret.edition and card.edition and card.edition.polychrome then ret.edition = nil end
        if ret.jokers and ret.jokers.x_mult_mod then ret.jokers.x_mult_mod = nil end
        if ret.jokers and ret.jokers.Xmult_mod then ret.jokers.Xmult_mod = nil end
    end
    return ret, post
end

local cj = Card.calculate_joker

function Card:calculate_joker(context)
    local ret = cj(self, context)
    if ret and G.GAME.blind and G.GAME.blind.config.blind.debuff_xmult and G.GAME.blind.config.blind:debuff_xmult() then

        if ret.x_mult then ret.x_mult = nil end
        if ret.Xmult_mod then 
            ret.Xmult_mod = nil 
            if ret.message then ret.message = nil end
        end
    end

    return ret
end

local xmultRef = Card.get_chip_x_mult

function Card:get_chip_x_mult(context)
    local ret = xmultRef(self, context)
    if G.GAME.blind and G.GAME.blind.config.blind.debuff_xmult and G.GAME.blind.config.blind:debuff_xmult() then
        return 0
    end
    return ret
end

local hxmultRef = Card.get_chip_h_x_mult

function Card:get_chip_h_x_mult(context)
    local ret = hxmultRef(self, context)
    if G.GAME.blind and G.GAME.blind.config.blind.debuff_xmult and G.GAME.blind.config.blind:debuff_xmult() then
        return 0
    end
    return ret
end