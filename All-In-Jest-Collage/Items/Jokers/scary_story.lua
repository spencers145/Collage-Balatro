
local scary_story = {
    object_type = "Joker",
    order = 26,

    key = "scary_story",
    config = {
        extra = {
            chance = 3
        }
    },
    rarity = 3,
    pos = { x = 0, y = 1 },
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.p_standard_normal_1
        info_queue[#info_queue + 1] = { key = 'e_negative_playing_card', set = 'Edition', config = { extra = G.P_CENTERS['e_negative'].config.card_limit } }
        local n,d = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'scary_story')
        return {
            vars = {
                n,
                d
            }
        }
    end,

    calculate = function(self, card, context)
        if context.open_booster and context.card.ability.name and not context.blueprint then
            if (context.open_booster and context.card.config.center.kind == 'Standard') then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] and G.pack_cards.VT.y < G.ROOM.T.h then
                            for _, v in ipairs(G.pack_cards.cards) do
                                if SMODS.pseudorandom_probability(card, pseudorandom('scary_story'), 1, card.ability.extra.chance, 'scary_story') and not v.edition then
                                    G.E_MANAGER:add_event(Event({
                                        trigger = 'after',
                                        delay = 1,
                                        func = function()
                                            v:set_edition({ negative = true }, true, true)
                                            play_sound('negative', 1.5, 0.4)
                                            v:juice_up(0.3, 0.2)
                                            card:juice_up(0.3, 0.2)
                                            return true
                                        end
                                    }))
                                end
                            end
                            return true
                        end
                    end
                }))
            end
        end
    end

}
return { name = { "Jokers" }, items = { scary_story } }