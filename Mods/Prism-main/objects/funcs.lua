function G.PRISM.get_suits(scoring_hand, bypass_debuff)
    local suits = {}
    for k, _ in pairs(SMODS.Suits) do
        suits[k] = 0
    end
    for _, card in ipairs(scoring_hand) do
        if card and not SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff) and count == 0 then
                    suits[suit] = count + 1
                    break
                end
            end
        end
    end
    for _, card in ipairs(scoring_hand) do
        if card and SMODS.has_any_suit(card) then
            for suit, count in pairs(suits) do
                if card:is_suit(suit, bypass_debuff) and count == 0 then
                    suits[suit] = count + 1
                    break
                end
            end
        end
    end
    return suits
end

function G.PRISM.get_unique_suits(scoring_hand, bypass_debuff)
    local suits = G.PRISM.get_suits(scoring_hand, bypass_debuff)
    local num_suits = 0
    for _, v in pairs(suits) do
        if v > 0 then num_suits = num_suits + 1 end
    end
    return num_suits
end

function G.PRISM.create_booster()
	G.GAME.current_round.used_packs = G.GAME.current_round.used_packs or {}
	if not G.GAME.current_round.used_packs[1] then
		G.GAME.current_round.used_packs[1] = get_pack('shop_pack').key
	end

	if G.GAME.current_round.used_packs[1] ~= 'USED' then 
		local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
		G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[G.GAME.current_round.used_packs[1]], {bypass_discovery_center = true, bypass_discovery_ui = true})
		create_shop_card_ui(card, 'Booster', G.shop_booster)
		card.ability.booster_pos = 1
		card:start_materialize()
		G.shop_booster:emplace(card)
	end
end

function G.PRISM.remove_joker(card)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.7,
        func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            card:start_dissolve()
            card = nil
            return true
    end}))
end
function G.PRISM.create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append,func)
    local buffer_type = area == G.jokers and 'joker_buffer' or 'consumeable_buffer'

    if #area.cards + G.GAME[buffer_type] < area.config.card_limit then
        G.GAME[buffer_type] = G.GAME[buffer_type] + 1
        G.E_MANAGER:add_event(Event {
            func = function()
            local card = create_card(_type,area,legendary,_rarity,skip_materialize,soulable,forced_key,key_append)
            card:add_to_deck()
            area:emplace(card)
            func(card)
            G.GAME[buffer_type] = 0
            return true
            end
        })
        return true
    end
end

G.PRISM.card_preview = function(cardArea, desc_nodes, config)
    if not config then config = {} end
    local height = config.h or 1.25
    local width = config.w or 1
    local card_limit = config.card_limit or #config.cards or 1
    local override = config.override or false
    local cards = config.cards or {}
    local padding = config.padding or 0.07
    local padding_plus = config.p_plus or 0
    local margin_left = config.ml or 0.2
    local margin_top = config.mt or 0
    local alignment = config.alignment or "cm"
    local scale = config.scale or 1
    local type = config.type or "title"
    local box_height = config.box_height or 0
    local highlight_limit = config.highlight_limit or 0
    if override or not cardArea then
        cardArea = CardArea(
            G.ROOM.T.x + margin_left * G.ROOM.T.w, G.ROOM.T.h + margin_top
            , width * G.CARD_W*0.7, height * G.CARD_H,
            {card_limit = card_limit, type = type, highlight_limit = highlight_limit, collection = true,temporary = true}
        )
        for i, card in ipairs(cards) do
            card.T.w = card.T.w * scale
            card.T.h = card.T.h * scale
            card.VT.h = card.T.h
            card.VT.h = card.T.h
            local area = cardArea
            if(card.config.center) then
                card:set_sprites(card.config.center)
            end
            area:emplace(card)
        end
    end
    local uiEX = {
        n = G.UIT.R,
        config = { align = alignment , padding = padding, no_fill = true, minh = box_height },
        nodes = {
            {n=G.UIT.R, config={padding = padding+padding_plus, r = 0.12, colour = lighten(G.C.JOKER_GREY, 0.5), emboss = 0.07}, nodes={
                {n = G.UIT.O, config = { object = cardArea }}
            }}
        }
    }
    if cardArea then
        if desc_nodes then
            desc_nodes[#desc_nodes+1] = {
                uiEX
            }
        end
    end
    return uiEX
end

function G.PRISM.destroy_cards(cards)
    G.E_MANAGER:add_event(Event({
        func = function()

--[[         if #cards > 0 and type(effects) == 'table' then
            effects.sound = 'tarot1'
            effects.instant = true
            SMODS.calculate_effect(effects, card)
        end ]]

        -- Destroy every card
        for _, v in ipairs(cards) do
            if SMODS.shatters(v) then
            v:shatter()
            else
            v:start_dissolve()
            end
        end

        G.E_MANAGER:add_event(Event {
            func = function()
            SMODS.calculate_context({
                remove_playing_cards = true,
                removed = cards
            })
            return true
            end
        })

        return true
        end
    }))

    for _, v in ipairs(cards) do
        if SMODS.shatters(v) then
            v.shattered = true
        else
            v.destroyed = true
        end
    end
end

function G.PRISM.is_numbered(card)
    return card.base and card.base.value and not SMODS.Ranks[card.base.value].face and card:get_id() ~= 14
end
function G.PRISM.is_odd(card)
    if not card.base then return false end
    return (G.PRISM.is_numbered(card) and card.base.nominal%2 == 1) or card:get_id() == 14
    or (next(SMODS.find_card('j_mxms_perspective')) and card:get_id() == 6)--compat with maximus' prespective
end

function G.PRISM.is_even(card)
    if not card.base then return false end
    return (G.PRISM.is_numbered(card) and card.base.nominal%2 == 0)
    or (next(SMODS.find_card('j_mxms_perspective')) and card:get_id() == 6)--compat with maximus' prespective
end