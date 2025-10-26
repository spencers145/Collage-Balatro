--fourfingers
SMODS.Challenge {
    key = "fourfingers",
    rules = {
        custom = {
            { id = "znm_fourfingers"

            }
        }
    },
    jokers = {
        { id = 'j_four_fingers', eternal = true },
    },
    restrictions = {
        banned_other = {
            { id = 'bl_psychic', type = 'blind' },

        }
    }
}


--[[
SMODS.Challenge {
    key = "blueberry",
    rules = {
        custom = {
            { id = "znm_foreverberry"

            }
        }
    },
    jokers = {
        { id = 'j_znm_blueberries', eternal = true, edition = 'negative' },
    },

}]]

SMODS.Challenge {
    key = "tunasalad",
    rules = {
        custom = {
            { id = "znm_tunasalad" },
            -- { id = "znm_tunasaladchips"  }
        }
    },
    jokers = {
        { id = 'j_znm_tuna' },
        { id = 'j_znm_tuna' },
        { id = 'j_znm_tuna' },
    },

}

--[[
SMODS.Challenge {
    key = "shrimpfest",
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_interest' },
        },

    },

    jokers = {
        { id = 'j_znm_shrimps', eternal = true },
    },

}]]

--[[SMODS.Challenge {
    key = "multilevelmarketing",
    rules = {
        custom = {
            { id = 'no_shop_jokers' },
            { id = "znm_pyramid" },
        },

        modifiers = {
            { id = 'joker_slots', value = 6 },
        }
    },

    jokers = {
        { id = 'j_znm_pyramidscheme', eternal = true },
    },

    restrictions = {
        banned_cards = {
            { id = 'p_buffoon_normal_1', ids = {
                'p_buffoon_normal_1', 'p_buffoon_normal_2',
                'p_buffoon_normal_3', 'p_buffoon_normal_4',
                'p_buffoon_jumbo_1', 'p_buffoon_jumbo_2',
                'p_buffoon_mega_1', 'p_buffoon_mega_2' }
            },
        },
    }
}]]

--[[SMODS.Challenge {
    key = "geodeposit",
    rules = {

        custom = {

        },


        modifiers = {
            { id = 'joker_slots', value = 3 },
        },


    },

    consumeables = {
        { id = 'c_talisman' },
    },

    jokers = {
        { id = 'j_znm_thefountain', eternal = true },
    },

}]]



-- code that runs if this challenge is active
-- code that does NOT run EVER! KILL YOURSELF!!!
--[[
local smodsoldcalccontext = SMODS.calculate_context
function SMODS.calculate_context(context, return_table)
    local g = smodsoldcalccontext(context, return_table)
    local destroyed_cards = {}
    local temp_hand = {}
    if context.end_of_round and context.game_over == false and context.main_eval and (G.GAME.modifiers.znm_hungry) then
        for _, playing_card in ipairs(G.playing_cards) do temp_hand[#temp_hand + 1] = playing_card end
        table.sort(temp_hand,
            function(a, b)
                return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
            end
        )
        pseudoshuffle(temp_hand, pseudoseed('znm_hippochallenge'))
        for i = 1, #G.jokers.cards do destroyed_cards[#destroyed_cards + 1] = temp_hand[i] end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.destroy_cards(destroyed_cards)
                return true
            end
        }))
    end
    return g
end
]] --

--[[SMODS.Challenge {
    key = "housingcrisis",
    rules = {




    },

    jokers = {
        { id = 'j_znm_landlord', eternal = true },
    },

    restrictions = {
        banned_cards = {

        },
    }
}]]

SMODS.Challenge {
    key = "counting",
    rules = {
        custom = {
            { id = 'no_extra_hand_money' },
            { id = 'no_reward' },
        },
    },

    jokers = {
        { id = 'j_znm_combinationlock', eternal = true },
        { id = 'j_splash', edition = 'negative' },
    },



    restrictions = {
        banned_cards = {

        },
    }
}

SMODS.Challenge {
    key = "dizzydiving",
    rules = {
        custom = {

            { id = "znm_evilreef" },
        },

        modifiers = {
        }
    },

    jokers = {
        { id = 'j_znm_coralreef', eternal = true },
    },

    restrictions = {
        banned_cards = {

        },
    }
}

SMODS.Challenge {
    key = "uno",
    rules = {


        modifiers = {
            { id = 'hands', value = 1 },
        }
    },
    consumeables = {
        { id = 'c_lovers' },
        { id = 'c_lovers' },
    },
    jokers = {
        { id = 'j_znm_pickuptwo' },
    },

    deck = {
        cards = {
            { s = 'C', r = 'A' },
            { s = 'D', r = 'A' },
            { s = 'H', r = 'A' },
            { s = 'S', r = 'A' },
            { s = 'C', r = '9' },
            { s = 'D', r = '9' },
            { s = 'H', r = '9' },
            { s = 'S', r = '9' },
            { s = 'C', r = '8' },
            { s = 'D', r = '8' },
            { s = 'H', r = '8' },
            { s = 'S', r = '8' },
            { s = 'C', r = '7' },
            { s = 'D', r = '7' },
            { s = 'H', r = '7' },
            { s = 'S', r = '7' },
            { s = 'C', r = '6' },
            { s = 'D', r = '6' },
            { s = 'H', r = '6' },
            { s = 'S', r = '6' },
            { s = 'C', r = '5' },
            { s = 'D', r = '5' },
            { s = 'H', r = '5' },
            { s = 'S', r = '5' },
            { s = 'C', r = '4' },
            { s = 'D', r = '4' },
            { s = 'H', r = '4' },
            { s = 'S', r = '4' },
            { s = 'C', r = '3' },
            { s = 'D', r = '3' },
            { s = 'H', r = '3' },
            { s = 'S', r = '3' },
            { s = 'C', r = '2' },
            { s = 'D', r = '2' },
            { s = 'H', r = '2' },
            { s = 'S', r = '2' },
        }
    },
    restrictions = {

        banned_cards = {
            { id = 'j_burglar' },
            { id = 'v_grabber' },
            { id = 'v_nacho_tong' },
            { id = 'v_hieroglyph' },
            { id = 'v_petroglyph' },
            { id = 'j_znm_norm' },
        },

        banned_other = {
            { id = 'bl_head',   type = 'blind' },
            { id = 'bl_window', type = 'blind' },
            { id = 'bl_club',   type = 'blind' },
            { id = 'bl_goad',   type = 'blind' },
            { id = 'bl_water',  type = 'blind' },
        }
    }


}
