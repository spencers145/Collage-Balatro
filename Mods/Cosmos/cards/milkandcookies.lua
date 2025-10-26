SMODS.Joker {
    key = 'milkandcookies',
    loc_txt = {
        name = 'Milk & Cookies',
        text = {"Sell this card to", "create {C:attention}#1# {C:green}Tags{}", "{s:0.33} ",
                "When {C:attention}Boss Blind{} is defeated,", "increase by {C:attention}+#2#{} {C:green}Tags"}
    },
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    blueprint_compat = true,
    config = {
        extra = {
            tags = 0,
            tag_gen = 2
        }
    },
    rarity = 2,
    atlas = 'JJPack',
    pos = {
        x = 2,
        y = 0
    },
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.tags, card.ability.extra.tag_gen}
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and
            G.GAME.blind.boss then
            card.ability.extra.tags = card.ability.extra.tags + card.ability.extra.tag_gen
            return {
                message = "+" .. card.ability.extra.tag_gen .. " Tags!",
                colour = G.C.GREEN
            }
        end
        if context.selling_self == true then
            local tag_pool = get_current_pool('Tag')
            local give_tags = {}
            for i = 1, card.ability.extra.tags do
                local tag = pseudorandom_element(tag_pool, pseudoseed('jj_milkandcookies'))
                while tag == 'UNAVAILABLE' do
                    tag = pseudorandom_element(tag_pool, pseudoseed('jj_milkandcookies'))
                end
                give_tags[i] = tag
            end
            G.E_MANAGER:add_event(Event({
                func = (function()
                    for _, tag_key in pairs(give_tags) do
                        local tag = Tag(tag_key)

                        -- Thanks to Paperback for the Orbital Tag fix
                        -- The way the hand for an orbital tag in the base game is selected could cause issues
                        -- with mods that modify blinds, so we randomly pick one from all visible hands
                        if tag_key == "tag_orbital" then
                            local available_hands = {}

                            for k, hand in pairs(G.GAME.hands) do
                                if hand.visible then
                                    available_hands[#available_hands + 1] = k
                                end
                            end

                            tag.ability.orbital_hand = pseudorandom_element(available_hands,
                            pseudoseed('jj_milkandcookies_orbital'))
                        end
                        --

                        add_tag(tag)
                    end
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
    end
}
