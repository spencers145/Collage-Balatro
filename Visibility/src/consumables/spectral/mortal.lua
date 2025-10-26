SMODS.Consumable {
    key = "mortal",
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    loc_vars = function (self, info_queue, card)
        local amount_lost = 0
        if G.jokers then
            for key, value in pairs(G.jokers.cards) do
                if value.edition and value.edition.negative then amount_lost = amount_lost + 10 end
            end
        end

        return { vars = { amount_lost }}
    end,
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 4, y = 2 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local amount_lost = 0
                if G.GAME.dollars > 0 then amount_lost = G.GAME.dollars end

                for key, value in pairs(G.jokers.cards) do
                    if value.edition and value.edition.negative then amount_lost = amount_lost + 10 end
                end

                play_sound('timpani')
                SMODS.add_card({ set = 'Joker', rarity = 'Common', edition = "e_negative"})
                card:juice_up(0.3, 0.5)

                if amount_lost ~= 0 then ease_dollars(-amount_lost, true) end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return true
    end
}