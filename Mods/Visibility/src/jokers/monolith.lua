SMODS.Joker {
	key = 'monolith',
	discovered = false,
	unlocked = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = { extra = { xmult = 1, xmult_mod = 0.2, poker_hands = {'High Card', 'High Card'} } },
	rarity = 3,
	pools = { ["Visibility"] = true },
	atlas = 'TextureAtlasJokers',
	pos = { x = 6, y = 4 },
	cost = 8,
	loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, localize(card.ability.extra.poker_hands[1], 'poker_hands'), localize(card.ability.extra.poker_hands[2], 'poker_hands'), card.ability.extra.xmult } }
	end,
	calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if not (context.scoring_name == card.ability.extra.poker_hands[1] or context.scoring_name == card.ability.extra.poker_hands[2]) then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize('k_upgrade_ex', { vars = { card.ability.extra.xmult } })
                }
            else
                -- Reset mult
                card.ability.extra.xmult = 1
                return {
                    message = localize('k_reset')
                }
            end
        end
        if context.after then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and (k ~= card.ability.extra.poker_hands[1] and k ~= card.ability.extra.poker_hands[2]) then
                    _poker_hands[#_poker_hands + 1] = k
                end
            end
            local poker_hand, poker_hand_key = pseudorandom_element(_poker_hands, pseudoseed('monolith'))
            table.remove(_poker_hands, poker_hand_key)
            card.ability.extra.poker_hands[1] = poker_hand
            card.ability.extra.poker_hands[2] = pseudorandom_element(_poker_hands, pseudoseed('monolith'))
            return {
                message = localize('k_shuffle')
            }
        end
        if context.joker_main then
            if card.ability.extra.xmult > 1 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible and (k ~= card.ability.extra.poker_hands[1] and k ~= card.ability.extra.poker_hands[2]) then
                _poker_hands[#_poker_hands + 1] = k
            end
        end
        local poker_hand, poker_hand_key = pseudorandom_element(_poker_hands, pseudoseed('monolith'))
        table.remove(_poker_hands, poker_hand_key)
        card.ability.extra.poker_hands[1] = poker_hand
        card.ability.extra.poker_hands[2] = pseudorandom_element(_poker_hands, pseudoseed('monolith'))
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                {
                    border_nodes = {
                        { text = "X" },
                        { ref_table = "card.joker_display_values", ref_value = "xmult", retrigger_type = "exp" }
                    }
                }
            },
            extra = {
                {
                    { ref_table = "card.joker_display_values", ref_value = "banned_one" }
                },
                {
                    { ref_table = "card.joker_display_values", ref_value = "banned_two" }
                }
            },
            extra_config = { colour = G.C.RED, scale = 0.3 },
            calc_function = function(card)
                card.joker_display_values.banned_one = localize(card.ability.extra.poker_hands[1], 'poker_hands')
                card.joker_display_values.banned_two = localize(card.ability.extra.poker_hands[2], 'poker_hands')
                local hand = G.hand.highlighted
                local text, _, _ = JokerDisplay.evaluate_hand(hand)
                local hand_exists = text ~= 'Unknown' and G.GAME and G.GAME.hands and G.GAME.hands[text]
                if hand_exists and (card.joker_display_values.banned_one == text or card.joker_display_values.banned_two == text) then
                    card.joker_display_values.xmult = 1
                    return
                end
                card.joker_display_values.xmult = card.ability.extra.xmult
            end
        }
    end
}