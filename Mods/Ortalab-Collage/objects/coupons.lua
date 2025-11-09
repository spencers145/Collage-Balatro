SMODS.Atlas({
    key = 'coupons',
    path = 'coupons.png',
    px = '71',
    py = '95'
})

SMODS.Voucher({
	key = "catalog",
	atlas = "coupons",
	pos = {x = 0, y = 0},
	cost = 10,
	unlocked = false,
	discovered = false,
	available = true,
	config = {extra = {booster_gain = 1}},
    artist_credits = {'flare'},
    check_for_unlock = function(self, args)
        return G.PROFILES[G.SETTINGS.profile].career_stats.c_collage_wins >= 1
    end,
	redeem = function(self, card)
        --SMODS.change_booster_limit(card.ability.extra.booster_gain)
        for key, value in pairs(G.shop_booster.cards) do
            value:set_debuff(false)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.booster_gain}}
    end,
})

SMODS.Voucher({
	key = "ad_campaign",
	atlas = "coupons",
	pos = {x = 1, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_catalog'},
	config = {extra = {voucher_gain = 1}},
    artist_credits = {'flare'},
	redeem = function(self, card)
        unlock_card(G.P_CENTERS.b_ortalab_membership)
        --SMODS.change_voucher_limit(card.ability.extra.voucher_gain)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.voucher_gain}}
    end,
})

SMODS.Voucher({
	key = "home_delivery",
	atlas = "coupons",
	pos = {x = 2, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    artist_credits = {'flare'},
})

local ortalab_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    Ortalab.queue_size = #G.E_MANAGER.queues.base
    ortalab_skip_blind(e)
    G.E_MANAGER:add_event(Event({
    trigger = 'after',
    func = function()
        if G.GAME.used_vouchers['v_ortalab_home_delivery'] then
            if G.blind_select then 
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
            end
            G.GAME.current_round.used_packs = {}
            G.GAME.current_round.jokers_purchased = 0
            G.GAME.current_round.reroll_cost_increase = 0
            G.GAME.round_resets.temp_reroll_cost = nil
            G.GAME.current_round.free_rerolls = G.GAME.round_resets.free_rerolls
            calculate_reroll_cost(true)

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                blocking = false,
                func = function()
                    if G.STATE == G.STATES.SMODS_BOOSTER_OPENED or #G.E_MANAGER.queues.base > Ortalab.queue_size then return false end
                    G.STATE_COMPLETE = false
                    G.STATE = G.STATES.SHOP
                    return true
                end
            }))
        end
        return true
    end}))
end

function Ortalab.home_delivery()
    G.STATE_COMPLETE = false
    G.STATE = G.STATES.SHOP
end

SMODS.Voucher({
	key = "hoarding",
	atlas = "coupons",
	pos = {x = 3, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_home_delivery'},
    artist_credits = {'flare'},
})

SMODS.Voucher({
	key = "window_shopping",
	atlas = "coupons",
	config = {extra = {free_rerolls = 1}},
	pos = {x = 4, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    artist_credits = {'flare'},
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            SMODS.change_free_rerolls(card.ability.extra.free_rerolls)
            return true 
        end }))
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.free_rerolls}}
    end,
})

SMODS.Voucher({
	key = "infinite_scroll",
	atlas = "coupons",
	pos = {x = 5, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
	requires = {'v_ortalab_window_shopping'},
	config = {extra = {free_rerolls = 1}},
    artist_credits = {'flare'},
	redeem = function(self, card)
        G.E_MANAGER:add_event(Event({func = function()
            SMODS.change_free_rerolls(card.ability.extra.free_rerolls)
            return true 
        end }))
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.free_rerolls + 1}}
    end,
})

--[[SMODS.Voucher({
	key = "horoscope",
	atlas = "coupons",
	pos = {x = 2, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {increase = 1}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.increase}}
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            local zodiacs = {}
            for k, _ in pairs(G.ZODIACS) do
                if k ~= 'zodiac_ortalab_ophiuchus' then
                    zodiacs[#zodiacs+1] = k
                end
            end
            local choice = pseudorandom_element(zodiacs, pseudoseed('ortalab_horoscope'))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.shop and not G.shop.alignment.offset.py then
                        G.shop.alignment.offset.py = G.shop.alignment.offset.y
                        G.shop.alignment.offset.y = G.ROOM.T.y + 39
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.zodiacs and G.zodiacs[choice] then
                        G.zodiacs[choice].config.extra.temp_level = G.zodiacs[choice].config.extra.temp_level + (card.ability.extra.increase * G.GAME.ortalab.zodiacs.temp_level_mod)
                        zodiac_text(zodiac_upgrade_text(choice), choice)
                        G.zodiacs[choice]:juice_up(1, 1)
                        delay(0.7)
                    else
                        local _zodiac = Zodiac(choice)
                        _zodiac.config.extra.temp_level = card.ability.extra.increase
                        add_zodiac(_zodiac, nil, nil, 1)
                    end
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            if G.shop and G.shop.alignment.offset.py then
                                G.shop.alignment.offset.y = G.shop.alignment.offset.py
                                G.shop.alignment.offset.py = nil
                            end                  
                            return true
                        end
                    }))                 
                    return true
                end
            }))
        end
    end
})

SMODS.Voucher({
	key = "natal_sign",
	atlas = "coupons",
	pos = {x = 3, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {xmult = 1.2, per = 4}},
    requires = {'v_ortalab_horoscope'},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.natal_sign_rate = card.ability.extra.xmult
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.per}}
    end,
})]]

SMODS.Voucher({
	key = "abacus",
	atlas = "coupons",
	pos = {x = 2, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
	config = {extra = {ante_gain = 1, dollars = 15, hand_size = 1}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.win_ante = G.GAME.win_ante + card.ability.extra.ante_gain
        G.hand:change_size(card.ability.extra.hand_size)
        ease_dollars(card.ability.extra.dollars)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.ante_gain, card.ability.extra.dollars, card.ability.extra.hand_size}}
    end,
})

SMODS.Voucher({
	key = "calculator",
	atlas = "coupons",
	pos = {x = 3, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_abacus'},
	config = {extra = {ante_gain = 1, joker_slots = 1}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.win_ante = G.GAME.win_ante + card.ability.extra.ante_gain
        modify_joker_slot_count(card.ability.extra.joker_slots)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.ante_gain, card.ability.extra.joker_slots}}
    end,
})

--[[SMODS.Voucher({
	key = "cantor",
	atlas = "coupons",
	pos = {x = 6, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {bonus_cards = 1}},
    artist_credits = {'crimson'},
	redeem = function(self, voucher)
        G.GAME.ortalab.vouchers.cantor = voucher.ability.extra.bonus_cards
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_cards}}
    end,
})

SMODS.Voucher({
	key = "tabla",
	atlas = "coupons",
	pos = {x = 7, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    requires = {'v_ortalab_cantor'},
    config = {extra = {bonus_cards = 1}},
    artist_credits = {'crimson'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.tabla = card.ability.extra.bonus_cards
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_cards}}
    end,
})

SMODS.Voucher({
	key = "leap_year",
	atlas = "coupons",
	pos = {x = 0, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {gain = 2, denom = 2}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.leap_year = {card.ability.extra.gain, card.ability.extra.denom}
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, SMODS.get_probability_vars(card, 1, card.ability.extra.denom, 'ortalab_leap_year')}}
    end,
})

SMODS.Voucher({
	key = "chronomancy",
	atlas = "coupons",
	pos = {x = 1, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    requires = {'v_ortalab_leap_year'},
    config = {extra = {level_decrease_mod = 2}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.zodiacs.reduction = G.GAME.ortalab.zodiacs.reduction / card.ability.extra.level_decrease_mod
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.level_decrease_mod}}
    end,
})

SMODS.Voucher({
	key = "pulse_wave",
	atlas = "coupons",
	pos = {x = 0, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {edition_reps = 1}},
    artist_credits = {'joey'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.edition_reps}}
    end,
})

SMODS.Voucher({
	key = "energy_surge",
	atlas = "coupons",
	pos = {x = 1, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_pulse_wave'},
    config = {extra = {edition_reps = 1}},
    artist_credits = {'joey'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.edition_reps}}
    end,
})]]

--[[SMODS.Voucher({
	key = "one_mans_trash",
	atlas = "coupons",
	pos = {x = 6, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {hands = 2, discards = -2}},
    artist_credits = {'joey'},
	redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hands, card.ability.extra.discards}}
    end,
})

SMODS.Voucher({
	key = "anothers_treasure",
	atlas = "coupons",
	pos = {x = 7, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_one_mans_trash'},
    config = {extra = {extra_dollars = 1}},
    artist_credits = {'joey'},
	redeem = function(self, card)
        unlock_card(G.P_CENTERS.b_ortalab_cyan)
        G.GAME.modifiers.money_per_hand = (G.GAME.modifiers.money_per_hand or 1) + card.ability.extra.extra_dollars
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.extra_dollars}}
    end,
})]]

SMODS.Voucher({
	key = "wasteful_inv",
	atlas = "coupons",
	pos = {x = 0, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {hands = -1, discards = 2}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.hands, card.ability.extra.discards}}
    end,
})

SMODS.Voucher({
	key = "recyclo_inv",
	atlas = "coupons",
	pos = {x = 1, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_wasteful_inv'},
    config = {extra = {discard_size = 3}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        unlock_card(G.P_CENTERS.b_ortalab_orange)
        SMODS.change_discard_limit(card.ability.extra.discard_size)
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.discard_size}}
    end,
})

--[[SMODS.Voucher({
	key = "seed_inv",
	atlas = "coupons",
	pos = {x = 2, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {money = 3, wyrms_dragons = {}}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.blind_rewards = G.GAME.ortalab.blind_rewards + card.ability.extra.money
        update_blind_amounts()
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    set_ability = function(self, card, initial, delay)
        card.ability.extra.left_dragon = card.ability.extra.left_dragon or get_new_boss()
        card.ability.extra.right_dragon = card.ability.extra.right_dragon or Ortalab.get_new_showdown_key()
        if not next(Ortalab.wyrms_dragons or {}) then self:create_sprites(card) end
    end,
    create_sprites = function(self, card)
        Ortalab.wyrms_dragons = Ortalab.wyrms_dragons or {}
        Ortalab.wyrms_dragons.left_dragon = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS['ortalab_left_dragon'], {x=0, y=0})
        Ortalab.wyrms_dragons.left_dragon.atlas = {
            px = 71, py = 95, name = 'ortalab_left_dragon',
            image_data = G.ASSET_ATLAS['ortalab_left_dragon'].image_data:clone(),
            image = love.graphics.newImage(G.ASSET_ATLAS['ortalab_left_dragon'].image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
        }
        Ortalab.wyrms_dragons.left_dragon.atlas.image_data = G.ASSET_ATLAS['ortalab_left_dragon'].image_data:clone()
        Ortalab.wyrms_dragons.left_dragon.atlas.image_data:mapPixel(function(x,y,r,g,b,a)
            return Ortalab.recolour_dragon(x,y,r,g,b,a, G.P_BLINDS[card.ability.extra.left_dragon].boss_colour)
        end)
        Ortalab.wyrms_dragons.left_dragon.atlas.image = love.graphics.newImage(Ortalab.wyrms_dragons.left_dragon.atlas.image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})


        Ortalab.wyrms_dragons.right_dragon = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS['ortalab_right_dragon'], {x=0, y=0})
        Ortalab.wyrms_dragons.right_dragon.atlas = {
            px = 71, py = 95, name = 'ortalab_right_dragon',
            image_data = G.ASSET_ATLAS['ortalab_right_dragon'].image_data:clone(),
            image = love.graphics.newImage(G.ASSET_ATLAS['ortalab_right_dragon'].image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
        }
        Ortalab.wyrms_dragons.right_dragon.atlas.image_data = G.ASSET_ATLAS['ortalab_right_dragon'].image_data:clone()
        Ortalab.wyrms_dragons.right_dragon.atlas.image_data:mapPixel(function(x,y,r,g,b,a)
            return Ortalab.recolour_dragon(x,y,r,g,b,a, G.P_BLINDS[card.ability.extra.right_dragon].boss_colour)
        end)
        Ortalab.wyrms_dragons.right_dragon.atlas.image = love.graphics.newImage(Ortalab.wyrms_dragons.right_dragon.atlas.image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})


        local mod_id = G.P_BLINDS[card.ability.extra.left_dragon].mod and G.P_BLINDS[card.ability.extra.left_dragon].mod.id or 'vanilla'
        local atlas = 'ortalab_dragon_heads'
        local counter = 0
        local x = 0
        local y = 0
        if Ortalab.wyrms_atlas[mod_id] then
            atlas = Ortalab.wyrms_atlas[mod_id]
            counter = G.P_BLINDS[card.ability.extra.left_dragon].pos.y - (mod_id == 'ortalab' and 0 or 2)
            x = (counter)%5
            y = math.floor(counter/5)
        end
        Ortalab.wyrms_dragons.left_head = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS[atlas], {x=x, y=y})

        mod_id = G.P_BLINDS[card.ability.extra.right_dragon].mod and G.P_BLINDS[card.ability.extra.right_dragon].mod.id or 'vanilla'
        atlas = 'ortalab_dragon_heads'
        counter = 0
        x = 0
        y = 0
        if Ortalab.wyrms_atlas[mod_id] then
            atlas = Ortalab.wyrms_atlas[mod_id]
            counter = G.P_BLINDS[card.ability.extra.right_dragon].pos.y - (mod_id == 'ortalab' and 0 or 2)
            x = (counter)%5
            y = math.floor(counter/5)
        end
        Ortalab.wyrms_dragons.right_head = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS[Ortalab.wyrms_atlas[mod_id] or 'ortalab_blind_dragons_vanilla'], {x=x, y=y})
    end
})

function Ortalab.get_new_showdown_key(current)
    local eligible_bosses = {}
    for k, v in pairs(G.P_BLINDS) do
        if v.boss and v.boss.showdown then 
            local res = true
            if v.in_pool and type(v.in_pool) == 'function' then
                res = SMODS.add_to_pool(v)
            end
            eligible_bosses[k] = res
        end
    end
    if G.GAME.modifiers.ortalab_only then
        for k, v in pairs(eligible_bosses) do
            if eligible_bosses[k] and not G.P_BLINDS[k].mod or G.P_BLINDS[k].mod.id ~= 'ortalab' then
                eligible_bosses[k] = nil
            end
        end
    end
    
    local _, boss = pseudorandom_element(eligible_bosses, pseudoseed('boss'))
    
    return boss
end

function Ortalab.recolour_dragon(x,y,r,g,b,a,new_colour)
    local hsl = HSL({r,g,b,a})
    -- 0.41, 0.33, 0.35
    -- 0.55, 0.45, 0.39
    local new_hsl = HSL(new_colour)
    hsl[1] = new_hsl[1]
    hsl[2] = new_hsl[2] * (hsl[2]/0.33)
    hsl[3] = new_hsl[3] * (hsl[3]/0.45)
    local RGB = HSL_RGB(hsl)
    return RGB[1], RGB[2], RGB[3], RGB[4]
end

SMODS.Atlas({
    key = 'blind_dragons_vanilla',
    path = 'coupon_heads_vanilla.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'blind_dragons_ortalab',
    path = 'coupon_heads_ortalab.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'blind_dragons_vanilla_2',
    path = 'coupon_heads_2_vanilla.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'blind_dragons_ortalab_2',
    path = 'coupon_heads_2_ortalab.png',
    px = 71,
    py = 95
})

Ortalab.wyrms_atlas = {
    vanilla = 'ortalab_blind_dragons_vanilla',
    ortalab = 'ortalab_blind_dragons_ortalab'
}

SMODS.Atlas({
    key = 'left_dragon',
    path = 'left_dragon.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'right_dragon',
    path = 'right_dragon.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'middle_dragon',
    path = 'middle_dragon.png',
    px = 71,
    py = 95
})

SMODS.DrawStep {
    key = 'wyrms_gift',
    order = 35,
    func = function(self)
        local t = nil

        if self.config.center_key == 'v_ortalab_seed_inv' then t = 'wyrms_dragons'
        elseif self.config.center_key == 'v_ortalab_tree_inv' then t = 'wyrms_dragons_2' end
        
        if t and self.config.center.discovered then
            if not next(Ortalab[t] or {}) then G.P_CENTERS[self.config.center_key]:create_sprites(self) end
            for _, dragon in pairs(Ortalab[t]) do 
                dragon.role.draw_major = self
                dragon:draw_shader('dissolve', nil, nil, nil, self.children.center)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.Voucher({
	key = "tree_inv",
	atlas = "coupons",
	pos = {x = 3, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_seed_inv'},
    config = {extra = {money = 5, wyrms_dragons = {}}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.blind_rewards = G.GAME.ortalab.blind_rewards + card.ability.extra.money
        update_blind_amounts()
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    set_ability = function(self, card, initial, delay)
        card.ability.extra.dragon = card.ability.extra.dragon or Ortalab.get_new_showdown_key()
        if not next(Ortalab.wyrms_dragons_2 or {}) then self:create_sprites(card) end
    end,
    create_sprites = function(self, card)
        Ortalab.wyrms_dragons_2 = Ortalab.wyrms_dragons_2 or {}
        Ortalab.wyrms_dragons_2.dragon = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS['ortalab_middle_dragon'], {x=0, y=0})
        Ortalab.wyrms_dragons_2.dragon.atlas = {
            px = 71, py = 95, name = 'ortalab_middle_dragon',
            image_data = G.ASSET_ATLAS['ortalab_middle_dragon'].image_data:clone(),
            image = love.graphics.newImage(G.ASSET_ATLAS['ortalab_middle_dragon'].image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})
        }
        Ortalab.wyrms_dragons_2.dragon.atlas.image_data = G.ASSET_ATLAS['ortalab_middle_dragon'].image_data:clone()
        Ortalab.wyrms_dragons_2.dragon.atlas.image_data:mapPixel(function(x,y,r,g,b,a)
            return Ortalab.recolour_dragon(x,y,r,g,b,a, G.P_BLINDS[card.ability.extra.dragon].boss_colour)
        end)
        Ortalab.wyrms_dragons_2.dragon.atlas.image = love.graphics.newImage(Ortalab.wyrms_dragons_2.dragon.atlas.image_data, {mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling})

        local mod_id = G.P_BLINDS[card.ability.extra.dragon].mod and G.P_BLINDS[card.ability.extra.dragon].mod.id or 'vanilla'
        local atlas = 'ortalab_dragon_heads'
        local counter = 0
        local x = 0
        local y = 0
        if Ortalab.wyrms_atlas[mod_id] then
            atlas = Ortalab.wyrms_atlas[mod_id] .. '_2'
            counter = G.P_BLINDS[card.ability.extra.dragon].pos.y - (mod_id == 'ortalab' and 0 or 2)
            x = (counter)%5
            y = math.floor(counter/5)
            Ortalab.wyrms_dragons_2.left_head = Sprite(0,0,G.CARD_W,G.CARD_H, G.ASSET_ATLAS[atlas], {x=x, y=y})
        end
    end
})]]
--[[
SMODS.Voucher({
	key = "shared_winnings",
	atlas = "coupons",
	pos = {x = 6, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.reroll_on_skip = true
    end,
})

SMODS.Voucher({
	key = "rigged_game",
	atlas = "coupons",
	pos = {x = 7, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_shared_winnings'},
    artist_credits = {'crimson'},
	redeem = function(self, card)
        G.GAME.ortalab.alt_boss = get_new_boss()
    end,
})

SMODS.Voucher({
	key = "hex",
	atlas = "coupons",
	pos = {x = 4, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    artist_credits = {'chvsau'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.tags_in_shop = 1.5
    end,
})

SMODS.Voucher({
	key = "glamour",
	atlas = "coupons",
	pos = {x = 5, y = 3},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_hex'},
    artist_credits = {'crimson'},
	redeem = function(self, card)
        G.GAME.ortalab_utility_rate = 1.0
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['c_ortalab_edition_+']
    end,
})]]

--[[SMODS.Voucher({
	key = "fates_coin",
	atlas = "coupons",
	pos = {x = 4, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    artist_credits = {'chvsau'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.mythos_shop_slot = true
        G:update_shop()
    end,
})

SMODS.Voucher({
	key = "arcane_archive",
	atlas = "coupons",
	pos = {x = 5, y = 2},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_fates_coin'},
    artist_credits = {'chvsau'},
	redeem = function(self, card)
        G.GAME.ortalab_mythos_rate = 2.0
    end,
})]]

--[[SMODS.Voucher({
	key = "blank_inv",
	atlas = "coupons",
	pos = {x = 6, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    config = {extra = {bonus_slots = 1}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + card.ability.extra.bonus_slots
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_slots}}
    end,
})

SMODS.Voucher({
	key = "anti_inv",
	atlas = "coupons",
	pos = {x = 7, y = 0},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_blank_inv'},
    config = {extra = {active = true}},
    artist_credits = {'gappie'},
    redeem = function(self, card)
        if G.shop_booster and G.shop_booster.cards and next(G.shop_booster.cards) then
            for _, booster in pairs(G.shop_booster.cards) do
                create_shop_card_ui(booster)
            end
        end
    end,
	calculate = function(self, card, context)
        if context.starting_shop then
            card.ability.extra.active = true
        end
    end,
})]]

local CardOpen_ref = Card.open
function Card.open(self)
    local free_pack = SMODS.find_card('v_ortalab_anti_inv')
    if next(free_pack) and free_pack[1].ability.extra.active and self.cost > 0 then
        free_pack[1].ability.extra.active = false
        self.cost = 0
        for _, booster in pairs(G.shop_booster.cards) do
            create_shop_card_ui(booster)
        end
    end
	return CardOpen_ref(self)
end

--[[SMODS.Voucher({
	key = "chisel",
	atlas = "coupons",
	pos = {x = 4, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = true,
    config = {extra = {change = 5}},
    artist_credits = {'gappie'},
	calculate = function(self, card, context)
        if context.setting_blind then
            for i=1, card.ability.extra.change do
                local _card = pseudorandom_element(G.playing_cards, pseudoseed('ortalab_chisel'))
                while _card.ability.chiselled do
                    _card = pseudorandom_element(G.playing_cards, pseudoseed('ortalab_chisel_reroll'))
                end
                _card.ability.chiselled = true
                _card.ability.extra = _card.ability.extra or {}
                _card.ability.index_state = 'MID'
            end
        end
        if context.check_enhancement and context.other_card.ability.chiselled then
            return {
                m_wild = true,
                m_ortalab_index = true
            }
        end
        if context.end_of_round and context.main_eval then
            for _, _card in pairs(G.playing_cards) do
                if _card.ability.chiselled then _card.ability.chiselled = nil end
                if not SMODS.has_enhancement(_card, 'm_ortalab_index') and _card.ability.extra then
                    _card.ability.index_state = nil
                end
            end
        end
        if context.hand_drawn then
            for _, _card in pairs(context.hand_drawn) do
                if _card.ability.chiselled then
                    SMODS.calculate_effect({message = localize('ortalab_chisel')}, _card)
                end
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue+1] = G.P_CENTERS.m_wild
            info_queue[#info_queue+1] = G.P_CENTERS.m_ortalab_index
        end
        return {vars = {card.ability.extra.change}}
    end,
})

SMODS.Voucher({
	key = "statue",
	atlas = "coupons",
	pos = {x = 5, y = 1},
	cost = 10,
	unlocked = true,
	discovered = false,
	available = false,
    requires = {'v_ortalab_chisel'},
    config = {extra = {bonus_slots = 1}},
    artist_credits = {'gappie'},
	redeem = function(self, card)
        G.GAME.ortalab.vouchers.booster_pack_bonus = card.ability.extra.bonus_slots
    end,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.bonus_slots}}
    end,
})

SMODS.Atlas({
    key = 'chisel',
    path = 'chisel.png',
    px = 71,
    py = 95
})

SMODS.DrawStep {
    key = 'chisel',
    order = 35,
    func = function(self)
        if self.ability.chiselled then
            if not Ortalab.chisel_sprite then Ortalab.chisel_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['ortalab_chisel'], {x=0, y=0}) end
            Ortalab.chisel_sprite.role.draw_major = self
            Ortalab.chisel_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
            Ortalab.chisel_sprite:draw_shader('ortalab_mythos', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}]]


local skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    if G.GAME.ortalab.vouchers.reroll_on_skip then
        G.from_boss_tag = true
        G.FUNCS.reroll_boss()
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 1.4,
        func = function()
            skip_blind(e)
            return true
        end
    }))
end

G.FUNCS.swap_blind = function(e)
    local type = e.config.type
    if G.GAME.round_resets.blind_states[type] == 'Defeated' or G.GAME.round_resets.blind_states[type] == 'Skipped' then
        return
    end
    local old_boss = G.GAME.round_resets.blind_choices[type]
    if type == 'Boss' then
        G.GAME.round_resets.blind_choices[type] = G.GAME.ortalab.alt_boss
        G.GAME.ortalab.alt_boss = old_boss
    elseif type == 'Big' then
        G.GAME.round_resets.blind_choices[type] = G.GAME.ortalab.alt_big
        G.GAME.ortalab.alt_big = old_boss
    else
        G.GAME.round_resets.blind_choices[type] = G.GAME.ortalab.alt_small
        G.GAME.ortalab.alt_small = old_boss
    end
    if G.SETTINGS.paused then
        G.FUNCS.change_tab(G.OVERLAY_MENU.definition.nodes[1].nodes[1].nodes[1].nodes[1].nodes[1].nodes[2].nodes[2].nodes[1].nodes[1].config.button_UIE)
        save_run()
    end
    if G.blind_select_opts then
        -- disappear
        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            play_sound('other1')
            G.blind_select_opts[string.lower(type)]:set_role({xy_bond = 'Weak'})
            G.blind_select_opts[string.lower(type)].alignment.offset.y = 20
            return true
            end
        }))
        -- change
        G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.6,
        func = (function()
            local par = G.blind_select_opts[string.lower(type)].parent
            G.blind_select_opts[string.lower(type)]:remove()
            G.blind_select_opts[string.lower(type)] = UIBox{
            T = {par.T.x, 0, 0, 0, },
            definition =
                {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                UIBox_dyn_container({create_UIBox_blind_choice(type, G.SETTINGS.paused)},false,get_blind_main_colour(type), mix_colours(G.C.BLACK, get_blind_main_colour(type), 0.8))
                }},
            config = {align="bmi",
                        offset = {x=0,y=G.ROOM.T.y + 9},
                        major = par,
                        xy_bond = 'Weak'
                    }
            }
            par.config.object = G.blind_select_opts[string.lower(type)]
            par.config.object:recalculate()
            G.blind_select_opts[string.lower(type)].parent = par
            G.blind_select_opts[string.lower(type)].alignment.offset.y = 0
            
            G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                G.CONTROLLER.locks.boss_reroll = nil
                return true
            end
            }))

            save_run()
            return true
        end)}))
    end
end


local BackApply_to_run_ref = Back.apply_to_run
function Back.apply_to_run(self)
	BackApply_to_run_ref(self)
    G.GAME.modifiers.booster_count = 2
    G.GAME.modifiers.voucher_count = 1
end

function Ortalab.spawn_booster()
    local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2,
    G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[get_pack('shop_pack').key], {bypass_discovery_center = true, bypass_discovery_ui = true})
    create_shop_card_ui(card, 'Booster', G.shop_booster)
    card.ability.booster_pos = #G.shop_booster.cards + 1
    card:start_materialize()
    G.shop_booster:emplace(card)
end

local skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    if G.GAME.used_vouchers['v_ortalab_hoarding'] then
        local _tag = e.UIBox:get_UIE_by_ID('tag_container')
        if _tag then
            local tag = Tag(_tag.config.ref_table.key, false, _tag.config.ref_table.ability.blind_type)
            tag:set_ability()
            add_tag(tag)
        end
    end
    skip_blind(e)
end

SMODS.Atlas({
    key = 'temp',
    path = 'temp.png',
    px = 71,
    py = 95
})

--[[SMODS.ConsumableType({
    key = "Ortalab_Utility",
    primary_colour = HEX("666666"),
    secondary_colour = HEX("666666"),
    loc_txt = {
        name = 'ortalab_loteria',
        collection = "Loteria Cards",
    },
    collection_rows = {2, 1},
    no_collection = true,
    shop_rate = 0,
    default = 'c_ortalab_edition_+'
})

SMODS.Consumable({
    key = 'edition_+',
    set = 'Ortalab_Utility',
    atlas = 'temp',
    pos = {x=0, y=0},
    discovered = false,
    pixel_size = {h = 73},
    config = {extra = {edition = nil, selected = 1}},
    artist_credits = {'eremel'},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.edition]
        return {vars = {card.ability.extra.edition and localize({type = 'name_text', key = card.ability.extra.edition, set = 'Edition'}) or localize('ortalab_edition_plus')}}
    end,
    set_ability = function(self, card, from_debuff)
        card.ability.extra.edition = poll_edition('ortalab_edition_+',nil,nil,true)
        card:set_cost()
        card.base_cost = 5 + 3*G.P_CENTERS[card.ability.extra.edition].extra_cost
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                play_sound(G.P_CENTERS[card.ability.extra.edition].sound.sound, G.P_CENTERS[card.ability.extra.edition].sound.per, G.P_CENTERS[card.ability.extra.edition].sound.vol)
                card:juice_up(1, 0.5)                
                return true
            end
        }))
       
    end,
    can_use = function(self, card)
        return (#G.hand.highlighted + #G.jokers.highlighted) == card.ability.extra.selected
    end,
    use = function(self, card, area, copier)
        local selected = G.hand.highlighted[1] or G.jokers.highlighted[1]
        selected:set_edition(card.ability.extra.edition, false, false, true)
    end,
    set_card_type_badge = function(self, card, badges)
        badges = {}
    end,
    cost = 6
})

SMODS.DrawStep({
    key = 'edition+',
    order = 10,
    func = function(self)
        if self.config.center.key == 'c_ortalab_edition_+' then
            self.children.center:draw_shader(G.P_CENTERS[self.ability.extra.edition].shader, nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
})]]

local buy_space = G.FUNCS.check_for_buy_space
G.FUNCS.check_for_buy_space = function(card)
    if card.tag then
        return true
    end
    return buy_space(card)
end

local add_to_deck = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if self.tag then
        return
    end
    add_to_deck(self, from_debuff)
end