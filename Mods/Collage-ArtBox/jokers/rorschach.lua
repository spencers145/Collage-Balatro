SMODS.Joker {
    key = "rorschach",
    config = {
        mod_conv = "m_wild",
    },
    rarity = 3,
    pos = { x = 0, y = 4},
    atlas = 'joker_atlas',
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]
    end,

    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local clubs = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_suit("Clubs") then
                    clubs = clubs + 1
                    scored_card:set_ability('m_wild', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if clubs > 0 then
                return {
                    message = localize('artb_wild'),
                    colour = G.C.CHIPS
                }
            end
        end
    end
    }