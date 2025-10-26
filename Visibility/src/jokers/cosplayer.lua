
SMODS.Joker {
    key = "cosplayer",
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    pools = { ["Visibility"] = true },
    eternal_compat = true,
    atlas = "TextureAtlasJokers",
    pos = { x = 8, y = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'e_negative_consumable', set = 'Edition', config = { extra = 1 } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards > 0 then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            -- Filter out cards that already have a negative edition
                            local valid_cards = {}
                            for _, c in ipairs(G.consumeables.cards) do
                                if not (c.edition and c.edition.type == "negative") then
                                    table.insert(valid_cards, c)
                                end
                            end

                            -- If any valid cards exist, apply negative edition to one of them
                            if #valid_cards > 0 then
                                local target_card = pseudorandom_element(valid_cards, pseudoseed('vremade_cursed_alchemist'))
                                target_card:set_edition("e_negative", true)
                                SMODS.calculate_effect({ message = localize('k_edition_negative'), colour = G.C.RED }, context.blueprint_card or card)
                            end
                            return true
                        end
                    }))
                end
            }
        end
    end
}
