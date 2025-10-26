SMODS.Consumable {
    key = "chaos",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 3, y = 2 },
    use = function(self)
        G.E_MANAGER:add_event(Event({
            func = (function()
                for i = 1, 3 do
                    local tag_key = get_next_tag_key()
                    while tag_key == 'tag_orbital' do
                        -- nuh uh
                        tag_key = get_next_tag_key()
                    end
                    add_tag(Tag(tag_key))
                end
                return true
            end),
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}