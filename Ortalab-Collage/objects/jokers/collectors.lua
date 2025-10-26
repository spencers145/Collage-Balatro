SMODS.Joker({
    key = "collectors",
    atlas = "jokers",
    pos = {x = 2, y = 6},
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {}},
    artist_credits = {'tevi'},
    draw = function(self, card, layer)
        card.children.center:draw_shader('voucher',nil, card.ARGS.send_to_shader)
    end,
    calculate = function(self, card, context)
        if context.blueprint then return end
        if context.setting_blind then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and G.GAME.current_round.discards_used == 0 then
            card.ability.extra.destroy_card = pseudorandom_element(context.full_hand, pseudoseed('ortalab_collectors_destroy'))
        end
        if context.discard and context.other_card == card.ability.extra.destroy_card then
            local modifiers = {
                enhancement = context.other_card.ability.set == 'Enhanced' and context.other_card.config.center_key or nil,
                edition = context.other_card.edition and context.other_card.edition.key or nil,
                seal = context.other_card.seal or nil
            }
            local i = 1
            local possible = {}
            for k, v in pairs(modifiers) do
                if v then possible[#possible + 1] = k end
            end
            local mod_type = pseudorandom_element(possible, pseudoseed('ortalab_collectors_choice'))
            
            local waiting = true
            while waiting do
                if G.hand.cards[i].highlighted then
                    i = i + 1
                else
                    if mod_type then
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.7,
                            func = function()              
                                if mod_type == 'enhancement' then
                                    G.hand.cards[i]:set_ability(G.P_CENTERS[modifiers.enhancement], nil, true)
                                elseif mod_type == 'seal' then
                                    G.hand.cards[i]:set_seal(modifiers.seal)
                                else
                                    G.hand.cards[i]:set_edition(modifiers.edition)
                                end
                                return true
                            end
                        }))
                    end
                    waiting = false
                end
            end
            return {
                remove = true,
                message = mod_type and localize('ortalab_collected'),
                message_card = G.hand.cards[i]
            }
        end
    end    
})