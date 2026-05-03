
SMODS.Atlas {
	key = "atlas_cod_decks",
	path = "decks.png",
	px = 71,
	py = 95
}

-- Royal
SMODS.Back{
    key = "royal",
    unlocked = true,
    atlas = 'atlas_cod_decks',
    pos = {x = 6, y = 1},
    config = {},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:is_face() then
                        cards[#cards+1] = playing_card
                    end
                end
                for _,playing_card in pairs(cards) do
                    local card_copied = copy_card(playing_card, nil, nil, G.playing_card)
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    card_copied.playing_card = G.playing_card
                    table.insert(G.playing_cards, card_copied)
                    G.deck:emplace(card_copied)
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end,
        }))
    end,
}

-- Triangle
SMODS.Back{
    key = "triangle",
    unlocked = true,
    atlas = 'atlas_cod_decks',
    pos = {x = 4, y = 0},
    config = {},

    apply = function(self)
        -- there is now a built in way to do this in SMODS
        G.GAME.starting_params.remove_random_suit = (G.GAME.starting_params.remove_random_suit or 0) + 1
    end,
}

-- Flow
SMODS.Back{
    key = "flow",
    unlocked = true,
    atlas = 'atlas_cod_decks',
    pos = {x = 9, y = 0},
    config = { rerolls = 1 },

    apply = function(self)
        SMODS.change_free_rerolls(self.config.rerolls)
    end,
}

-- Gravity
SMODS.Back{
    key = "gravity",
    unlocked = true,
    atlas = 'atlas_cod_decks',
    pos = {x = 5, y = 0},
    config = {},

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.add_card{ set = "Spectral", key = "c_black_hole", no_edition = true }
                return true
            end,
        }))
    end,
}

-- Rainbow
SMODS.Back{
    key = "rainbow",
    unlocked = false,
    atlas = 'atlas_cod_decks',
    pos = {x = 6, y = 0},
    config = {},

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.GAME.starting_params.erratic_suits_and_ranks then
                    for _=1,13 do
                        SMODS.add_card { set = "Base", enhancement = "m_wild", area = G.deck }
                    end
                else
                    local ranks = {}
                    for _, playing_card in ipairs(G.playing_cards) do
                        ranks[playing_card.base.value] = true
                    end
                    for rank,_ in pairs(ranks) do
                        SMODS.add_card { set = "Base", rank = rank, enhancement = "m_wild", area = G.deck }
                    end
                end
                G.GAME.starting_deck_size = #G.playing_cards
                return true
            end,
        }))
    end,
    locked_loc_vars = function(self, info_queue, back)
        local other_name = localize('k_unknown')
        if G.P_CENTERS['b_cod_triangle'].unlocked then
            other_name = localize { type = 'name_text', set = 'Back', key = 'b_cod_triangle' }
        end

        return { vars = { other_name } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_cod_triangle')>0 and true
    end
}

-- Inverted
local config = SMODS.current_mod.config
if config.cod_tags_enabled then
    SMODS.Back{
        key = "inverted",
        unlocked = true,
        atlas = 'atlas_cod_decks',
        pos = {x = 4, y = 1},
        config = { visual_negative = true },
        apply = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    add_tag({ key = 'tag_cod_clean' })
                    add_tag({ key = 'tag_negative' })
                    return true
                end
            }))
        end,
    }
end

-- VIP
SMODS.Back{
    key = "vip",
    unlocked = false,
    atlas = 'atlas_cod_decks',
    pos = {x = 0, y = 0},
    config = {},

    apply = function(self)
         G.E_MANAGER:add_event(Event({
            func = function()
                local valid_enhance_cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (next(SMODS.get_enhancements(playing_card)) and playing_card.seal and playing_card.edition) and not playing_card.getting_sliced then
                        valid_enhance_cards[#valid_enhance_cards + 1] = playing_card
                    end
                end
                local vip_card = pseudorandom_element(valid_enhance_cards, 'cod_vip')
                if vip_card then
            
                    local edition = SMODS.poll_edition { key = "cod_vip", guaranteed = true, no_negative = true, options = { 'e_polychrome', 'e_holo', 'e_foil' } }
                    vip_card:set_edition(edition, true)

                    local seal = SMODS.poll_seal({ guaranteed = true, key = 'cod_vip' })
                    vip_card:set_seal(seal, true)

                    local enhancement = SMODS.poll_enhancement({ guaranteed = true, type_key = 'cod_vip' })
                    vip_card:set_ability(enhancement, true)
                end
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 150 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 150
    end
}

-- Isometric
SMODS.Back{
    key = "isometric",
    unlocked = true,
    atlas = 'atlas_cod_decks',
    pos = {x = 3, y = 1},
    config = {},
    apply = function(self)
        G.GAME.modifiers.cod_isometric = true
        G.GAME.modifiers.money_per_discard = 1
    end,
    calculate = function(self, back, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.beat_boss then
            G.GAME.round_bonus.discards = (G.GAME.round_bonus.discards or 0) + G.GAME.current_round.discards_left
            G.GAME.round_bonus.next_hands = (G.GAME.round_bonus.next_hands or 0) + G.GAME.current_round.hands_left
        end
    end,
}

-- Average
SMODS.Back{
    key = "average",
    unlocked = false,
    atlas = 'atlas_cod_decks',
    pos = {x = 3, y = 0},
    config = {},

    apply = function(self)
        G.GAME.common_mod = 0
        G.GAME.rare_mod = 0
    end,
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 200 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 200
    end
}

-- Horror
SMODS.Back{
    key = "horror",
    unlocked = false,
    atlas = 'atlas_cod_decks',
    pos = {x = 7, y = 0},
    config = {},
    apply = function(self)
        G.GAME.cod_b_horror_life_used = false
    end,
    loc_vars = function(self, info_queue, back)
        return { vars = { (G.GAME.cod_b_horror_life_used and localize("horror_deck_used") or "") } }
    end,
    calculate = function(self, back, context)
        if context.end_of_round and context.game_over and context.main_eval then
            if not G.GAME.cod_b_horror_life_used then
                G.GAME.cod_b_horror_life_used = true

                for _, playing_card in ipairs(G.playing_cards) do
                    playing_card.children.back:set_sprite_pos({ x = 8, y = 0 })
                    playing_card:juice_up(0.3, 0.3)
                    playing_card.ability["cod_horror_bloody"] = true
                end

                return {
                    saved = 'horror_deck_saved',
                }
            end
        end
    end,
    locked_loc_vars = function(self, info_queue, back)
        return {
            vars = {
                localize { type = 'name_text', set = 'Stake', key = 'stake_cod_platinum' },
                colours = { G.C.EDITION }
            }
        }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_stake' and get_deck_win_stake() >= 9
    end
}

-- Ponzi
SMODS.Back{
    key = "ponzi",
    unlocked = false,
    atlas = 'atlas_cod_decks',
    pos = {x = 2, y = 0},
    config = {dollars = -24, credit_cards = 5},

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.credit_cards, localize { type = 'name_text', key = "j_credit_card", set = 'Joker'}, -self.config.dollars-4 } }
    end,

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                if G.jokers then

                    for i=1,self.config.credit_cards do
                        SMODS.add_card{ set = "Joker", key = "j_credit_card", no_edition = true }
                    end
                    
                    return true
                end
            end,
        }))
    end,
    
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 30 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'money' and G.GAME.dollars <= -30
    end
}