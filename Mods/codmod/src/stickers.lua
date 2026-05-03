SMODS.Atlas {
	key = "atlas_cod_stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}

-- hook to implement reasonable sticker incompat, stickers with the same sticker_slot are incompatible
local should_apply_ref = SMODS.Sticker.should_apply
function SMODS.Sticker:should_apply(card, center, area, bypass_roll)
    for i = 1, #G.GAME.tags do
        if (G.GAME.tags[i].key == "tag_cod_clean") then
            return false
        end
    end

    if not (self.outside_shop or area == G.shop_jokers or (area == G.pack_cards and not self.not_in_boosters)) then
        return false
    end
    
    for k, v in pairs(SMODS.Stickers) do
        if self.key ~= k and card.ability[k] and self.sticker_slot == v.sticker_slot then
            return false
        end
    end

    return should_apply_ref(self, card, center, area, bypass_roll)
end

SMODS.Sticker:take_ownership('eternal',
    {
	sticker_slot = 1,
    should_apply = SMODS.Sticker.should_apply,
    },
    true
)

SMODS.Sticker:take_ownership('perishable',
    {
	sticker_slot = 1,
    should_apply = SMODS.Sticker.should_apply,
    },
    true
)

SMODS.Sticker:take_ownership('rental',
    {
	sticker_slot = 2,
    should_apply = SMODS.Sticker.should_apply,
    },
    true
)

-- hook to let debuffed cards have sticker effects
local eval_card_ref = eval_card
function eval_card(card, context)
    context = context or {}
    if not card:can_calculate(context.ignore_debuff, context.remove_playing_cards or context.joker_type_destroyed) then
        local ret = {}
        for _,k in ipairs(SMODS.Sticker.obj_buffer) do
            local v = SMODS.Stickers[k]
            local sticker = card:calculate_sticker(context, k)
            if sticker then
                ret[v] = sticker
            end
        end
        return ret, {}
    end

    return eval_card_ref(card, context)
end

-- hook to run stickers on cards added to deck
local add_to_deck_ref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not from_debuff then
        for _,k in ipairs(SMODS.Sticker.obj_buffer) do
            if self.ability[k] then
                self:calculate_sticker({sticker_add_self = true}, k)
            end
        end
    end

    return add_to_deck_ref(self, from_debuff)
end

-- Dormant
local dormant_rounds = 2

SMODS.Sticker {
    key = "dormant",
    sticker_slot = 1,
    badge_colour = HEX '3c11b2',
    atlas = 'atlas_cod_stickers',
    pos = { x = 0, y = 0 },
    default_compat = true,
    rate = 0.3,
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then
            card.ability.dormant_tally = dormant_rounds
            G.E_MANAGER:add_event(Event({
                func = function()
                    if (card.area and card.area.config.jokers) then
                        SMODS.debuff_card(card, true, "cod_dormant")
                    end
                    return true
                end
            }))
        else
            SMODS.debuff_card(card, false, "cod_dormant")
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { dormant_rounds, card.ability.dormant_tally or dormant_rounds } }
    end,
    calculate = function(self, card, context)
        if context.sticker_add_self and card.ability.dormant_tally > 0 then
            SMODS.debuff_card(card, true, "cod_dormant")
        end
        if context.end_of_round and not context.repetition and not context.individual then
            if card.ability.dormant_tally > 0 then
                if card.ability.dormant_tally == 1 then
                    card.ability.dormant_tally = 0
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('dormant_awaken'),colour = G.C.FILTER, delay = 0.45})
                    SMODS.debuff_card(card, false, "cod_dormant")
                else
                    card.ability.dormant_tally = card.ability.dormant_tally - 1
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type='variable',key='a_remaining',vars={card.ability.dormant_tally}},colour = G.C.FILTER, delay = 0.45})
                end
            end
        end
    end
}

-- Envious
SMODS.Sticker {
    key = "envy",
    sticker_slot = 1,
    badge_colour = HEX '85e768',
    atlas = 'atlas_cod_stickers',
    pos = { x = 1, y = 0 },
    default_compat = true,
    rate = 0.3,
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if not card.ability[self.key] then
            SMODS.debuff_card(card, false, "cod_envy")
        end
    end,
    calculate = function(self, card, context)
        if context.sticker_add_self then
            local envy_count = 0
            if card.ability.cod_envy then
                envy_count = envy_count + 1
            end
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.cod_envy then
                    envy_count = envy_count + 1
                end
            end
            if (envy_count>1) then
                SMODS.debuff_card(card, true, "cod_envy")
            else
                SMODS.debuff_card(card, false, "cod_envy")
            end
        end
        if (context.joker_type_destroyed or context.selling_card) and context.card ~= card then
            local envy_count = 0
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.cod_envy then
                    envy_count = envy_count + 1
                end
            end
            if context.card.ability.cod_envy then
                envy_count = envy_count - 1
            end
            if (envy_count>1) then
                SMODS.debuff_card(card, true, "cod_envy")
            else
                SMODS.debuff_card(card, false, "cod_envy")
            end
        end
        if context.card_added then
            local envy_count = 0
            if context.card.ability.cod_envy then
                envy_count = envy_count + 1
            end
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.cod_envy then
                    envy_count = envy_count + 1
                end
            end
            if (envy_count>1) then
                SMODS.debuff_card(card, true, "cod_envy")
            else
                SMODS.debuff_card(card, false, "cod_envy")
            end
        end
    end
}

-- Claustrophobic
SMODS.Sticker {
    key = "claustrophobic",
    sticker_slot = 1,
    badge_colour = HEX 'aeaeae',
    atlas = 'atlas_cod_stickers',
    pos = { x = 2, y = 0 },
    default_compat = true,
    rate = 0.3,
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if not card.ability[self.key] then
            SMODS.debuff_card(card, false, "cod_claustrophobic")
        end
    end,
    calculate = function(self, card, context)
        if context.sticker_add_self then
            local empty_count = G.jokers.config.card_limit - #G.jokers.cards
            empty_count = empty_count - 1 + card.ability.card_limit
            if (empty_count>0) then
                SMODS.debuff_card(card, false, "cod_claustrophobic")
            else
                SMODS.debuff_card(card, true, "cod_claustrophobic")
            end
        end
        if (context.card_added or ((context.joker_type_destroyed or context.selling_card) and context.card ~= card)) and context.card.ability.set == "Joker" then
            local empty_count = G.jokers.config.card_limit - #G.jokers.cards
            if (context.joker_type_destroyed or context.selling_card) then
                empty_count = empty_count - context.card.ability.card_limit + 1
            end
            if context.card_added or context.buying_self then
                empty_count = empty_count - 1 + context.card.ability.card_limit
                if (context.card.ability.cod_claustrophobic and empty_count<=0) then
                    SMODS.debuff_card(context.card, true, "cod_claustrophobic")
                end
            end
            if (empty_count>0) then
                SMODS.debuff_card(card, false, "cod_claustrophobic")
            else
                SMODS.debuff_card(card, true, "cod_claustrophobic")
            end
        end
    end
}

-- hook to set sprite on card load
local card_load_ref = Card.load
function Card:load(cardTable, other_card)

    local ret = card_load_ref(self, cardTable, other_card)
    if self.ability["cod_confidential"] then
        self:set_sprites(G.P_CENTERS["j_cod_redacted"])
        if self.children then
            self.children.floating_sprite = nil
        end
    end
    -- horror deck bloody sprite
    if self.ability["cod_horror_bloody"] then
        self.children.back:set_sprite_pos({ x = 8, y = 0 })
    end
    return ret
end

-- Confidential
SMODS.Sticker {
    key = "confidential",
    sticker_slot = 1,
    badge_colour = HEX '939ecc',
    atlas = 'atlas_cod_stickers',
    pos = { x = 3, y = 0 },
    default_compat = true,
    compat_exceptions = {"j_madness", "j_todo_list", "j_mail", "j_idol", "j_castle", "j_ancient"},
    rate = 0.2,
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        if (not card or not card.config or not card.config.center or not card.config.center.key) then -- avoid crash from all in jest's sticker joker
            return true
        end
        return G.P_CENTERS[card.config.center.key].discovered and SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then
            card:set_sprites(G.P_CENTERS["j_cod_redacted"])
            if card.children then
                card.children.floating_sprite = nil
            end
        elseif not card.ability[self.key] then
            card:set_sprites(G.P_CENTERS[card.config.center_key])
        end
    end,
}

-- Expensive
SMODS.Sticker {
    key = "expensive",
    sticker_slot = 2,
    badge_colour = HEX 'e79368',
    atlas = 'atlas_cod_stickers',
    pos = { x = 0, y = 1 },
    default_compat = true,
    not_in_boosters = true,
    rate = 0.15,
    needs_enable_flag = true,
    should_apply = function(self, card, center, area, bypass_roll)
        return (G.GAME.round and G.GAME.round > 2) and SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        card:set_cost()
    end,
}

-- Imprisoned
SMODS.Sticker {
    key = "imprisoned",
    sticker_slot = 1,
    badge_colour = HEX '5d5577',
    atlas = 'atlas_cod_stickers',
    pos = { x = 1, y = 1 },
    default_compat = true,
    rate = 0.3,
    needs_enable_flag = true,
    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then
            card.ability.imprisoned_freed = false
            G.E_MANAGER:add_event(Event({
                func = function()
                    if (card.area and card.area.config.jokers) then
                        SMODS.debuff_card(card, true, "cod_imprisoned")
                    end
                    return true
                end
            }))
        else
            SMODS.debuff_card(card, false, "cod_imprisoned")
        end
    end,
    calculate = function(self, card, context)
        if context.sticker_add_self and not card.ability.imprisoned_freed then
            SMODS.debuff_card(card, true, "cod_imprisoned")
        end
        if context.skip_blind and not card.ability.imprisoned_freed then
            card.ability.imprisoned_freed = true
            SMODS.debuff_card(card, false, "cod_imprisoned")
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('imprisoned_freed'),colour = G.C.FILTER, delay = 0.45})
        end
    end
}