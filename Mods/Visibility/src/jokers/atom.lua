SMODS.Joker {
    key = "atom",
    config = { extra = { chips = 25 }},
    rarity = 1,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    pools = { ["Visibility"] = true },
    atlas = 'TextureAtlasJokers',
    pos = { x = 0, y = 3 },
    cost = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    add_to_deck = function (self, card, from_debuff)
        local _atoms = SMODS.find_card("j_vis_atom", true)
        if #_atoms >= 2 then
            for k, v in pairs(_atoms) do
                v:remove_from_deck()
                v:start_dissolve(nil)
            end
            local atomic_bomb = create_card(nil, G.jokers, nil, nil, nil, nil, "j_vis_atomic_bomb")
            atomic_bomb:add_to_deck()
            G.jokers:emplace(atomic_bomb)
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            text = {
                { text = "+" },
                { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
            },
            text_config = { colour = G.C.CHIPS }
        }
    end
}