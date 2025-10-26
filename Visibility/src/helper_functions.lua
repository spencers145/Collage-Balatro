function get_all_unbanned_consumable_sets()
    local _types = {}
    for k, v in ipairs(SMODS.ConsumableType.ctype_buffer) do
        if not is_set_banned(v) then _types[#_types + 1] = v end
    end

    return _types
end

function is_set_banned(set)
    local _pool = G.P_CENTER_POOLS[set]

    for k, v in ipairs(_pool) do
        local add = nil
        if _type == 'Enhanced' then add = true
        elseif _type == 'Demo' and v.pos and v.config then add = true
        elseif _type == 'Tag' then
            if (not v.requires or (G.P_CENTERS[v.requires] and G.P_CENTERS[v.requires].discovered)) and 
            (not v.min_ante or v.min_ante <= G.GAME.round_resets.ante) then
                add = true
            end
        elseif not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman"))) and
            (v.unlocked ~= false or v.rarity == 4) then
            if v.set == 'Voucher' then
                if not G.GAME.used_vouchers[v.key] then 
                    local include = true
                    if v.requires then 
                        for kk, vv in pairs(v.requires) do
                            if not G.GAME.used_vouchers[vv] then 
                                include = false
                            end
                        end
                    end
                    if G.shop_vouchers and G.shop_vouchers.cards then
                        for kk, vv in ipairs(G.shop_vouchers.cards) do
                            if vv.config.center.key == v.key then include = false end
                        end
                    end
                    if include then
                        add = true
                    end
                end
            elseif v.set == 'Planet' then
                if (not v.config.softlock or G.GAME.hands[v.config.hand_type].played > 0) then
                    add = true
                end
            elseif v.enhancement_gate then
                add = nil
                for kk, vv in pairs(G.playing_cards) do
                    if vv.config.center.key == v.enhancement_gate then
                        add = true
                    end
                end
            else
                add = true
            end
            if v.name == 'Black Hole' or v.name == 'The Soul' then
                add = false
            end
        end

        if v.no_pool_flag and G.GAME.pool_flags[v.no_pool_flag] then add = nil end
        if v.yes_pool_flag and not G.GAME.pool_flags[v.yes_pool_flag] then add = nil end
        
        if add and not G.GAME.banned_keys[v.key] then 
            return false
        end
    end

    return true
end