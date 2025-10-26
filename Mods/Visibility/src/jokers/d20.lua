SMODS.Joker {
    key = "d20",
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    unlocked = true,
    pools = { ["Visibility"] = true },
	discovered = false,
    atlas = "TextureAtlasJokers",
    pos = { x = 7, y = 1 },
    config = { extra = { odds = 6 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.reroll_shop then
            if pseudorandom(pseudoseed('d20')) < (G.GAME.probabilities.normal / card.ability.extra.odds) then
                local _to_remove = {}
                for k, v in pairs(G.shop_booster.cards) do
                    _to_remove[k] = v
                end
                for _, v in pairs(_to_remove) do
                    v:remove()
                end
                local booster_slots = G.shop_booster.config.card_limit
                for i = 1, booster_slots do
                    local _pool, _pool_key = get_current_pool("Booster")
                    local key
                    while G.P_CENTERS[key] == nil do -- This is probably because of G.GAME.banned_keys
                        key = pseudorandom_element(_pool, pseudoseed(_pool_key))
                    end
                    local card = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    create_shop_card_ui(card, "Booster", G.shop_booster)
                    G.shop_booster:emplace(card)
                end
                return {
                    message = localize("k_restock")
                }
            end
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            extra = {
                {
                    { text = "("},
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")"},
                }
            },
			extra_config = { colour = G.C.GREEN, scale = 0.3 },
            calc_function = function(card)
                local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
                card.joker_display_values.odds = localize { type = 'variable', key = 'jdis_odds', vars = { numerator, denominator } }
            end,
        }
    end,
}