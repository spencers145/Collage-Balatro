SMODS.current_mod.badge_colour = SMODS.Gradient {
    key = "flame_badge",
    colours = {
        HEX('B52A2A'),
	HEX('6F0C0C'),
    },
    cycle = 4,
}

SMODS.current_mod.badge_text_colour = SMODS.Gradient {
    key = "flame_badge_text",
    colours = {
        HEX('F5EF4A'),
	HEX('D0CA1D'),
    },
    cycle = 2,
}

local files = {
      "items/jokers",
      --"items/pokerhand",
      --"items/enhance",
      --"items/item",
      -- "items/edition",
      "lib/atlas",
}

local crossmodfiles = {
      "Cryptid",
      "GSPhanta"
}

for i, v in pairs(files) do
    assert(SMODS.load_file(v..".lua"))()
end

for i, v in pairs(crossmodfiles) do
    if next(SMODS.find_mod(v)) then
       assert(SMODS.load_file("crossmod/" .. v .. ".lua"))()
    end
end
