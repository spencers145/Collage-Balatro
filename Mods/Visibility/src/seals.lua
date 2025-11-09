--[[SMODS.Seal {
    key = 'bronze',
    atlas = "TextureAtlasSeals",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 1 } },
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.main_scoring then
            if context.scoring_hand[1].seal == "vis_bronze" then return end
            local effects = eval_card(context.scoring_hand[1], context)
            return effects["playing_card"]
        end
        if context.repetition and context.scoring_hand and context.scoring_hand[1].seal == "vis_bronze" then
            return { repetitions = 1 }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end
}]]


SMODS.Seal {
    key = "wooden",
    atlas = "TextureAtlasSeals",
    pos = { x = 1, y = 0 },
    config = { extra = { x_chips = 1.75, odds = 6 } },
    discovered = false,
    loc_vars = function (self, info_queue, card)
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.seal.extra.odds, 'wooden_seal')
        return { vars = { card.ability.seal.extra.x_chips, n, d } }
    end,
    badge_colour = HEX('623938'),
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and context.destroy_card == card
            and SMODS.pseudorandom_probability(card, pseudoseed('wooden_seal'), 1, card.ability.seal.extra.odds, 'wooden_seal') then
            return {
                message = "Cracked!",
                remove = true
            }
        end
        if context.main_scoring and context.cardarea == G.play then
            return {
                x_chips = card.ability.seal.extra.x_chips,
            }
        end
    end,
}

SMODS.Seal {
    key = "mitosis",
    atlas = "TextureAtlasSeals",
    pos = { x = 2, y = 0 },
    credits = {
        idea = "Monachrome",
        art = "SadCube"
    },
    discovered = false,
    config = {  },
    badge_colour = HEX('DC6094'),
    calculate = function(self, card, context)
        if context.after and context.full_hand[1] == card then
            if #context.full_hand ~= 1 then return end
            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
            local copy_card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
            copy_card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, copy_card)
            G.hand:emplace(copy_card)
            copy_card.states.visible = nil

            G.E_MANAGER:add_event(Event({
                func = function()
                    copy_card:start_materialize()
                    return true
                end
            }))
            return {
                message = localize('k_copied_ex'),
                colour = G.C.CHIPS,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.calculate_context({ playing_card_added = true, cards = { copy_card } })
                            return true
                        end
                    }))
                end
            }
        end
    end,
}

SMODS.Seal {
    key = "indigo",
    atlas = "TextureAtlasSeals",
    pos = { x = 3, y = 0 },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset"
    },
    discovered = false,
    config = { extra = { plays = 0, needed = 2, active = false } },
    badge_colour = HEX('514CDB'),
    loc_vars = function(self, info_queue, card)
        --info_queue[#info_queue+1] = G.P_CENTERS['bunc_consumable_edition_bunc_glitter']
        return { vars = { card.ability.seal.extra.plays, '/' .. card.ability.seal.extra.needed } }
    end,
    calculate = function(self, card, context)
        if context.repetition then return end
        --[[if context.destroying_card and card.ability.seal.extra.plays >= card.ability.seal.extra.needed then
            return {
                message = 'Sealed Away!',
                func = function()
                    G.E_MANAGER:add_event(Event({
                        delay = 0.3,
                        func = function()
                            card:start_dissolve()
                            return true
                        end
                    }))
                end,
                remove = true
            }
        end]]
        if context.cardarea == G.play and context.before then
            card.ability.seal.extra.plays = card.ability.seal.extra.plays + 1
            if card.ability.seal.extra.plays == card.ability.seal.extra.needed then
                card.ability.seal.extra.active = true
            end
        end
        if context.cardarea == G.play and context.after then
            if card.ability and card.ability.seal and card.ability.seal.extra and card.ability.seal.extra.active then
                local active_indigo = {}
                for key, value in pairs(context.scoring_hand) do
                    if value.ability and value.ability.seal and value.ability.seal.extra and value.ability.seal.extra.active then
                        table.insert(active_indigo, value)
                    end
                end

                if #active_indigo > 1 then
                    for key, value in pairs(active_indigo) do
                        if value.ability and value.ability.seal and value.ability.seal.extra then
                            value.ability.seal.extra.active = false
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = 0.6,
                            func = function()
                                --forced_message("Sealed away!", value)
                                value:set_seal(nil, nil, true)
                                value:juice_up()
                                play_sound("cardFan2", 0.9, 0.9)
                                return true
                            end
                        }))
                    end
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.6,
                        func = function()
                            link_cards(active_indigo)
                            return true
                        end
                    }))
                    
                    return {
                        message = "Linked!"
                    }
                end
                return {
                    message = localize('k_active_ex'),
                    --[[colour = G.C.CHIPS,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local added_card = SMODS.add_card({ set = 'Spectral' })
                                added_card:set_edition("e_bunc_glitter", true)
                                return true
                            end
                        }))
                    end]]
                }
            elseif card.ability.seal.extra.plays < card.ability.seal.extra.needed then
                return {
                    message = localize{ type = 'variable', key = 'k_seal_rounds', vars = { card.ability.seal.extra.plays, card.ability.seal.extra.needed } },
                    colour = G.C.CHIPS,
                }
            end
        end
    end,
}