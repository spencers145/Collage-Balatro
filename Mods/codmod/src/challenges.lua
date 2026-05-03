-- Fishbucket
SMODS.Challenge {
    key = 'fishbucket',
    rules = {
        custom = {
            { id = 'fishbucket' },
        }
    },
    restrictions = {
        banned_cards = function()
            local banned = {}
            for k, v in pairs(G.P_CENTERS) do
                if v.set == 'Joker' and not (v.original_mod and v.original_mod.id == "CodMod") then
                    banned[#banned+1] = {id = v.key}
                end
            end
            return banned
        end
    },
}

-- Square Hands
SMODS.Challenge {
    key = 'square_hands',
    jokers = {
        { id = 'j_four_fingers', eternal = true },
    },
    rules = {
        custom = {
            { id = 'play_limit_4' },
        }
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand.config.highlighted_limit = 4
                return true
            end
        }))
    end,
}

-- Final Exam
SMODS.Challenge {
    key = 'final_exam',
    jokers = {
        { id = 'j_cod_homework', eternal = true },
        { id = 'j_cod_homework', eternal = true },
    },
}

-- Universal Paperclips
SMODS.Challenge {
    key = 'universal_paperclips',
    jokers = {
        { id = 'j_cod_paperclip', edition = "negative", eternal = true },
    }
}

-- Chaos Chaos
SMODS.Challenge {
    key = 'chaos_chaos',
    rules = {
        modifiers = {
            { id = 'hands',       value = 2 },
            { id = 'discards',    value = 2 },
            { id = 'hand_size',   value = 7 },
            { id = 'joker_slots', value = 4 },
        }
    },
    jokers = {
        { id = 'j_cod_random', edition = "negative" },
        { id = 'j_cod_random', edition = "negative" },
        { id = 'j_cod_random', edition = "negative" },
        { id = 'j_cod_random', edition = "negative" },
    }
}

-- Jailbreak
SMODS.Challenge {
    key = 'jailbreak',
    rules = {
        custom = {
            { id = 'all_imprisoned' },
        }
    },
}

-- Unaccountably Peckish
SMODS.Challenge {
    key = 'unaccountably_peckish',
    jokers = {
        { id = 'j_cod_hungry', edition = "negative", eternal = true },
        { id = 'j_cod_hungry', edition = "negative", eternal = true },
    },
    vouchers = {
        { id = 'v_magic_trick' },
    },
    restrictions = {
        banned_other = {
            { id = 'bl_cod_rot', type = 'blind' },
        }
    },
}

-- Sleepover
SMODS.Challenge {
    key = 'sleepover',
    rules = {
        custom = {
            { id = 'all_dormant' },
        }
    },
}

-- Top Secret
SMODS.Challenge {
    key = 'top_secret',
    rules = {
        custom = {
            { id = 'all_confidential' },
        }
    },
    restrictions = {
        banned_cards = {
            { id = 'j_madness' },
            { id = 'j_todo_list' },
            { id = 'j_mail' },
            { id = 'j_idol' },
            { id = 'j_castle' },
            { id = 'j_ancient' },
            { id = 'j_cod_paperclip' },
            { id = 'j_cod_book_of_the_dead' },
            { id = 'j_cod_homework' },
        },
    },
}