SMODS.Joker{
    key = 'grossmichael',
    atlas = 'roffers',
    rarity = 1,
    cost = 4,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    pos = { x = 5, y = 2 },
    config = { extra = { xmult = 1.5, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = { key = "c_collagexdread_rotten", set = "Other" }
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'grossmichael')
        return {vars = {card.ability.extra.xmult, n, d}}
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint and SMODS.pseudorandom_probability(card, pseudoseed('grossmichael'), 1, card.ability.extra.odds, 'grossmichael') then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local rotted = 0
                    for key, value in pairs(G.consumeables.cards) do
                        if rot_card(value, card) then
                            rotted = rotted + 1
                        end
                    end

                    local n,_ = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'grossmichael')
                    -- gross michael has a reduced chance to die
                    -- if there was nothing to rot when it tried.
                    -- to enhance the illusion, it dies anyways if
                    -- the base probability is guaranateed
                    if rotted >= 1 or n >= 4 or SMODS.pseudorandom_probability(card, pseudoseed('grossmichael_die_anyways'), 1, 3, 'grossmichael_die_anyways', true) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 0.3,
                                    blockable = false,
                                    func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                        return true;
                                    end
                                }))
                                return true
                            end
                        }))
                        
                        forced_message(localize('k_roff_gross_dead'), card)
                    end

                    return true
                end
            }))
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    set_badges = function (self, card, badges)
        badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
        badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
    end
}