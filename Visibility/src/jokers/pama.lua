SMODS.Joker {
	key = "pama",
	atlas = "TextureAtlasJokers",
	discovered = false,
	unlocked = true,
	blueprint_compat = false,
	rarity = 3,
	pools = { ["Visibility"] = true },
	cost = 8,
	pos = { x = 6, y = 3 },
	config = { extra = { } },
    credits = {
        idea = "One Punch Idiot"
    }
}

-- Hook(s) for Red/Purple seal
local pdl = Card.get_p_dollars
function Card:get_p_dollars()
    local ret = pdl(self)
    if self.seal == 'Purple' and next(SMODS.find_card("j_vis_pama")) then
        ret = ret + 3
    end
    return ret
end

local geore = Card.get_end_of_round_effect
function Card:get_end_of_round_effect(context)
    local ret = geore(self, context)
    if (self.seal == 'Red' and next(SMODS.find_card("j_vis_pama"))) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        local card_type = 'Planet'
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = (function()
                if G.GAME.last_hand_played then
                    local _planet = 0
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end
                    local card = create_card(card_type,G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                end
                return true
            end)}))
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
        ret.effect = true
    end
    return ret
end

-- Hook for Blue/Gold seal
local cs = Card.calculate_seal
function Card:calculate_seal(context)
    local ret = cs(self, context)
    if context.repetition then
        if self.seal == 'Blue' and next(SMODS.find_card("j_vis_pama")) then
            ret = {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = self
            }
        end
    end
    if context.discard and context.other_card == self then
        if (self.seal == 'Gold' and next(SMODS.find_card("j_vis_pama"))) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = (
                function()
                    local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'pama')
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    G.GAME.consumeable_buffer = 0
                    return true
                end)}))
            card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
        end
    end
    return ret
end