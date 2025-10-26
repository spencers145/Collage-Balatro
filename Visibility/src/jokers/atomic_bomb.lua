SMODS.Joker {
    key = "atomic_bomb",
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    rarity = 2,
    cost = 5,
    config = { extra = { }},
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 5, y = 0 },
    calculate = function(self, card, context)
        if #G.hand.cards == 0 then
            card:set_eternal(true)
        else
            card:set_eternal(false)
        end

        if context.selling_self then
            -- Dissolve and remove all hand cards
            for k, v in pairs(G.hand.cards) do
                v:start_dissolve(nil)
                v:remove_from_deck()
            end

            -- Return effect for SMODS retriggering
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind:disable()
                                    play_sound('timpani')
                                    return true
                                end
                            }))
                            SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                            return true
                        end
                    }))
                    return true
                end
            }
        end
    end,
    in_pool = function (self, args)
        return false
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "Sell to destroy cards" },
            },
            reminder_text = {
                { ref_table = "card.joker_display_values", ref_value = "active_text" },
            },
            text_config = { scale = 0.5 },
            reminder_text_config = { scale = 1, colour = G.C.GREY },
            calc_function = function(card)
                local disableable = G.GAME and G.GAME.blind and G.GAME.blind.get_type and
                    ((not G.GAME.blind.disabled) and (G.GAME.blind:get_type() == 'Boss'))
                card.joker_display_values.active_text = disableable and "(Disables boss blind)" or ""
            end,
            style_function = function (card, text, reminder_text, extra)
                if text and text.children[1] then
                    text.children[1].config.scale = 1
                end
                if reminder_text and reminder_text.children[1] then
                    if #reminder_text.children[1].config.text == "" then
                        reminder_text.children[1].config.scale = 0
                    else
                        reminder_text.children[1].config.scale = 1
                    end
                    return true
                end
            end
        }
    end
}