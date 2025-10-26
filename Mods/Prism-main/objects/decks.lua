SMODS.Atlas {
    key = 'prismdecks',
    path = "decks.png",
    px = 71,
    py = 95
}

function G.PRISM.Back(table)
	if table.dependency or table.dependency == nil then
		SMODS.Back(table)
	end
end

G.PRISM.Back({
	key = "purple", 
	atlas = "prismdecks",
	pos = {x = 2, y = 0},
	--loc_vars = function(self, info_queue, card)
	--	info_queue[#info_queue+1] = {key = 'tag_ortalab_slipup', set = 'Tag'}
	--end,
	trigger_effect = function(self, args)
        if args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
			G.E_MANAGER:add_event(Event({
				trigger = 'after', delay = 0.4,
				func = (function()
					local new_tag = Tag('tag_ortalab_slipup', false, 'Small')
					add_tag(new_tag)
					play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
					play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)
			}))
        end
    end
})
local orig_can_discard = G.FUNCS.can_discard
G.FUNCS.can_discard = function(e)
	if G.GAME.modifiers.purple_deck and G.GAME.current_round.discards_left < 1 and #G.hand.highlighted > 0 and
	(G.GAME.current_round.hands_left > 1 or G.GAME.current_round.discards_left > 1) then 
		e.config.colour = G.C.RED
        e.config.button = 'discard_cards_from_highlighted'
	elseif G.GAME.current_round.hands_left > 0 or G.GAME.current_round.discards_left > 1 then
		orig_can_discard(e)
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
	end
end
G.PRISM.Back({
	dependency = G.PRISM.config.myth_enabled,
	key = "ancient", 
	atlas = "prismdecks",
	pos = {x = 0, y = 0},
	config = { vouchers = { "v_prism_myth_merchant","v_prism_booster_box"}},
    unlocked = false,
    unlock_condition = {type = 'win_stake', stake=6}
})
--[[
G.PRISM.Back({
	key = "market", 
	atlas = "prismdecks",
	pos = {x = 1, y = 0},
	config = { vouchers = { "v_overstock_norm", "v_reroll_surplus"}},
    unlocked = false,
    unlock_condition = {type = 'win_stake', stake=8}
})
]]