SMODS.Joker { -- 5k, 50k, 100k
    key = "sayajimbo",
    name = "Sayajimbo",
    atlas = 'sayatlas',
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = {
		    chips = 40, mult = 20, xmult = 3, emult = 1.30, curr = 0, need = 1, score = 5000, level = 0,
		    pos_override = { x = 0, y = 0 } -- default like normal pos
		},
    },
    loc_txt = {set = 'Joker', key = 'j_buf_sayajimbo'},
    loc_vars = function(self, info_queue, card)
		if card.ability.extra.level ~= 0 then
			return {
				key = self.key..'_s'..tostring(card.ability.extra.level),
				vars = {
					card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.emult, 
					card.ability.extra.curr, card.ability.extra.need, card.ability.extra.score
				}
			}
		else
			return {
				vars = {
					card.ability.extra.chips, card.ability.extra.score
				}
			}
		end
    end,
	-------- THANKS, FLOWIRE! --------
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				return true
			end
		}))
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local level = {
				[0] = {chips = card.ability.extra.chips},
				[1] = {mult = card.ability.extra.mult},
				[2] = {xmult = card.ability.extra.xmult},
				[3] = {emult = card.ability.extra.emult}
			}
            return level[card.ability.extra.level]
        end
		if context.after and not context.blueprint and not context.repetition and not context.other_card then
			local hand_score = hand_chips * mult
			local req_score = card.ability.extra.score
			if buf.compat.talisman then
				hand_score = to_number(hand_score)
				req_score = to_number(req_score)
			end
			if hand_score >= req_score then
				card.ability.extra.curr = card.ability.extra.curr + 1
				if card.ability.extra.curr >= card.ability.extra.need and card.ability.extra.level < 3 then
					card.ability.extra.curr = 0
					card.ability.extra.need = card.ability.extra.need + 2
					card.ability.extra.level = card.ability.extra.level + 1
					card.ability.extra.score = (card.ability.extra.level == 1 and 50000) or 100000
					G.E_MANAGER:add_event(Event({
						func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
							card:juice_up(1, 0.5)
							card.ability.extra.pos_override.x = card.ability.extra.level
							card.children.center:set_sprite_pos(card.ability.extra.pos_override)
						return true end}))
						SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.FILTER}, card)
						return true
						end
					}))
					return
				elseif card.ability.extra.level < 3 then
					return {
						message = card.ability.extra.curr..'/'..card.ability.extra.need,
						colour = G.C.FILTER
					}
				end
			end
		end
    end
}