SMODS.Joker {
	key = 'all_eyes_on_you',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { } },
	rarity = 2,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 7, y = 3 },
	cost = 4,
	calculate = function(self, card, context)
        local spawn_tarot = 0
		if context.remove_playing_cards and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            for k, v in pairs(context.removed) do
                if v:get_id() == 9 or v:get_id() == 8 or v:get_id() == 7 then
                    spawn_tarot = spawn_tarot + 1
                end
            end
            if spawn_tarot > G.consumeables.config.card_limit + G.GAME.consumeable_buffer - #G.consumeables.cards then
                spawn_tarot = G.consumeables.config.card_limit + G.GAME.consumeable_buffer - #G.consumeables.cards
            end
            for i = 1, spawn_tarot do
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (
                        function()
                            local card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_death')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                            return true
                        end)
                }))
            end
            return {
                message = localize { type = 'variable', key = 'k_plus_x_tarot', vars = { spawn_tarot } },
                colour = G.C.PURPLE
            }
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "tarot_count", retrigger_type = "mult" }
            },
            reminder_text = {
                { text = "(on destroy)"}
            },
            text_config = { colour = G.C.PURPLE },
            reminder_text_config = { scale = 0.3, colour = G.C.GREY },
            calc_function = function (card)
                card.joker_display_values.tarot_count = 0
                for k, v in pairs(G.hand.highlighted) do
                    if v:get_id() == 9 or v:get_id() == 8 or v:get_id() == 7 then
                        card.joker_display_values.tarot_count = card.joker_display_values.tarot_count + 1
                    end
                end
            end
        }
    end
}