SMODS.Joker {
    key = "cashout",
    name = "Cashout Voucher",
    atlas = 'buf_jokers',
    pos = {
        x = 0,
        y = 2,
    },
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    config = {
        extra = { money = 0.004, xscore = 3 }        
    },
    loc_txt = {set = 'Joker', key = 'j_buf_cashout'},
    calculate = function(self, card, context)
		if context.after and not context.blueprint and not context.repetition and not context.other_card then
			local hand_score = hand_chips * mult
			local req_chips = G.GAME.blind.chips
			if buf.compat.talisman then
				hand_score = to_number(hand_score)
				req_chips = to_number(req_chips)
			end
			if hand_score > card.ability.extra.xscore * req_chips then
				local earned = card.ability.extra.money * G.GAME.blind.chips
				local check = 50
				if buf.compat.talisman then
					earned = to_number(earned)
					check = to_number(check)
				end
				if earned > check then
					earned = 50
				end
				ease_dollars(earned)
				G.E_MANAGER:add_event(Event({
					func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
					  trigger = 'after',
					  delay = 0.3,
					  blockable = false,
					  func = function()
						G.jokers:remove_card(card)
						card:remove()
						card = nil
						return true;
					  end
					}))
					return true
				  end
				}))
				return {
					message = '$'..earned,
                    colour = G.C.MONEY,
				}
			end
		end
    end
}