if not CardSleeves then
    return -- Proper indentation
end

--Poptart Sleeve
CardSleeves.Sleeve {
    atlas = "TextureAtlasSleeves",
    pos = { x = 0, y = 0 },
    config = { vouchers = {'v_losted_stapler'} },
    key = "poptart",
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_vis_poptart" then
            key = self.key .. "_alt"
            self.config.vouchers = {'v_losted_stapler', 'v_losted_staple_gun'}
            vars = { colours = { G.C.SET.Divine } }
        else
            self.config.vouchers = {'v_losted_stapler'}
            key = self.key
        end
        return { key = key, vars = vars }
    end,
    apply = function (self, sleeve)
        CardSleeves.Sleeve.apply(sleeve) -- super() call
        if self.get_current_deck_key() ~= "b_vis_poptart" then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    G.E_MANAGER:add_event(Event({
                        func = function ()
                            G.E_MANAGER:add_event(Event({
                                func = function ()
                                    add_tag(Tag('tag_buffoon'))
                                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                                    return true
                                end
                            }))
                            return true
                        end
                    }))
                    return true
                end
            }))
            --G.GAME.divine_rate = G.GAME.divine_rate * 3
        end
        --G.GAME.visibility_rate = 45
    end
}

-- Gardening Sleeve
CardSleeves.Sleeve {
    atlas = "TextureAtlasSleeves",
    pos = { x = 1, y = 0 },
    key = "gardening",
    loc_vars = function(self)
        local key
        if self.get_current_deck_key() == "b_vis_gardening" then
            key = self.key .. "_alt"
            self.config = { voucher = 'v_bunc_chainsaw', consumables = {'c_tma_exhaustion'} }
        --[[elseif self.get_current_deck_key() == "b_checkered" then
            key = self.key .. "_checkered"
            self.config = {}]]
        else
            key = self.key
            self.config = {}
        end
        return { key = key }
    end,
    calculate = function(self, sleeve, context) --taken from base cardsleeves checkered as it does basically the same thing
        if context.end_of_round and context.main_eval and self.get_current_deck_key() ~= "b_vis_gardening" and self.get_current_deck_key() ~= "b_checkered" then
            local val = pseudorandom_element(G.hand.cards, pseudoseed('b_gardening_sleeve'))
            local _card = copy_card(val, nil, nil, G.playing_card)
            _card.states.visible = false
            
            forced_message("Sprouted!", val)

            G.E_MANAGER:add_event(Event({
            func = function()
                _card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                G.deck:emplace(_card)
                table.insert(G.playing_cards, _card)
                playing_card_joker_effects({true})
                _card:start_materialize()
                return true
            end}))
            delay(0.8)
        end


        if not sleeve.config.force_suits then
            return
        end

        local card = context.card
        local is_playing_card = card and (card.ability.set == "Default" or card.ability.set == "Enhanced") and card.config.card_key
        if (context.create_card or context.modify_playing_card) and card and is_playing_card then
            for from_suit, to_suit in pairs(sleeve.config.force_suits) do
                if card.base.suit == from_suit then
                    local base = SMODS.Suits[to_suit].card_key .. "_" .. SMODS.Ranks[card.base.value].card_key
                    local initial = G.GAME.blind == nil or context.create_card
                    card:set_base(G.P_CARDS[base], initial)
                end
            end
        end
    end,
    --[[apply = function(self, sleeve)
        G.E_MANAGER:add_event(Event({
            func = function()
                if self.get_current_deck_key() == "b_checkered" then
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Clubs' then
                            v:change_suit('bunc_Halberds')
                        end
                        if v.base.suit == 'Diamonds' then
                            v:change_suit('bunc_Fleurons')
                        end
                    end
                    return true
                else if self.get_current_deck_key() == "b_vis_gardening" then
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Spades' then
                            v:change_suit('bunc_Halberds')
                        end
                        if v.base.suit == 'Hearts' then
                            v:change_suit('bunc_Fleurons')
                        end
                    end
                    return true
                end
            end
        end}))
    end,]]
}

-- Checkered Sleeve mixin (hooking)
local checkered_sleeve = CardSleeves.Sleeve:get_obj("sleeve_casl_checkered")
local checkered_sleeve_loc_vars_ref = checkered_sleeve.loc_vars
checkered_sleeve.loc_vars = function(self)
    if self.get_current_deck_key() == "b_vis_gardening" then
        local vars = {}
        checkered_sleeve.apply = function(self, sleeve)
        G.E_MANAGER:add_event(Event({
            func = function()
                if self.get_current_deck_key() == "b_vis_gardening" then
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Clubs' then
                            v:change_suit('Spades')
                        end
                        if v.base.suit == 'Hearts' then
                            v:change_suit('Diamonds')
                        end
                    end
                else
                    for k, v in pairs(G.playing_cards) do
                        if v.base.suit == 'Clubs' then
                            v:change_suit('Spades')
                        end
                        if v.base.suit == 'Diamonds' then
                            v:change_suit('Hearts')
                        end
                    end
                end
                return true
            end
        }))
        end
        return { key = "sleeve_casl_checkered_gardening", vars = vars}
    else
        return checkered_sleeve_loc_vars_ref(self)
    end
end
-- NOTE: possibly handle checkered_sleeve.calculate (need to hook similarly to loc_vars)

-- Heavenly Sleeve (currently functionless)
--[[CardSleeves.Sleeve {
    atlas = "TextureAtlasSleeves",
    pos = { x = 2, y = 0 },
    config = { },
    key = "heavenly",
    loc_vars = function(self)
        local key, vars
        vars = { "Divine Merchant", "Pact", colours = { G.C.SET.Divine } }
        if self.get_current_deck_key() == "b_vis_heavenly" then
            key = self.key .. "_alt"
            vars = { "Divine Tycoon", "Pact", colours = { G.C.SET.Divine } }
        end
        return { key = key, vars = vars }
    end,
    apply = function (self, sleeve)
        local function apply_voucher(key)
            G.GAME.used_vouchers[key] = true
            G.GAME.starting_voucher_count = (G.GAME.starting_voucher_count or 0) + 1
            G.E_MANAGER:add_event(Event({
            func = function()
                Card.apply_to_run(nil, G.P_CENTERS[key])
                return true
            end
        }))
        end
        
        if self.get_current_deck_key() == "b_vis_heavenly" then
            apply_voucher('v_vis_divine_tycoon')
        else
            apply_voucher('v_vis_divine_merchant')
        end
        delay(0.4)
        G.E_MANAGER:add_event(Event({
            func = function()
                local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_vis_pact', 'deck')
                card:add_to_deck()
                G.consumeables:emplace(card)
                return true
            end
        }))
    end
}]]

-- Burnt Sleeve
CardSleeves.Sleeve {
    atlas = "TextureAtlasSleeves",
    pos = { x = 4, y = 0 },
    config = { odds = 3, hands = -1 },
    key = "burnt",
    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_vis_burnt" then
            key = self.key .. "_alt"
        else
            key = self.key
        end
        --return { key = key, vars = { G.GAME.probabilities.normal, self.config.odds } }
        return { key = key, vars = { self.config.hands } }
    end,
    calculate = function (self, back, context)
        if context.pre_discard and not context.hook then -- We're discarding (not through the hook boss blind)
            local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
            local level_up_effect = { level_up = true, level_up_hand = text }
            local is_burnt_deck = self.get_current_deck_key() == "b_vis_burnt"
            if not is_burnt_deck then
                return G.GAME.current_round.discards_used <= 0 and level_up_effect or nil
            end
            -- At this point we know we're in the burnt deck, so we can roll the dice
            return pseudorandom(pseudoseed('vis_burnt_sleeve')) < G.GAME.probabilities.normal / self.config.odds and level_up_effect or nil
        end
    end
}

CardSleeves.Sleeve {
    key = "rolling",
    atlas = "TextureAtlasSleeves",
    pos = {x = 3, y = 0},
    --config = { vouchers = { 'v_reroll_surplus', "v_reroll_glut" } },
    discovered = true,
    unlocked = true,
    config = { vouchers = { 'v_reroll_surplus', "v_ortalab_window_shopping" } },
    loc_vars = function (self, info_queue, card)
        return { vars = { "Reroll Surplus", "Window Shopping" } }
    end,
    --[[loc_vars = function(self)
        local key = self.key
        if self.get_current_deck_key() == "b_vis_rolling" then
            key = key.."_alt"
        end
        return { key = key, vars = { "Reroll Surplus", "Reroll Glut" } }
    end,
    apply = function(self, sleeve)
        local is_rolling_deck = self.get_current_deck_key() == "b_vis_rolling"
        change_shop_size(is_rolling_deck and 1 or -1)
        if not is_rolling_deck then
            CardSleeves.Sleeve.apply(sleeve) -- super() call, Give the vouchers (shouldnt give them twice)
        end
    end]]
}