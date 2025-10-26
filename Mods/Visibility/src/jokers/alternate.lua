SMODS.Joker {
    key = "alternate",
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    unlocked = true,
	discovered = false,
    eternal_compat = true,
    pools = { ["Visibility"] = true },
    atlas = "TextureAtlasJokers",
    pos = { x = 5, y = 2 },
    config = { extra = { previous_joker = nil } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    update = function (self, card, dt)
        if not G.jokers or not G.jokers.cards then return end
        for i, v in ipairs(G.jokers.cards) do
            if v == card then
                if i == 1 then
                    card.ability.extra.previous_joker = nil
                else
                    card.ability.extra.previous_joker = G.jokers.cards[i - 1]
                end
                break
            end
        end
    end,
    calculate = function(self, card, context)
        if card.ability.extra.previous_joker then
            if context.final_scoring_step then
                local debuffed = false
                G.E_MANAGER:add_event(Event({
                    func = function()
                        if card.ability.extra.previous_joker.debuff then return true end
                        card.ability.extra.previous_joker:set_debuff(true)
                        debuffed = true
                        return true
                    end
                }))
                if not debuffed then return end
                return {
                    message = "Nothing is worth the risk.",
                    card = card.ability.extra.previous_joker,
                }
            end
            if card.ability.extra.previous_joker.config.center.blueprint_compat then
                return SMODS.blueprint_effect(card, card.ability.extra.previous_joker, context)
            end
        end
    end,
    remove_from_deck = function (self, card, from_debuff)
        if card.ability.extra.previous_joker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    if card.ability.extra.previous_joker.set_debuff then
                        card.ability.extra.previous_joker:set_debuff(false)
                    end
                    return true
                end
            }))
        end
    end,
    joker_display_def = function (JokerDisplay)
        --- @type JDJokerDefinition
        return {
            calc_function = function(card)
                local copied_joker, copied_debuff = JokerDisplay.calculate_blueprint_copy(card)
                card.joker_display_values.blueprint_compat = localize('k_incompatible')
                JokerDisplay.copy_display(card, copied_joker, copied_debuff)
            end,
            blueprint_joker = function (card)
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        if i == 1 then
                            return nil
                        end
                        return G.jokers.cards[i - 1]
                    end
                end
            end,
        }
    end
}