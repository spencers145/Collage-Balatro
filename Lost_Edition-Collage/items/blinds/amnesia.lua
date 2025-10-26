local blindInfo = {
    key = 'amnesia',
    pos = { x = 0, y = 4 },
    atlas = 'losted_blinds',
    mult = 2,
    dollars = 5,
    boss = { min = 5 },
    boss_colour = HEX('f0a426'),
    loc_vars = function(self)
        return { vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}}
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played')}}
    end,
    set_blind = function(self)
    if G.GAME and G.GAME.blind and G.GAME.blind.disabled then return end
        local most_played_hand = G.GAME.current_round.most_played_poker_hand
        if most_played_hand and G.GAME.hands[most_played_hand] then
            local raw_level = G.GAME.hands[most_played_hand].level
            local original_level_num = raw_level

            if type(raw_level) == 'table' then
                if type(raw_level.to_number) == 'function' then
                    local ok, n = pcall(function() return raw_level:to_number() end)
                    if ok and type(n) == 'number' then
                        original_level_num = n
                    end
                end
                if type(original_level_num) ~= 'number' and type(to_number) == 'function' then
                    local ok, n = pcall(function() return to_number(raw_level) end)
                    if ok and type(n) == 'number' then
                        original_level_num = n
                    end
                end
                if type(original_level_num) ~= 'number' and type(raw_level.val) == 'number' then
                    original_level_num = raw_level.val
                end
                if type(original_level_num) ~= 'number' and type(raw_level[1]) == 'number' then
                    original_level_num = raw_level[1]
                end
            end

            if type(original_level_num) == 'number' and original_level_num > 1 then
                self.most_played_hand_key = most_played_hand
                self.level_change = original_level_num - 1

                SMODS.smart_level_up_hand(nil, self.most_played_hand_key, false, -self.level_change)
            end
        end
    end,
    defeat = function(self)
        self:restore_hand_level()
    end,
    disable = function(self)
        self:restore_hand_level()
    end,
    calculate = function(self, blind, context)
        if (context.end_of_round or (G.GAME and G.GAME.blind and G.GAME.blind.disabled)) then
            self:restore_hand_level()
        end
    end,
    restore_hand_level = function(self)
        if self.level_change and self.most_played_hand_key and G.GAME.hands[self.most_played_hand_key] then
            SMODS.smart_level_up_hand(nil, self.most_played_hand_key, false, self.level_change)

            self.level_change = nil
            self.most_played_hand_key = nil
        end
    end
}

return blindInfo