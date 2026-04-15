SMODS.Joker{ --Keychain
    key = "keychain",
    config = {
        extra = {
            dollars = 2
        }
    },
    loc_txt = {
        ['name'] = '{X:white,C:default}K{}eychain',
        ['text'] = {
           'When a {C:attention}Tag{} is {C:attention}obtained{},',
           'lose {C:money}$2{} and gain',
           'another Tag'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 2
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["cmykl_cmykl_jokers"] = true },
     
    calculate = function(self, card, context)
    if context.tag_added and not context.tag_added.keychain_created then
        return {
            dollars = -card.ability.extra.dollars,
            extra = {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                            local tag = Tag(selected_tag)

                            tag.keychain_created = true

                            if tag.name == "Orbital Tag" then
                                local _poker_hands = {}
                                for k, v in pairs(G.GAME.hands) do
                                    if v.visible then
                                        _poker_hands[#_poker_hands + 1] = k
                                    end
                                end
                                tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                            end
                            tag:set_ability()
                            add_tag(tag)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end
                    }))
                    return true
                end,
                message = "Created Tag!",
                colour = G.C.GREEN,
            }  
        }
    end
end
}