SMODS.Atlas {
    key = 'prismenhanced',
    path = "enhanced.png",
    px = 71,
    py = 95
}
SMODS.Enhancement({
    key = "crystal",
    atlas = "prismenhanced",
    pos = {x = 0, y = 0},
    discovered = true,
    config = {extra = {x_mult = 1,x_gain = 0.25}},
    effect = "Glass Card",
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.x_mult, card_ability.extra.x_gain}
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                xmult = card.ability.extra.x_mult
            }
        end
        if context.end_of_round and context.cardarea == G.hand and context.playing_card_end_of_round then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_gain
            return{
				colour = G.C.RED,
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
				card = card,
            }
        end
	end
})

SMODS.Enhancement({
    key = "burnt",
    atlas = "prismenhanced",
    pos = {x = 0, y = 1},
    discovered = true,
    config = {extra = 2},
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = {card_ability.extra}
        }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card then
            G.GAME.prism_extra_draw = G.GAME.prism_extra_draw + card.ability.extra
        end
    end
})
SMODS.Enhancement({
    key = "echo",
    atlas = "prismenhanced",
    pos = {x = 1, y = 2},
    discovered = true,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            local retrig = 0
            for i, _card in pairs(G.play.cards) do
                if SMODS.has_enhancement(_card,'m_prism_echo') then
                    retrig = retrig + 1
                end
            end
            if retrig - 1 > 0 then
                return {
                    message = localize('k_again_ex'),
                    repetitions = retrig - 1,
                    card = card
                }
            end
        end
    end
})

SMODS.Enhancement({
    key = "ice",
    atlas = "prismenhanced",
    pos = {x = 0, y = 2},
    discovered = true,
    effect = "Glass Card",
    config = {extra = {chips = 8}},
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.chips, card_ability.extra.chips*(G.GAME.prism_cards_played or 0)}
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips*(G.GAME.prism_cards_played or 0)
            }
        end
    end
})
--[[ SMODS.Enhancement({
    key = "double",
    atlas = "prismenhanced",
    pos = {x = 0, y = 2},
    discovered = true,
    config = {extra = {card = nil}},
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        if card_ability.extra.card then
            return {
                vars = {string.format("%s %s %s",localize(card_ability.extra.card.value, 'ranks'), localize('k_of'), localize(card_ability.extra.card.suit, 'suits_plural'))}
            }
        else 
            return {
                vars = {localize('k_another_card')}
            }
        end
    end,
    set_ability = function(self, card, initial,delay_sprites)
        card.ability.extra.card = pseudorandom_element(G.P_CARDS, pseudoseed('double_card'))--Placeholder until i find a better way

        if not card.ability.extra.card and card.base then
            local _card = pseudorandom_element(G.P_CARDS, pseudoseed('double_card'))
            card.ability.extra.card = _card
        end
	end
}) ]]

--[[ local orig_highlight = Card.highlight
function Card:highlight(highlighted)
    orig_highlight(self, highlighted)
    if DTM and DTM.config.disable_action_buttons and highlighted and self.ability.set == 'Enhanced' and self.ability.name == 'm_prism_double' then
        if self.children.use_button and self.config.center_key == 'm_prism_double' then
            self.children.use_button:remove()
        end
    elseif highlighted and self.config.center_key == 'm_prism_double' and self.area == G.hand then
        self.children.use_button = UIBox{
            definition = G.UIDEF.use_switch_button(self),
            config = {align = 'tm', offset = {x=0, y=0.4}, parent = self, id = 'm_prism_double'}
        }
    elseif self.area and #self.area.highlighted > 0 and not G.STATE == G.STATES.STANDARD_PACK then
        for _, card in ipairs(self.area.highlighted) do
            if card.config.center_key == 'm_prism_double' then
                card.children.use_button = UIBox{
                    definition = G.UIDEF.use_switch_button(card),
                    config = {align = 'tm', offset = {x=0, y=0.4}, parent = card}
                } or nil
            end
        end
    end
    if highlighted and self.children.use_button and self.children.use_button.config.id == 'm_prism_double' and self.config.center_key ~= 'm_prism_double' then
        self.children.use_button:remove()
    end
end ]]

function G.UIDEF.use_switch_button(card)
    local button = nil
    button = {n=G.UIT.C, config={align = "tm"}, nodes={
            {n=G.UIT.C, config={
                ref_table = card, 
                align = "tm",maxw = 2,
                padding = 0.1, r=1,
                minw = 1.4,
                minh = 0.8,
                hover = true,
                colour = G.C.RED,
                button = 'switch_button'},
                nodes={
                {n=G.UIT.T, config={text = localize("prism_switch"), colour = G.C.UI.TEXT_LIGHT, scale = 0.35, shadow = true}}
            }}
        }}
    return button
end

G.FUNCS.switch_button = function(e, mute, nosave)
    local card = e.config.ref_table
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
        local _card = card.config.card
        card:set_base(card.ability.extra.card)
        card.ability.extra.card = _card
        card:juice_up(0.3, 0.5)
    return true end}))
end
if not G.PRISM.config.old_green then
SMODS.Seal({
    key = "green",
    atlas = "prismenhanced",
    pos = {x = 1, y = 0},
    discovered = true,
    badge_colour = HEX('65AE5E'),
})
else
SMODS.Seal({
    key = "green_old",
    atlas = "prismenhanced",
    pos = {x = 1, y = 0},
    discovered = true,
    badge_colour = HEX('65AE5E'),
})
end

SMODS.Seal({
    key = "moon",
    atlas = "prismenhanced",
    pos = {x = 1, y = 1},
    discovered = true,
    badge_colour = HEX('86ADB3'),
    config = {extra = {odds = 3}},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                "" .. (G.GAME and G.GAME.probabilities.normal or 1),
                self.config.extra.odds}
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.before and context.scoring_hand and pseudorandom('moon') < G.GAME.probabilities.normal / self.config.extra.odds then
            level_up_hand(card,G.GAME.last_hand_played)
        end
    end
})