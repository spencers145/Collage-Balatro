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
    collection_rows = {4, 4},
    shop_rate = 0.7,
    default = 'c_prism_myth_gnome'
})
SMODS.UndiscoveredSprite({
    key = "Myth",
    atlas = "prismmyth",
    pos = { x = 0, y = 0 },
    no_overlay = true
})

SMODS.Consumable({
    key = 'myth_dwarf',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=0},
    discovered = true,
    config = {mod_conv = "m_prism_crystal", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_dragon',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=0},
    discovered = true,
    config = {mod_conv = "m_prism_burnt", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_siren',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=1},
    discovered = true,
    config = {mod_conv = "m_prism_echo", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_yeti',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=8, y=1},
    discovered = true,
    config = {mod_conv = "m_prism_ice", max_highlighted = 2},
    effect = 'Enhance',
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

		return { vars = { self.config.max_highlighted } }
	end,

})
SMODS.Consumable({
    key = 'myth_egg',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=8, y=0},
    discovered = true,
    config = {odds = 4,money = 15},
    loc_vars = function(self, info_queue)
		info_queue[#info_queue + 1] = {key = 'e_prism_gold_foil', set = 'Edition', config = {extra = 1}}
        return { vars = {G.GAME.probabilities.normal,self.config.odds + (G.GAME.prism_eggs_used or 0) * 2, self.config.money} }
	end,
    can_use = function(self,card)
        for _, v in pairs(G.jokers.cards) do
            if v.ability.set == 'Joker' and (not v.edition and v.config.center.blueprint_compat) then
                return true
            end
        end
    end,
    use = function(self, card, area, copier)
        if pseudorandom(pseudoseed('eggo_roll')) < (G.GAME.probabilities.normal / (card.ability.odds + (G.GAME.prism_eggs_used or 0) * 2)) then
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

}) 
SMODS.Consumable({
    key = 'myth_mirror',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=0},
    config = {odds = 4},
    discovered = true,
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
SMODS.Consumable({
    key = 'myth_druid',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=0, y=1},
    discovered = true,
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
})
SMODS.Consumable({
    key = 'myth_beast',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=1},
    discovered = true,
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
})
SMODS.Consumable({
    key = 'myth_wizard',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=1, y=1},
    discovered = true,
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
SMODS.Consumable({
    key = 'myth_treant',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=7, y=0},
    discovered = true,
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
})
SMODS.Consumable({
    key = 'myth_ooze',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=0},
    discovered = true,
    config = {seal_conv = G.PRISM.config.old_green and "prism_green_old" or "prism_green", max_highlighted = 1},
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

SMODS.Consumable({
    key = 'myth_colossus',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=4, y=1},
    discovered = true,
    config = {seal_conv = "prism_moon", max_highlighted = 1},
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
SMODS.Consumable({
    key = 'myth_gnome',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=3, y=0},
    discovered = true,
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

SMODS.Consumable({
    key = 'myth_kraken',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=5, y=1},
    discovered = true,
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
SMODS.Consumable({
    key = 'myth_roc',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=6, y=0},
    discovered = true,
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
SMODS.Consumable({
    key = 'myth_ghoul',
    set = 'Myth',
    atlas = 'prismmyth',
    pos = {x=2, y=1},
    discovered = true,
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
                    G.PRISM.destroy_cards({target})
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
        G.E_MANAGER:add_event(Event({trigger = 'after',func = function() G.hand:unhighlight_all(); return true end})) ]]
    end

})
SMODS.Consumable({
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
        G.ENTERED_TEXT = ""
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            --djinn_background_color()
            play_sound('tarot2')
            card:juice_up(0.3, 0.5)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
                G.CHOOSE_CARD = UIBox({
                    definition = djinn_UIBox(card),
                    config = {
                        align = "cm",
                        major = G.ROOM_ATTACH,
                        bond = "Weak",
                        instance_type = "POPUP",
                    },
                })
            return true end }))
        return true end }))
    end
})

--Boosters
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
})

--Djinn
G.PRISM.FUNCS.find_card = function(entered_text)
	local function clean_string(str)
		str = str:gsub("%b{}", ""):gsub("%s+", ""):gsub("ö", "o"):gsub("'", "")
		if string.len(str) == 1 then
			return str
		end
		return string.lower(str)
	end
	for k, v in pairs(G.P_CENTERS) do
		if v.set and v.set == "Joker" and clean_string(entered_text) == clean_string(localize({ type = "name_text", set = "Joker", key = k })) then
            local banned = false
            for _, r in ipairs(G.PRISM.djinn_banned_rarities) do
                if v.rarity == r then
                    banned = true
                    break
                end
            end
            if not banned then return k end
		end
	end
    return nil
end
function djinn_UIBox(card)
	G.E_MANAGER:add_event(Event({
		blockable = false,
		func = function()
			G.REFRESH_ALERTS = true
			return true
		end,
	}))
	local t = create_UIBox_generic_options_djinn({
		no_back = true,
		colour = G.C.SET.Spectral,
		outline_colour = G.C.DARK_EDITION,
        blocking = true,
        blockable = true,
		contents = {
						{n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					UIBox_button({
						colour = G.C.DARK_EDITION,
						button = "djinn_create",
						label = { localize("prism_create")},
						minw = 4,
						focus_args = { snap_to = true },
					}),
				},
			},
			{n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					UIBox_button({
						colour = G.C.RED,
						button = "djinn_cancel",
						label = { localize("prism_cancel")},
						minw = 4,
						focus_args = { snap_to = true },
					}),
				},
},
            {n = G.UIT.R,
				nodes = {
					create_text_input({
						colour = G.C.DARK_EDITION,
						w = 4,
						h = 1,
                        prompt_text = localize("prism_enter_card"),
						max_length = 100,
						extended_corpus = true,
						ref_table = G,
						ref_value = "ENTERED_TEXT",
						keyboard_offset = 1,
					}),
				},
			},
		},
	})
	return t
end

G.FUNCS.djinn_create = function()
    local chosen_card = G.PRISM.FUNCS.find_card(G.ENTERED_TEXT)
    if chosen_card then
        G.CHOOSE_CARD:remove()
        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, chosen_card)
		card:add_to_deck()
		G.jokers:emplace(card)
        play_sound('timpani')
        --[[ ease_background_colour({
            special_colour = G.DJINN_OLD_COLORS.special_colour, 
            tertiary_colour = G.DJINN_OLD_COLORS.tertiary_colour, 
            new_colour = G.DJINN_OLD_COLORS.new_colour
        })
        G.booster_pack_sparkles:remove() ]]
    else 
        djinn_text(localize("prism_invalid_card"))
    end
end

G.FUNCS.djinn_cancel = function()
	G.CHOOSE_CARD:remove()
    --[[ ease_background_colour({
        new_colour = G.DJINN_OLD_COLORS.new_colour,
        special_colour = G.DJINN_OLD_COLORS.special_colour,
        tertiary_colour = G.DJINN_OLD_COLORS.tertiary_colour,
    })
    G.booster_pack_sparkles:remove() ]]
end

--[[ function djinn_background_color()
    G.DJINN_OLD_COLORS = {
        new_colour = copy_table(G.C.BACKGROUND.L),
        special_colour = copy_table(G.C.BACKGROUND.C),
        tertiary_colour = copy_table(G.C.BACKGROUND.D),  
    }
    G.booster_pack_sparkles = Particles(1, 1, 0,0, {
        timer = 0.015,
        scale = 0.2,
        initialize = true,
        lifespan = 1,
        speed = 1.1,
        padding = -1,
        attach = G.ROOM_ATTACH,
        colours = {G.C.WHITE, lighten(G.C.SET.Spectral, 0.4), lighten(G.C.SET.Spectral, 0.2), lighten(G.C.GOLD, 0.2)},
        fill = true
    })
    G.booster_pack_sparkles.fade_alpha = 1
    G.booster_pack_sparkles:fade(1, 0)
    ease_background_colour{
        new_colour = G.C.SET.Spectral,
        special_colour = G.C.SET.Spectral,
        tertiary_colour = G.C.SET.GOLD,
    }
end ]]

function djinn_text(message)
    attention_text({scale = 1, text = message, hold = 2, align = 'cm', offset = {x = 0,y = -3},major = G.ROOM_ATTACH})
    delay(1.5)
end

function create_UIBox_generic_options_djinn(args)
    args = args or {}
    local back_func = args.back_func or "exit_overlay_menu"
    local contents = args.contents or ({n=G.UIT.T, config={text = "EMPTY",colour = G.C.UI.RED, scale = 0.4}})
    if args.infotip then 
      G.E_MANAGER:add_event(Event({
        blocking = false,
        blockable = false,
        timer = 'REAL',
        func = function()
            if G.OVERLAY_MENU then
              local _infotip_object = G.OVERLAY_MENU:get_UIE_by_ID('overlay_menu_infotip')
              if _infotip_object then 
                _infotip_object.config.object:remove() 
                _infotip_object.config.object = UIBox{
                  definition = overlay_infotip(args.infotip),
                  config = {offset = {x=0,y=0}, align = 'bm', parent = _infotip_object}
                }
              end
            end
            return true
          end
      }))
    end
  
    return {n=G.UIT.ROOT, config = {align = "cm", minw = G.ROOM.T.w*5, minh = G.ROOM.T.h*5,padding = 0.1, r = 0.1, colour = args.bg_colour or {G.C.GREY[1], G.C.GREY[2], G.C.GREY[3],0}}, nodes={
      {n=G.UIT.R, config={align = "cm", minh = 1,r = 0.3, padding = 0.07, minw = 1, colour = args.outline_colour or G.C.JOKER_GREY, emboss = 0.1}, nodes={
        {n=G.UIT.C, config={align = "cm", minh = 1,r = 0.2, padding = 0.2, minw = 1, colour = args.colour or G.C.L_BLACK}, nodes={
          {n=G.UIT.R, config={align = "cm",padding = args.padding or 0.2, minw = args.minw or 7}, nodes=
            contents
          },
          not args.no_back and {n=G.UIT.R, config={id = args.back_id or 'overlay_menu_back_button', align = "cm", minw = 2.5, button_delay = args.back_delay, padding =0.1, r = 0.1, hover = true, colour = args.back_colour or G.C.ORANGE, button = back_func, shadow = true, focus_args = {nav = 'wide', button = 'b', snap_to = args.snap_back}}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes={
              {n=G.UIT.T, config={id = args.back_id or nil, text = args.back_label or localize('b_back'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = not args.no_pip and 'set_button_pip' or nil, focus_args =  not args.no_pip and {button = args.back_button or 'b'} or nil}}
            }}
          }} or nil
        }},
      }},
      {n=G.UIT.R, config={align = "cm"}, nodes={
        {n=G.UIT.O, config={id = 'overlay_menu_infotip', object = Moveable()}},
      }},
    }}
  end