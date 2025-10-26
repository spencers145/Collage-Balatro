SMODS.Sound({ key = "creamer", path = "creamer.ogg" })

SMODS.Joker {
    key = "creamer",
    discovered = false,
    unlocked = true,
    blueprint_compat = false,
    eternal_compat = false,
    config = { extra = { cream_rounds = 0, total_rounds = 3 } },
    rarity = 1,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 7, y = 4 },
    cost = 3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cream_rounds, card.ability.extra.total_rounds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local tag_key = get_next_tag_key()
                    while tag_key == 'tag_orbital' do
                        -- nuh uh
                        tag_key = get_next_tag_key()
                    end
                    add_tag(Tag(tag_key))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end
            }))

            if not context.blueprint then
                card.ability.extra.cream_rounds = card.ability.extra.cream_rounds + 1
                if card.ability.extra.cream_rounds == card.ability.extra.total_rounds then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('vis_creamer')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            return true
                        end
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            G.jokers:remove_card(card)
                            card:remove()
                            return true
                        end
                    }))
                end
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+1 Tag(s)" }
            },
            extra = {
                {
                    { text = "(" },
                    { ref_table = "card.joker_display_values", ref_value = "remain_count" },
                    { text = " remaining)" }
                }
            },
            text_config = { colour = G.C.GREEN },
            extra_config = { colour = G.C.GREY },
            calc_function = function (card)
                card.joker_display_values.remain_count = card.ability.extra.total_rounds - card.ability.extra.cream_rounds
            end
        }
    end
}
