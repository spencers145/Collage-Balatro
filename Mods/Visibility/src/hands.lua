--[[SMODS.PokerHand {
    key = 'industrialization',
    visible = false,
    chips = 5,
    mult = 25,
    l_chips = 5,
    l_mult = 10,
    example = {
		{ "S_A", true, enhancement = "m_vis_brick" },
		{ "S_A", true, enhancement = "m_vis_brick" },
		{ "S_A", true, enhancement = "m_vis_brick" },
		{ "S_A", true, enhancement = "m_vis_brick" },
		{ "S_A", true, enhancement = "m_vis_brick" },
    },
    evaluate = function (parts, hand)
        local _brick = {}
        for _, card in ipairs(hand) do
            if SMODS.has_enhancement(card, 'm_vis_brick') then
                _brick[#_brick+1] = card
            end
        end
        if #_brick >= 5 then return { _brick } end
    end
}]]

SMODS.PokerHand {
    key = 'heavyweight',
    visible = false,
    chips = 50,
    mult = 6,
    l_chips = 25,
    l_mult = 3,
    example = {
		{ "D_A", true, enhancement = "m_bonus" },
		{ "S_K", true, enhancement = "m_bonus" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
		{ "S_A", true, enhancement = "m_stone" },
    },
    evaluate = function (parts, hand)
        -- Full House of Enhancements featuring at least 2 suitless cards
        local _3 = get_X_same_enhanced(3, hand)
        local _2 = get_X_same_enhanced(2, hand)

        -- Check if both exist
        if next(_3) and next(_2) then

            local hw_hand = {}
            local hw_3 = _3[1]
            local hw_2 = _2[1]
            if not (SMODS.has_no_suit(hw_3[1]) or SMODS.has_no_suit(hw_2[1])) then
                return
            end
            for i=1, #hw_3 do
                hw_hand[#hw_hand+1] = hw_3[i]
            end
            for i=1, #hw_2 do
                hw_hand[#hw_hand+1] = hw_2[i]
            end
            return { hw_hand }
        end
    end
}

-- For Heavyweight
function get_X_same_enhanced(num, hand)
    local vals = { }
    for i=#hand, 1, -1 do
        local curr = {}
        table.insert(curr, hand[i])
        for j=1, #hand do
            local i_enh = hand[i].config.center.key
            local j_enh = hand[j].config.center.key
            if i_enh == j_enh and i ~= j and i_enh ~= "c_base" then
                table.insert(curr, hand[j])
            end
        end
        if #curr == num then
            vals[curr[1].config.center.key] = curr
        end
    end
    local ret = {}
    for k, v in pairs(vals) do
        table.insert(ret, vals[k])
    end
    return ret
end

--[[SMODS.Consumable {
    set = 'Planet',
    key = 'impactor',
    config = { hand_type = 'vis_industrialization', softlock = true },
    pos = { x = 0, y = 4 },
    atlas = 'TextureAtlasConsumables',
    discovered = false,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_meteor'), get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
}]]

SMODS.Consumable {
    set = 'Planet',
    key = 'arrokoth',
    config = { hand_type = 'vis_heavyweight', softlock = true },
    pos = { x = 1, y = 4 },
    atlas = 'TextureAtlasConsumables',
    discovered = false,
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_space_rock'), get_type_colour(self or card.config, card), nil, 1.2)
    end,
    generate_ui = 0,
}