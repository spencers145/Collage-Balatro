local scopophobia = {
    object_type = "Consumable",
	key = 'scopophobia',
	set = 'Spectral',
    atlas = 'consumable_atlas',
	pos = { x = 0, y = 7 },
	cost = 4,
	discovered = false,
    order = 8,
	config = {},
    in_pool = function (self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 3
    end,
    can_use = function(self, card)
        local mod = 0
        for i = 1, #G.consumeables.cards do
            if card == G.consumeables.cards[i] then
                mod = 1
                print('found')
            end
        end
        
        return G.consumeables and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + mod
        --[[if G.hand and G.hand.cards and #G.hand.cards > 0 then
            local viable_options = {}
            for k, v in pairs(G.jokers.cards) do
                if G.jokers.cards[k] and not SMODS.is_eternal(G.jokers.cards[k]) then
                    viable_options[#viable_options+1] = v
                end
            end
            if #viable_options > 0 then
                return true
            end
        end
        return false]]
    end,
	use = function(self, card, area, copier)
        local viable_options = {}
        for k, v in pairs(G.jokers.cards) do
            if G.jokers.cards[k] and not SMODS.is_eternal(G.jokers.cards[k]) then
                viable_options[#viable_options+1] = v
            end
        end
        local _card = pseudorandom_element(viable_options, pseudoseed('scopophobia'))
        
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.5,
            func = function()
                if _card then
                    _card:start_dissolve()
                end
                return true
            end
        }))

        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.5,
                func = function()
                    SMODS.add_card {
                        set = "Statement",
                        area = G.consumables,
                        key_append = 'scopophobia',
                    }
                    --play_sound('tma_statement1')
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
        end
        -- ok now do it again
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.3,
                func = function()
                    SMODS.add_card {
                        set = "Statement",
                        area = G.consumables,
                        key_append = 'scopophobia',
                    }
                    --play_sound('tma_statement1')
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
        end
    end,
}
return {name = {"Spectrals"}, items = {scopophobia}}