SMODS.Blind {
    name = "boss_flip",
    key = "boss_flip",
    discovered = false,
    dollars = 5,
    mult = 3,
    boss = { min = 4 },
    boss_colour = HEX('177CAD'),
    atlas = 'TextureAtlasBlinds',
    pos = { x = 0, y = 1 },
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.modify_hand then
                if context.scoring_name == G.GAME.current_round.most_played_poker_hand then
                    blind.triggered = true
                    mult = 0
                    update_hand_text({ sound = 'debuff1', modded = true }, { mult = mult })
                end
            end
        end
    end
}
--[[
SMODS.Blind {
    key = "forge",
    dollars = 5,
    discovered = true,
    atlas = 'TextureAtlasBlinds',
    mult = 2,
    pos = { x = 0, y = 2 },
    boss = { min = 4 },
    boss_colour = HEX("e5c10b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                local enhancements = SMODS.get_enhancements(context.debuff_card)
                if enhancements and next(enhancements) then
                    return {
                        debuff = true
                    }
                end
            end
        end
    end
}
]]

