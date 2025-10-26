SMODS.Joker {
    key = "blueyourself",
    config = { extra = 1 },
    loc_vars = function(self, info_queue, card)
        if not (card.edition and card.edition.key == "e_foil") then
            -- prevent foil tooltip from showing up twice
            info_queue[#info_queue+1] = G.P_CENTERS.e_foil
        end
        return { vars = { localize{type = "name_text", set = "Joker", key = self.key} } }
    end,
    in_pool = function(self, args)
        return any_foils()
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    atlas = "NeatoJokers",
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card and
                context.other_card.config and context.other_card.config.center.key ~= self.key and  -- don't retrigger other blueyourself jokers
                context.other_card.edition and context.other_card.edition.key == "e_foil" then
            -- joker card retriggers using .retrigger_joker_check
            if context.other_ret and context.other_ret.jokers and context.other_ret.jokers.was_blueprinted then
                -- don't retrigger foil blueprint copying blueyourself
            else
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra,
                    message_card = context.blueprint_card or card,
                    was_blueprinted = context.blueprint,
                }
            end
        elseif context.repetition and not context.repetition_only and
                context.other_card and context.other_card.edition and context.other_card.edition.key == "e_foil" then
            -- playing card retriggers using .repetition
            return {
                message = localize("k_again_ex"),
                repetitions = card.ability.extra,
                card = card,
                was_blueprinted = context.blueprint,
            }
        end
    end
}
