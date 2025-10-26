SMODS.Joker{
	key = "maggit",
    name = "Maggit",
    atlas = 'buf_jokers',
    pos = {
        x = 3,
        y = 2,
    },
	soul_pos = {
		x = 3,
		y = 3,
	},
    rarity = 4,
    cost = 20,
    discovered = false,
    unlocked = false,
    unlock_condition = {hidden = true},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { Emult = 1.25, once = 0 }        
    },
    loc_txt = {set = 'Joker', key = 'j_buf_maggit'},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'maggit_info'}
		end
		if card.ability.extra.once == 1 then
			-- for key, _ in pairs(self.loc_txt.text) do
				-- print(key)
			-- end
            return {key = self.key .. '_alt',			
					vars = {card.ability.extra.Emult},
			}
		else
			return {
				vars = {card.ability.extra.Emult}
			}
		end
    end,
	calculate = function(self, card, context)
		local check = false
		if context.setting_blind and not self.getting_sliced then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.numetal and not context.blueprint then
					check = true
					break
				else
					check = false
				end
			end
			if not check and card.ability.extra.once ~= 1 and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				local nujokies = { "j_buf_korny", "j_buf_whitepony", "j_buf_rerollin", "j_buf_fivefingers", "j_buf_clown" }
				local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, jokers_to_create do
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nujokies[math.random(1,#nujokies)], 'mag')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end}))   
				card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
				card.ability.extra.once = 1
			end
		end
        if context.joker_main then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.numetal then
					check = true
					break
				else
					check = false
				end
			end
			if check then
				return {
					emult = card.ability.extra.Emult
				}
			end
		end
	end
}