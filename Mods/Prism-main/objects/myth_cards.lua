SMODS.Atlas({
    key = 'prismmyth',
    path = 'myth.png',
    px = '71',
    py = '95'
})
SMODS.Atlas({
    key = 'prismboosters',
    path = 'boosters.png',
    px = '71',
    py = '95'
})
SMODS.ConsumableType({
    key = "Myth",
    primary_colour = G.PRISM.C.myth_1,
    secondary_colour = G.PRISM.C.myth_2,
    collection_rows = {4, 5},
    shop_rate = 0,
    default = 'c_prism_myth_gnome'
})
SMODS.UndiscoveredSprite({
    key = "Myth",
    atlas = "prismmyth",
    pos = { x = 0, y = 0 },
    no_overlay = true
})
function G.PRISM.Consumable(table)
	if table.dependency or table.dependency == nil then
		SMODS.Consumable(table)
	end
end
G.PRISM.Consumable({
    dependency = G.PRISM.config.enhance_enabled,
    key = 'myth_dwarf',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=0},
    cost = 4,
    discovered = false,
    config = {mod_conv = "m_prism_crystal", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
G.PRISM.Consumable({
    dependency = G.PRISM.config.enhance_enabled,
    key = 'myth_dragon',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=0},
    cost = 4,
    discovered = false,
    config = {mod_conv = "m_prism_burnt", max_highlighted = 3},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
G.PRISM.Consumable({
    dependency = G.PRISM.config.enhance_enabled,
    key = 'myth_siren',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=1},
    cost = 4,
    discovered = false,
    config = {mod_conv = "m_prism_echo", max_highlighted = 3},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
G.PRISM.Consumable({
    dependency = G.PRISM.config.enhance_enabled,
    key = 'myth_yeti',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=8, y=1},
    cost = 4,
    discovered = false,
    config = {mod_conv = "m_prism_ice", max_highlighted = 3},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
--[[
SMODS.Consumable({
    key = 'myth_egg',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=8, y=0},
    cost = 4,
    discovered = false,
    config = {odds = 3,money = 15},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = {key = 'e_prism_gold_foil', set = 'Edition', config = {extra = 1}}
        local n, d = SMODS.get_probability_vars(self,1,self.config.odds + (G.GAME.prism_eggs_used or 0) * 2,"gold_egg")
        return { vars = {n,d, self.config.money} }
	end,
    can_use = function(self,card)
        for _, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition and v.config.center.blueprint_compat) then
                return true
            end
        end
    end,
    use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card,"egg_roll",1,card.ability.odds + (G.GAME.prism_eggs_used or 0) * 2) then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(-card.ability.money)
                local eligible_cards = {}
                for k, v in ipairs(G.jokers.cards) do
                    if not v.edition and v.config.center.blueprint_compat then
                        table.insert(eligible_cards,v)
                    end
                end
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                local random_card = pseudorandom_element(eligible_cards, pseudoseed('egg_joker'))
                if random_card then random_card:set_edition("e_prism_gold_foil", true) end
                G.GAME.prism_eggs_used = G.GAME.prism_eggs_used + 1
            return true end }))
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                ease_dollars(-card.ability.money)
                attention_text({
                    text = localize('k_nope_ex'),
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.SECONDARY_SET.Loteria,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                })
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                    play_sound('tarot2', 0.76, 0.4)
                return true end}))
                play_sound('tarot2', 1, 0.4)
                card:juice_up(0.3, 0.5)
            return true end }))
        end
    end

}) ]]
G.PRISM.Consumable({
    key = 'myth_mirror',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=0},
    config = {odds = 4},
    cost = 4,
    discovered = false,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
        return { vars = {G.GAME.probabilities.normal,self.config.odds} }
	end,
    can_use = function(self,card)
        return G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED 
    end,
    use = function(self, card, area, copier)
        if pseudorandom(pseudoseed('mirror_roll')) < (G.GAME.probabilities.normal / card.ability.odds) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                        local eligible_cards = {}
                        for k, v in ipairs(G.hand.cards) do
                            if not v.edition then
                                table.insert(eligible_cards,v)
                            end
                        end
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        local random_card = pseudorandom_element(eligible_cards, pseudoseed('mirror'))
                        if random_card then random_card:set_edition({negative = true}, true) end
                    return true end }))
                return true end }))
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Loteria,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4)
                    return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                return true end }))
            end


        
    end

}) 
--[[
G.PRISM.Consumable({
    key = 'myth_druid',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=0, y=1},
    cost = 4,
    discovered = false,
    config = {max_highlighted = 2},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 2
	end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
        return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                local edition = rightmost.edition
                local enhancement = rightmost.config.center.key
                local seal = rightmost.seal
                if G.hand.highlighted[i] ~= rightmost then
                    local leftmost = G.hand.highlighted[i]
                    if not leftmost.edition then leftmost:set_edition(edition) end
                    if leftmost.config.center.key == "c_base" then leftmost:set_ability(G.P_CENTERS[enhancement]) end
                    if not leftmost.seal then leftmost:set_seal(seal) end
                end
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
})]]
--[[
G.PRISM.Consumable({
    key = 'myth_beast',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=1},
    discovered = false,
    cost = 4,
    config = {odds = 2},
    loc_vars = function(self, info_queue)
        return { vars = {G.GAME.probabilities.normal,self.config.odds} }
	end,
    can_use = function(self,card)
        return G.consumeables.config.card_limit > #G.consumeables.cards or card.area == G.consumeables
    end,
    use = function(self, card, area, copier)
        if G.consumeables.config.card_limit > #G.consumeables.cards then
            if pseudorandom(pseudoseed('beast_roll')) < (G.GAME.probabilities.normal / card.ability.odds) then
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    play_sound('timpani')
                    local _card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'beast')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    card:juice_up(0.3, 0.5)
                return true end }))
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3, 
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Loteria,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4)
                    return true end}))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                return true end }))
            end

        end
        

    end
})]]
G.PRISM.Consumable({
    key = 'myth_opus',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=9, y=0},
    cost = 4,
    discovered = false,
    config = {max_highlighted = 3},
    loc_vars = function(self, info_queue)
        if G.playing_cards then
            local enhancements = {}
            for _,v in ipairs(G.playing_cards) do
                if v.config.center.key ~= "c_base" then
                enhancements[v.config.center.key] = (enhancements[v.config.center.key] or 0) + 1
                end
            end
            local pollable_enhance = {}
            local enhanc_count = 0
            for k,v in pairs(enhancements) do
                if v > enhanc_count then
                    enhanc_count = v
                    pollable_enhance = {}
                    table.insert(pollable_enhance,k)
                elseif v == enhanc_count then
                    table.insert(pollable_enhance,k)
                end
            end
            local enhancement = #pollable_enhance == 1 and pollable_enhance[1]
            local enha = enhancement and localize{type = 'name_text', key = enhancement, set = 'Enhanced'} or #pollable_enhance > 1 and localize('k_tied') or localize('k_none')
            local colour = #pollable_enhance > 1 and G.C.FILTER or not enhancement and G.C.RED or G.C.GREEN
            return { 
                vars = {self.config.max_highlighted},
                main_end = {
                    {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                        {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                            {n=G.UIT.T, config={text = ' '..enha..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                        }}
                    }}
                }
            }
        end
        return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        local enhancements = {}
        for _,v in ipairs(G.playing_cards) do
            if v.config.center.key ~= "c_base" then
            enhancements[v.config.center.key] = (enhancements[v.config.center.key] or 0) + 1
            end
        end
        local pollable_enhance = {}
        local enhanc_count = 0
        for k,v in pairs(enhancements) do
            if v > enhanc_count then
                enhanc_count = v
                pollable_enhance = {}
                table.insert(pollable_enhance,k)
            elseif v == enhanc_count then
                table.insert(pollable_enhance,k)
            end
        end
        local enhancement = pseudorandom_element(pollable_enhance,"opus") 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                if enhancement then
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[enhancement])
                end
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
})
G.PRISM.Consumable({
    key = 'myth_wizard',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=1},
    cost = 4,
    discovered = false,
    config = {max_highlighted = 3},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 2
	end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        local rank = rightmost.config.card.value
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                SMODS.change_base(G.hand.highlighted[i],nil,rank)
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
}) 
--[[
G.PRISM.Consumable({
    key = 'myth_treant',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=7, y=0},
    cost = 4,
    discovered = false,
    config = {max_highlighted = 3},
    loc_vars = function(self, info_queue)
		return { vars = { self.config.max_highlighted } }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 2
	end,
    use = function(self, card, area, copier)
        local rightmost = G.hand.highlighted[1]
        for i=1, #G.hand.highlighted do if G.hand.highlighted[i].T.x > rightmost.T.x then rightmost = G.hand.highlighted[i] end end
        local suit = rightmost.base.suit
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        for i=1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
                SMODS.change_base(G.hand.highlighted[i],suit,nil)
            return true end }))
        end
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end}))
    end
})]]
G.PRISM.Consumable({
    key = 'myth_ooze',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=0},
    cost = 4,
    discovered = false,
    config = {seal_conv = G.PRISM.config.old_green and "prism_green_old" or "prism_green", max_highlighted = 2},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_SEALS[self.config.seal_conv]

		return { vars = {self.config.max_highlighted} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_seal(self.config.seal_conv)
            end
        return true end }))
    end
})
G.PRISM.Consumable({
    key = 'myth_colossus',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=1},
    cost = 4,
    discovered = false,
    config = {seal_conv = "prism_moon", max_highlighted = 2},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_SEALS[self.config.seal_conv]

		return { vars = {self.config.max_highlighted} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= self.config.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_seal(self.config.seal_conv)
            end
        return true end }))
    end

}) 
--[[
G.PRISM.Consumable({
    key = 'myth_gnome',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=0},
    cost = 4,
    discovered = false,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = {key = 'tag_prism_gnome', set = 'Tag',specific_vars = {17}}
	end,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
			play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card:juice_up(0.3, 0.5)
            add_tag(Tag('tag_prism_gnome'))
        return true end }))
    end
})

G.PRISM.Consumable({
    key = 'myth_kraken',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=1},
    cost = 4,
    discovered = false,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = {key = 'tag_juggle', set = 'Tag',specific_vars = {3}}
	end,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
			play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card:juice_up(0.3, 0.5)
            add_tag(Tag('tag_juggle'))
        return true end }))
    end
})
G.PRISM.Consumable({
    key = 'myth_roc',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=0},
    cost = 4,
    discovered = false,
    loc_vars = function(self, info_queue)
		info_queue[#info_queue+1] = {key = 'tag_double', set = 'Tag'}
	end,
    can_use = function(self, card)
		return true
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
			play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            card:juice_up(0.3, 0.5)
            add_tag(Tag('tag_double'))
        return true end }))
    end
})
G.PRISM.Consumable({
    key = 'myth_ghoul',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=1},
    cost = 4,
    discovered = false,
    config = {max_highlighted = 1,chips_mult = 3},
    loc_vars = function(self, info_queue)
		return { vars = {self.config.max_highlighted,self.config.chips_mult} }
	end,
    can_use = function(self, card)
		return #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted >= 1
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {trigger = 'after',delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                for i=1, #G.hand.highlighted do
                    local target = G.hand.highlighted[i]
                    local hand_i = nil
                    for j=1, #G.hand.cards do
                        if G.hand.cards[j] == target then hand_i = j end
                    end
                    local left_card = hand_i and G.hand.cards[hand_i-1]
                    local right_card = hand_i and G.hand.cards[hand_i+1]
                    local chips = SMODS.has_no_rank(target) and 0 or target.base.nominal * card.ability.chips_mult
                    SMODS.destroy_cards({target})
                    if left_card then
                        left_card.ability.perma_bonus = (left_card.ability.perma_bonus or 0) + chips
                        left_card:juice_up(0.3, 0.5)
                    end
                    if right_card then
                        right_card.ability.perma_bonus = (right_card.ability.perma_bonus or 0) + chips
                        right_card:juice_up(0.3, 0.5)
                    end
                end
                return true
            end
        })
        --[[ local _card_1 = G.hand.highlighted[1]
        local _card_2 = G.hand.highlighted[2]
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('card1', percent);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.8,func = function()
            for i=1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_prism_double)
            end
            _card_1.ability.extra.card = _card_2.config.card
            _card_2.ability.extra.card = _card_1.config.card
        return true end }))
        for i=1, #G.hand.highlighted do
            local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() G.hand.highlighted[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.highlighted[i]:juice_up(0.3, 0.3);return true end }))
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end})) ]] --[[
    end

})
G.PRISM.Consumable({
    key = 'myth_fae',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=9, y=1},
    cost = 4,
    discovered = false,
    config = {dollars = 3, max = 30},
    loc_vars = function(self, info_queue, card)
        local level = 0
        for k, v in pairs(G.GAME.hands) do
            if v.visible and to_big(v.level) > to_big(level) then
                level = v.level
            end
        end
        return {vars = {self.config.dollars,self.config.max, math.min(self.config.dollars * level, self.config.max)}}
    end,
    can_use = function(self,card)
        return true
    end,
    use = function(self, card, area, copier)
        local level = 0
        for k, v in pairs(G.GAME.hands) do
            if v.visible and to_big(v.level) > to_big(level) then
                level = v.level
            end
        end
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.4,func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            ease_dollars(math.min(self.config.dollars * level, self.config.max))
        return true end }))
    end
})
G.PRISM.Consumable({
    key = 'spectral_djinn',
    set = 'Spectral',
    atlas = 'prismmyth',
    pos = {x=7, y=1},
    discovered = true,
    cost = 4,
    hidden = true,
    soul_set = "Myth",
    can_use = function(self, card)
		return G.jokers.config.card_limit > #G.jokers.cards
	end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
			func = function()
				G.GAME.prism_choosing_card = "djinn"
				G.FUNCS.overlay_menu({ 
                    definition = SMODS.card_collection_UIBox(G.P_CENTER_POOLS.Joker, {5,5,5}, {
                        no_materialize = true,
                        h_mod = 0.95,
                        back_func = "exit_overlay_menu"
                    })
                })
				return true
			end,
		}))
    end,
})
]]
--Boosters
--[[
SMODS.Booster({
    key = 'small_myth_1',
    atlas = 'prismboosters',
    kind = "Myth",
    pos = { x = 0, y = 0 },
    config = {choose = 1, extra = 3},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 4,
    weight = 0.6,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'small_myth_2',
    atlas = 'prismboosters',
    kind = "Myth",
    pos = { x = 1, y = 0 },
    config = {choose = 1, extra = 3},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 4,
    weight = 0.6,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'mid_myth',
    atlas = 'prismboosters',
    kind = "Myth",
    pos = { x = 2, y = 0 },
    config = {choose = 1, extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 6,
    weight = 0.6,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})
SMODS.Booster({
    key = 'large_myth',
    atlas = 'prismboosters',
    kind = "Myth",
    pos = { x = 3, y = 0 },
    config = {choose = 2, extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars = {(card and card.ability.choose or self.config.choose), card and card.ability.extra or self.config.extra}}
    end,
    create_card = function(self, card)
        return create_card("Myth", G.pack_cards, nil, nil, true,  true, nil, "mythpack")
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.PRISM.C.myth_1)
        ease_background_colour{new_colour = G.PRISM.C.myth_1, special_colour = G.C.BLACK, contrast = 2}
    end,
    group_key = 'k_prism_myth_pack',
    draw_hand = true,
    cost = 8,
    weight = 0.15,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {G.PRISM.C.myth_1, lighten(G.PRISM.C.myth_1, 0.4), lighten(G.PRISM.C.myth_1, 0.2), darken(G.PRISM.C.myth_1, 0.2)},
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
})]]
