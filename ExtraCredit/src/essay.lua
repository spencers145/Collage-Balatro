local mod = SMODS.current_mod
SMODS.Atlas({key = "modicon", path = "modicon.png", px = 31, py = 32, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "ECjokers", path = "ECjokers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()
SMODS.Atlas({key = "ECother", path = "ECother.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS"}):register()

ECconfig = SMODS.current_mod.config

SMODS.current_mod.extra_tabs = function() --Credits tab
    local scale = 0.5
    return {
        label = "Interns",
        tab_definition_function = function()
        return {
            n = G.UIT.ROOT,
            config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
            },
            nodes = {
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Project Lead: CampfireCollective",
                    shadow = false,
                    scale = scale,
                    colour = G.C.PURPLE
                    }
                }
                }
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Artists: kittyknight, UselessReptile8, Wingcap, HonuKane,",
                    shadow = false,
                    scale = scale,
                    colour = G.C.MONEY
                    }
                },
                }
            },
            {
                n = G.UIT.R,
                config = {
                    padding = 0,
                    align = "cm"
                },
                nodes = {
                    {
                    n = G.UIT.T,
                    config = {
                        text = "bishopcorrigan, tuzzo, R3venantR3mnant, Neato, Sacto, Gote",
                        shadow = false,
                        scale = scale,
                        colour = G.C.MONEY
                    }
                    },
                }
                },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Programmers: CampfireCollective, Stupid, MathIsFun_",
                    shadow = false,
                    scale = scale,
                    colour = G.C.GREEN
                    }
                }
                },
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Special thanks: Drspectred, Djynasty, InertSteak, Akai, localthunk",
                    shadow = false,
                    scale = scale,
                    colour = G.C.BLUE
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Concepting: CampfireCollective, kittyknight, Audrizzle, Neon, Expelsword, tuzzo, bishopcorrigan, Wingcap, AlasBabylon",
                    shadow = false,
                    scale = scale*0.6,
                    colour = G.C.BLACK
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "HonuKane, conk reet, Sacto, BioSector, Splatter_Proto, SenrabMJam, Stupid, AviolosAvali, Xilande, Sbubby, Seadubbs, Swordodo, Qcom",
                    shadow = false,
                    scale = scale*0.6,
                    colour = G.C.BLACK
                    }
                }
                } 
            }
            }
        }
        end
    }
end

SMODS.current_mod.config_tab = function() --Config tab
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = {
        create_toggle({
            label = "Page 1 Jokers (restart required)",
            ref_table = ECconfig,
            ref_value = "wave1",
        }),
        create_toggle({
            label = "Page 2 Jokers (restart required)",
            ref_table = ECconfig,
            ref_value = "wave2",
        }),
        create_toggle({
            label = "Page 3 Jokers (restart required)",
            ref_table = ECconfig,
            ref_value = "wave3",
        }),
      },
    }
end

-- Talisman Compatibility

to_big = to_big or function(x)
  return x
end
to_number = to_number or function(x)
  return x
end

-------------------------


local function contains(table_, value)
    for _, v in pairs(table_) do
        if v == value then
            return true
        end
    end

    return false
end
local ed = ease_dollars
function ease_dollars(mod, x)
    ed(mod, x)
    for i = 1, #G.jokers.cards do
	eval_card(G.jokers.cards[i], { EC_ease_dollars = to_big(mod)})
    end
end

-- Page 1 Jokers
if ECconfig.wave1 then
SMODS.Joker{ --Double Rainbow
    name = "Double Rainbow",
    key = "doublerainbow",
    config = {
        extra = 1
    },
    loc_txt = {
        ['name'] = 'Double Rainbow',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} all {C:attention}Lucky Cards{}',
            [2] = 'scored or held in hand'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    enhancement_gate = 'm_lucky',
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_lucky 
        return
    end,

    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and SMODS.get_enhancements(context.other_card)["m_lucky"] == true then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        
        elseif context.repetition and context.cardarea == G.hand and SMODS.get_enhancements(context.other_card)["m_lucky"] == true then
            if (next(context.card_effects[1]) or #context.card_effects > 1) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end

}

SMODS.Joker{ --Pocket Aces
    name = "Pocket Aces",
    key = "pocketaces",
    config = {
        extra = {
            money = 0,
            m_gain = 2
        }
    },
    loc_txt = {
        name = 'Pocket Aces',
        text = {
            {'{C:money}$#1#{} at end of round'},
            {'Played {C:attention}Aces{} increase payout',
            'by {C:money}$#2#{} when scored',
            '{C:inactive}(Resets each{} {C:attention}Ante{}{C:inactive})'}
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.m_gain}}
    end,

    calc_dollar_bonus = function(self, card)
        local thunk = card.ability.extra.money
        if G.GAME.blind.boss then
            card.ability.extra.money = 0
        end
        return thunk
    end,

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 14 and not context.blueprint then
            card.ability.extra.money = card.ability.extra.money + card.ability.extra.m_gain
        end
    end


}


SMODS.Joker{ --Yellow Card
    name = "Yellow Card",
    key = "yellowcard",
    config = {
        extra = {
            money = 5
        }
    },
    loc_txt = {
        ['name'] = 'Yellow Card',
        ['text'] = {
            [1] = 'Gain {C:money}$#1#{} when any',
            [2] = '{C:attention}Booster Pack{} is skipped'
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,

    calculate = function(self, card, context)
        if context.skipping_booster and not context.open_booster then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "$"..tostring(card.ability.extra.money), colour = G.C.MONEY})
            ease_dollars(card.ability.extra.money)
        end
    end
}

SMODS.Joker{ --Turtle
    name = "Turtle",
    key = "turtle",
    config = {
        extra = {
            Xmult_mod = 0.25,
            Xmult = 1
            }
        },
    loc_txt = {
        ['name'] = 'Turtle',
        ['text'] = {
            [1] = "This Joker gains {X:mult,C:white} X#1# {} Mult at the",
            [2] = "end of each non-Boss {C:attention}Blind{}",
            [3] = "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and card.ability.extra.Xmult > 1 then
            return{
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        elseif context.end_of_round and not context.repetition and not context.individual and not G.GAME.blind.boss and not context.blueprint then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                card = card,
                colour = G.C.RED
            }
        end
    end
}
--[[
SMODS.Joker{ --Ten Gallon
    name = "Ten Gallon",
    key = "tengallon",
    config = {
        extra = {
            Xmult = 0.4,
            dollars = 25
            }
        },
    loc_txt = {
        ['name'] = 'Ten Gallon',
        ['text'] = {
            [1] = "{X:mult,C:white}X#1#{} Mult for every",
            [2] = "{C:money}$#2#{} you have",
            [3] = "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.dollars, to_big(1) + to_big(card.ability.extra.Xmult)*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or to_big(0)))/to_big(card.ability.extra.dollars))}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local xmult = (to_big(card.ability.extra.Xmult)*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or to_big(0)))/to_big(card.ability.extra.dollars)))
            if xmult > to_big(0) then
                return {
                    message = localize{type='variable',key='a_xmult',vars={to_big(1) + xmult}},
                    Xmult_mod = to_big(1) + xmult
                }
            end
        end
    end
}]]
end

-- Page 2 Jokers
if ECconfig.wave2 then

SMODS.Joker{ --Espresso
    name = "Espresseo",
    key = "espresso",
    config = {
        extra = {
            money = 25,
            m_loss = 5
        }
    },
    loc_txt = {
        name = 'Espresso',
        text = {
            {'Gain {C:money}$#1#{} and destroy this card',
            'when any {C:attention}Blind{} is skipped'},
            {'Reduces by {C:money}$#2#{} after each round'}
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money, card.ability.extra.m_loss}}
    end,

    calculate = function(self, card, context)
        if context.skip_blind and not context.blueprint then
            G.E_MANAGER:add_event(Event({
                func = function() 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_drank_ex'),
                            colour = G.C.MONEY,
                        card = card
                    }) 
                    return true
                end}))
            ease_dollars(card.ability.extra.money)
            card:juice_up(0.5, 0.5)
            delay(0.5)
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
                                G.jokers:remove_card(self)
                                card:remove()
                                card = nil
                            return true; end})) 
                    return true
                end
            }))

        elseif context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.money = card.ability.extra.money - card.ability.extra.m_loss
            if card.ability.extra.money <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                }))
                return {
                    message = "Too cold!",
                    colour = G.C.FILTER
                }
            else 
                return {
                    message = "Cooled!",
                    colour = G.C.FILTER
                }
            end

        end
    end
}

--[[SMODS.Joker{ --Werewolf
    name = "Werewolf",
    key = "werewolf",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Werewolf',
        ['text'] = {
            [1] = 'Played cards that are',
            [2] = '{C:attention}enhanced{} become {C:attention}Wild Cards'
        }
    },
    pos = {
        x = 1,
        y = 2
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local thunk = 0
            for k, v in ipairs(context.full_hand) do
                if contains(SMODS.get_enhancements(v), true) and v.config.center.key ~= "m_wild" then
                    thunk = thunk + 1
                    v:set_ability(G.P_CENTERS.m_wild, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            v:juice_up()
                            return true
                        end
                    })) 
                end
            end
            if thunk > 0 then
                return{
                    message = 'Awooo!',
                    colour = G.C.PURPLE
                }
            end
        end
    end
}]]

SMODS.Joker{ --Prideful Joker
    name = "Prideful Joker",
    key = "pridefuljoker",
    config = {
        extra = 10
    },
    loc_txt = {
        ['name'] = 'Prideful Joker',
        ['text'] = {
            [1] = 'Played {C:attention}Wild Cards{} give',
            [2] = '{C:mult}+#1#{} Mult when scored'
        }
    },
    pos = {
        x = 3,
        y = 2
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    enhancement_gate = 'm_wild',
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_wild
        return {vars = {card.ability.extra}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and SMODS.get_enhancements(context.other_card)["m_wild"] == true then
            return{
                mult = card.ability.extra,
                card = card
            }
        end
    end
}

SMODS.Joker{ --Tuxedo
    name = "Tuxedo",
    key = "tuxedo",
    config = {
        extra = {
            reps = 1,
        }
    },
    loc_txt = {
        ['name'] = 'Tuxedo',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} all cards',
            [2] = 'with {V:1}#1#{} suit',
            [3] = "{s:0.8}suit changes at end of round"
        }
    },
    pos = {
        x = 4,
        y = 2
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        local current_suit = G.GAME.current_round.tuxedo_card and G.GAME.current_round.tuxedo_card.suit or "Spades"
        return {vars = {localize(current_suit, 'suits_singular'), colours = {G.C.SUITS[current_suit]}}}
    end,

    calculate = function(self, card, context)


        if context.cardarea == G.play and context.repetition and context.other_card:is_suit(G.GAME.current_round.tuxedo_card.suit) then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.reps,
                card = card
            }

        elseif context.repetition and context.cardarea == G.hand and context.other_card:is_suit(G.GAME.current_round.tuxedo_card.suit) then
            if (next(context.card_effects[1]) or #context.card_effects > 1) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.reps,
                    card = card
                }
            end
        end
    end
}

SMODS.Joker{ --Farmer
    name = "Farmer",
    key = "farmer",
    config = {
        extra = {
            dollars = 2
        }
    },
    loc_txt = {
        ['name'] = 'Farmer',
        ['text'] = {
            [1] = 'Cards with {V:1}#2#{} suit',
            [2] = 'held in hand give {C:money}$#1#',
            [3] = 'at end of round',
            [4] = "{s:0.8}suit changes at end of round"
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    cost = 6,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        local current_suit = G.GAME.current_round.farmer_card and G.GAME.current_round.farmer_card.suit or "Spades"
        return {vars = {card.ability.extra.dollars, localize(current_suit, 'suits_singular'), colours = {G.C.SUITS[current_suit]}}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.end_of_round and context.individual and not context.repetition and context.other_card:is_suit(G.GAME.current_round.farmer_card.suit) then
            delay(0.15)
            return {
                dollars = 2,
                card = context.other_card
            }
        end        
    end
}

SMODS.Joker{ --Ship of Theseus
    name = "Ship of Theseus",
    key = "shipoftheseus",
    config = {
        extra = {
            Xmult = 1,
            Xmult_mod = 0.2,
            tick = false
        }
    },
    loc_txt = {
        ['name'] = 'Ship of Theseus',
        ['text'] = {
            [1] = 'Whenever a {C:attention}Playing Card{} is {C:attention}destroyed',
            [2] = 'add a {C:attention}copy{} of it to your {C:attention}deck',
            [3] = 'and this joker gains {X:mult,C:white}X#2#{} Mult',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
        }
    },
    pos = {
        x = 7,
        y = 2
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_mod}}
    end,

    calculate = function(self, card, context)
        if context.cards_destroyed then
            --print("got here instead")
            card.ability.extra.tick = false
            for k, val in ipairs(context.glass_shattered) do
                if not context.blueprint then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                    card.ability.extra.tick = true
                end
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(val, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    G.deck:emplace(_card)
                    table.insert(G.playing_cards, _card)
                    playing_card_joker_effects({true})
                
                G.E_MANAGER:add_event(Event({
                func = function() 
                    _card:start_materialize()
                    
                    return true
                end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_copied_ex'), colour = G.C.FILTER})
            end
                

            
            if not context.blueprint and card.ability.extra.tick then
                delay(0.3)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}, colour = G.C.FILTER})
            end
        elseif context.remove_playing_cards then
            card.ability.extra.tick = false
            for k, val in ipairs(context.removed) do
                if not context.blueprint then
                    card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                    card.ability.extra.tick = true
                end
                --print("got here")
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local _card = copy_card(val, nil, nil, G.playing_card)
                _card.states.visible = false
                
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
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_copied_ex'), colour = G.C.FILTER})
            end
            if not context.blueprint and card.ability.extra.tick then
                delay(0.3)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}, colour = G.C.FILTER})
            end

        elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.Xmult > 1 then
            return{
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}
end

-- Page 3 Jokers
if ECconfig.wave3 then
SMODS.Joker{ --Plushie
    name = "Plushie",
    key = "plushie",
    config = {
        extra = {
            chips = 16
        }
    },
    loc_txt = {
        ['name'] = 'Plushie',
        ['text'] = {
            [1] = "{C:chips}+#1#{} Chips for",
            [2] = "each {C:attention}Joker{} card",
            [3] = "{C:inactive}(Currently {C:blue}+#2#{C:inactive} Chips)",
        }
    },
    pos = {
        x = 6,
        y = 3
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, (G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.chips}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return{
                message = localize{type='variable',key='a_chips',vars={(G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.chips}},
                chip_mod = (G.jokers and G.jokers.cards and #G.jokers.cards or 0)*card.ability.extra.chips
            }
        end
    end
}

SMODS.Joker{ --Pyromancer
    name = "Pyromancer",
    key = "pyromancer",
    config = {
        extra = {
            mult = 20
        }
    },
    loc_txt = {
        ['name'] = 'Pyromancer',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult if",
            [2] = "remaining {C:attention}Hands{} are less",
            [3] = "than or equal to {C:attention}Discards",
        }
    },
    pos = {
        x = 1,
        y = 3
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and G.GAME.current_round.hands_left <= G.GAME.current_round.discards_left then
            return{
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker{ --Bobby
    name = "Bobby",
    key = "bobby",
    config = {
        extra = {
            hands = 2,
            discards = 4
        }
    },
    loc_txt = {
        ['name'] = 'Bobby',
        ['text'] = {
            [1] = "When {C:attention}Blind{} is selected,",
            [2] = "lose {C:attention}#1#{} Hands and gain",
            [3] = "{C:red}+#1#{} Discards for each Hand lost"
            
        }
    },
    pos = {
        x = 0,
        y = 3
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hands, card.ability.extra.discards}}
    end,

    calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or card).getting_sliced then

            G.E_MANAGER:add_event(Event({func = function()

                if G.GAME.current_round.hands_left < 2 then

                elseif G.GAME.current_round.hands_left == 2 then
                    
                    ease_hands_played(-(card.ability.extra.hands / 2), true)
                    ease_discard((card.ability.extra.discards / 2), true, true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discards / 2).." "..localize('k_hud_discards'), colour = G.C.RED})
    
                elseif G.GAME.current_round.hands_left > 2 then

                    ease_hands_played(-card.ability.extra.hands, true)
                    ease_discard(card.ability.extra.discards, true, true)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.discards).." "..localize('k_hud_discards'), colour = G.C.RED})
                end
            return true end })) 

        end
    end
    
}

SMODS.Joker{ --Blackjack
    name = "Blackjack",
    key = "blackjack",
    config = {
        extra = {
            mult = 21
        }
    },
    loc_txt = {
        ['name'] = 'Blackjack',
        ['text'] = {
            [1] = "{C:mult}+#1#{} Mult if played hand",
            [2] = "contains a scoring {C:attention}face ",
            [3] = "{C:attention}card{} and nonscoring {C:attention}Ace{}",
        }
    },
    pos = {
        x = 1,
        y = 4
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local _ace, _face = false, false
            for i = 1, #context.scoring_hand do
                if not SMODS.has_no_rank(context.scoring_hand[i]) then
                    if context.scoring_hand[i]:is_face() then
                        _face = true break
                    end
                end
            end

            for i = 1, #context.full_hand do
                if context.full_hand[i]:get_id() == 14 and not SMODS.has_no_rank(context.full_hand[i]) then
                    if not contains(context.scoring_hand, context.full_hand[i]) then
                        _ace = true
                    end
                end
            end

            if _ace and _face then
                return{
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end
}



SMODS.Joker{ --JotY
    name = "Joker of the Year",
    key = "joty",
    config = {
        extra = {
            reps = 1,
        }
    },
    loc_txt = {
        ['name'] = 'Joker of the Year',
        ['text'] = {
            [1] = 'If played hand has',
            [2] = '{C:attention}5{} scoring cards,',
            [3] = "{C:attention}retrigger{} played cards"
        }
    },
    pos = {
        x = 5,
        y = 3
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and #context.scoring_hand == 5 then
            return {
                message = localize('k_again_ex'),
                repetitions = card.ability.extra.reps,
                card = card
            }
        end
    end
}

SMODS.Joker{ --Average Alice
    name = "Average Alice",
    key = "averagealice",
    config = {
        extra = {
            Xmult = 2.5
        }
    },
    loc_txt = {
        ['name'] = 'Average Alice',
        ['text'] = {
            [1] = "{C:white,X:mult}X#1#{} Mult if played",
            [2] = "hand contains a scoring",
            [3] = "{C:attention}Odd{} and {C:attention}Even{} card",
        }
    },
    pos = {
        x = 2,
        y = 4
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            local _odd, _even = false, false
            for i = 1, #context.scoring_hand do
                if not SMODS.has_no_rank(context.scoring_hand[i]) then
                    if contains({14,3,5,7,9}, context.scoring_hand[i]:get_id()) then
                        _odd = true
                    end
                    if contains({2,4,6,8,10}, context.scoring_hand[i]:get_id()) then
                        _even = true
                    end
                end
            end

            if _odd and _even then
                return{
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
    end
}

SMODS.Joker{ --Coupon Sheet
    name = "Coupon Sheet",
    key = "couponsheet",
    config = {
        extra = {
            }
        },
    loc_txt = {
        ['name'] = 'Coupon Sheet',
        ['text'] = {
            [1] = "Create a {C:attention}Coupon Tag",
            [2] = "and a {C:attention}Voucher Tag",
            [3] = "after {C:attention}Boss Blind{} is defeated"
        }
    },
    pos = {
        x = 8,
        y = 3
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'tag_coupon', set = 'Tag'}
        info_queue[#info_queue+1] = {key = 'tag_voucher', set = 'Tag'}
        return{vars = {}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss and not context.blueprint then
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Coupon Tag!", colour = G.C.FILTER})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_coupon'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
            delay(0.3)
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+1 Voucher Tag!", colour = G.C.FILTER})
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_voucher'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}

SMODS.Joker{ --Hoarder
    name = "Hoarder",
    key = "hoarder",
    config = {
        extra = 1
    },
    loc_txt = {
        ['name'] = 'Hoarder',
        ['text'] = {
            [1] = "This Joker gains {C:money}$#1#{} of sell value",
            [2] = "whenever {C:money}money{} is earned"
        }
    },
    pos = {
        x = 9,
        y = 3
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra}}
    end,

    calculate = function(self, card, context)
        if context.EC_ease_dollars and not context.blueprint then
            if context.EC_ease_dollars > to_big(0) then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra
                card:set_cost()
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_val_up'),
                        colour = G.C.MONEY,
                    card = card
                }) 
            end
            
        end
    end
}

SMODS.Joker{ --Joka Lisa
    name = "Joka Lisa",
    key = "jokalisa",
    config = {
        extra = {
            Xmult = 1,
            Xmult_mod = 0.1
        }
    },
    loc_txt = {
        ['name'] = 'Joka Lisa',
        ['text'] = {
            [1] = 'Gains {X:mult,C:white}X#2#{} Mult for',
            [2] = 'each {C:attention}unique enhancement',
            [3] = 'in scoring hand',
            [4] = '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive})'
        }
    },
    pos = {
        x = 3,
        y = 3
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_mod}}
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local enhanced = {}
            for i=1, #context.scoring_hand do
                for k, v in pairs(SMODS.get_enhancements(context.scoring_hand[i])) do
                    if v then
                        if not contains(enhanced, k) then
                            enhanced[#enhanced+1] = k
                        end
                    end
                end
            end
            if #enhanced > 0 then
                card.ability.extra.Xmult = card.ability.extra.Xmult + (card.ability.extra.Xmult_mod*#enhanced)
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    card = card,
                    colour = G.C.RED
                }
            end

        elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.Xmult > 1 then
            return{
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end
}

SMODS.Joker{ --Traffic Light
    name = "Traffic Light",
    key = "trafficlight",
    config = {
        extra = {
            Xmult = 2.5,
            Xmult_mod = 1
        }
    },
    loc_txt = {
        ['name'] = 'Traffic Light',
        ['text'] = {
            [1] = 'Gives {X:mult,C:white}X#1#{} Mult',
            [2] = 'Decreases by {X:mult,C:white}X#2#{}',
            [3] = 'each hand played',
            [4] = 'Resets after {X:mult,C:white}X0.5{}'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_mod}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return{
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                Xmult_mod = card.ability.extra.Xmult
            }

        elseif context.after and not context.blueprint then

            card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_mod

            if card.ability.extra.Xmult < 0.5 then
                card.ability.extra.Xmult = 2.5
                return {
                    message = "Go!",
                    colour = G.C.GREEN
                }
            elseif card.ability.extra.Xmult == 1.5 then
                return {
                    message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.Xmult_mod}},
                    colour = G.C.FILTER
                }
            elseif card.ability.extra.Xmult == 0.5 then
                return {
                    message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.Xmult_mod}},
                    colour = G.C.RED
                }
            end
        end
    end
}

--[[SMODS.Joker{ --Bad Apple
    name = "Bad Apple",
    key = "badapple",
    config = {
        extra = {
            chips = 125,
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'Bad Apple',
        ['text'] = {
            [1] = "{C:chips}+#1#{} Chips",
            [2] = "{C:green}#3# in #2#{} chance this card ",
            [3] = "or an {C:attention}adjacent{} card is",
            [4] = "destroyed at end of round"
        }
    },
    pos = {
        x = 0,
        y = 4
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',

    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips, card.ability.extra.odds, G.GAME.probabilities.normal}}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main then
            return{
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips
            }

        elseif context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
            if pseudorandom('apple') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local destructable_jokers = {}
                local index = 0
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        index = i break
                    end
                end
                for i = 1, #G.jokers.cards do
                    if i == index - 1 or i == index or i == index + 1 then
                        if not G.jokers.cards[i].ability.eternal and not G.jokers.cards[i].getting_sliced then destructable_jokers[#destructable_jokers+1] = G.jokers.cards[i] end
                    end
                end
                local joker_to_destroy = #destructable_jokers > 0 and pseudorandom_element(destructable_jokers, pseudoseed('apple')) or nil

                if joker_to_destroy then 
                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                        message = localize('k_extinct_ex'),
                            colour = G.C.FILTER,
                        card = joker_to_destroy
                    }) 
                    joker_to_destroy.getting_sliced = true
                    G.E_MANAGER:add_event(Event({func = function()
                        card:juice_up(0.8, 0.8)
                        joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    return true end }))
                end
            
            else
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = localize('k_safe_ex'),
                        colour = G.C.FILTER,
                    card = card
                }) 
            end
        end
    end
}]]

SMODS.Joker{ --Alloy
    name = "Alloy",
    key = "alloy",
    loc_txt = {
        ['name'] = 'Alloy',
        ['text'] = {
            [1] = "{C:attention}Gold Cards{} are also ",
            [2] = "considered {C:attention}Steel Cards{}",
            [3] = "{C:attention}Steel Cards{} are also ",
            [4] = "considered {C:attention}Gold Cards{}"
        }
    },
    pos = { 
        x = 4,
        y = 4
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ECjokers',
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_gold
        info_queue[#info_queue+1] = G.P_CENTERS.m_steel
        return
    end,
    calculate = function(self, card, context)
        if context.check_enhancement then
            if context.other_card.config.center.key == "m_gold" then
                return {m_steel = true}
            end
            if context.other_card.config.center.key == "m_steel" then
                return {m_gold = true}
            end
        end
    end
}
end

SMODS.Back{ --Bazaar Deck
    name = "Bazaar Deck",
	key = "bazaardeck",
  loc_txt = {
    name = 'Bazaar Deck',
    text = {
        "Start run with",
        "{C:money,T:v_clearance_sale}#1#{},",
        "{C:attention,T:v_magic_trick}#2#{},",
        "and {C:dark_edition,T:v_hone}#3#",
    },
    unlock = {
        "Successfully activate an",
        "{C:attention}Ouroboros Seal"
    }
  },
	order = 16,
  unlocked = false,
	config = {vouchers = {"v_clearance_sale","v_magic_trick","v_hone"}},
  loc_vars = function(self, info_queue, center)
    return {vars = {localize{type = 'name_text', key = 'v_clearance_sale', set = 'Voucher'}, localize{type = 'name_text', key = 'v_magic_trick', set = 'Voucher'}, localize{type = 'name_text', key = 'v_hone', set = 'Voucher'}}}
  end,
	pos = { x = 0, y = 0 },
	atlas = "ECother"
}

SMODS.Back{ --Archeology Deck
    name = "Archeology Deck",
	key = "archeologydeck",  
    loc_txt = {      
        name = 'Archeology Deck',      
        text = {
            "Start in {C:attention}Ante 0",
            "{s:0.2} {}",
            "{C:attention}-1{} hand size",
            "{s:0.2} {}",
            "{C:attention,T:v_hieroglyph}Hieroglyph{} is",
            "offered every Ante",
            "until taken"
        },
        unlock = {"Win {C:attention}3{} runs with",
            "{C:attention,E:1}Collage{} installed"}
    },
        order = 17,
    unlocked = false,
    check_for_unlock = function (self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 3
    end,
    config = {},
    pos = { x = 1, y = 0 },
    atlas = "ECother",
    apply = function(self, back)
        G.GAME.starting_params.archeology_deck = true
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1
        G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - 1
        G.E_MANAGER:add_event(Event({
            func = function ()
                ease_ante(-1)
                return true
            end
        }))
    end
}
--[[
SMODS.Back{ --Echo Deck
    name = "Echo Deck",
	key = "echodeck",  
  loc_txt = {      
    name = 'Echo Deck',      
    text = {
      "{C:attention}Retrigger{} all playing cards",
      "{C:red}X1.2{} base Blind size",
      "Increases by {C:red}X0.2{} each Ante"
    } 
  }, 
    order = 18,
  unlocked = true,
  discovered = true,
	config = {},
  loc_vars = function(self, info_queue, center)
    return {vars = {}}
  end,
	pos = { x = 2, y = 0 },
	atlas = "ECother",
  apply = function(self, back)
    G.GAME.starting_params.ante_scaling = 1.2
  end,

  calculate = function(self, back, context)
    if context.cardarea == G.play and context.repetition then
        return {
            message = localize('k_again_ex'),
            repetitions = 1,
            card = card
        }

    elseif context.repetition and context.cardarea == G.hand then
        if (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
    
    if context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss then
        G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling + 0.2
    end
  end
}
]]

-- Resets

local function reset_tuxedo_card()
	local tuxedo_suits = {}
    G.GAME.current_round.tuxedo_card = G.GAME.current_round.tuxedo_card or {}
	for k, suit in pairs(SMODS.Suits) do
		if
			k ~= G.GAME.current_round.tuxedo_card.suit
			and (type(suit.in_pool) ~= "function" or suit:in_pool({ rank = "" }))
		then
			tuxedo_suits[#tuxedo_suits + 1] = k
		end
	end
	local tuxedo_card = pseudorandom_element(tuxedo_suits, pseudoseed("tux" .. G.GAME.round_resets.ante))
	G.GAME.current_round.tuxedo_card.suit = tuxedo_card
end

local function reset_farmer_card()
	local farmer_suits = {}
    G.GAME.current_round.farmer_card = G.GAME.current_round.farmer_card or {}
	for k, suit in pairs(SMODS.Suits) do
		if
			k ~= G.GAME.current_round.farmer_card.suit
			and (type(suit.in_pool) ~= "function" or suit:in_pool({ rank = "" }))
		then
			farmer_suits[#farmer_suits + 1] = k
		end
	end
	local farmer_card = pseudorandom_element(farmer_suits, pseudoseed("farm" .. G.GAME.round_resets.ante))
	G.GAME.current_round.farmer_card.suit = farmer_card
end

local function reset_fish_rank()
	local valid_fish_ranks = {}
    G.GAME.current_round.fish_rank = G.GAME.current_round.fish_rank or {}
	for k, rank in pairs(SMODS.Ranks) do
		if
			k ~= G.GAME.current_round.fish_rank.rank
			and (type(rank.in_pool) ~= "function" or rank:in_pool({ suit = "" }))
		then
			valid_fish_ranks[#valid_fish_ranks + 1] = k
		end
	end
	local fish_pick = pseudorandom_element(valid_fish_ranks, pseudoseed("fish" .. G.GAME.round_resets.ante))
	G.GAME.current_round.fish_rank.rank = fish_pick
end

mod.reset_game_globals = function(run_start)
	reset_tuxedo_card()
	reset_farmer_card()
	reset_fish_rank()
end