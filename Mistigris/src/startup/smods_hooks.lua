-- Placeholder registry
local register_joker = SMODS.Joker.register
SMODS.Joker.register = function(self)
    if (self.atlas == nil or self.atlas == 'Joker') and SMODS.current_mod.id == MistigrisMod.id then
        self.atlas = MistigrisMod.prefix .. '_placeholder'
        self.pos = { x = self.rarity - 1, y = 0 }
    end

    return register_joker(self)
end

local register_back = SMODS.Back.register
SMODS.Back.register = function(self)
    if (self.atlas == nil or self.atlas == 'centers') and SMODS.current_mod.id == MistigrisMod.id then
        self.atlas = MistigrisMod.prefix .. '_placeholder'
        self.pos = { x = 4, y = 2 }
    end

    return register_back(self)
end
