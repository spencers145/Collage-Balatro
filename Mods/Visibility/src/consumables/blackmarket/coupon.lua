SMODS.Consumable {
    key = "coupon",
    set = "BlackMarket",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 8, y = 0 },
    config = { extra = { } },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_TAGS.tag_coupon
    end,
    use = function(self, card, area, copier)
        --[[G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.current_round.reroll_cost = 0
                G.GAME.current_round.reroll_cost_increase = ((G.GAME.round_resets and G.GAME.round_resets.reroll_cost) and -G.GAME.round_resets.reroll_cost) or -5
                play_sound('coin7')
                return true
            end
        }))]]
        G.E_MANAGER:add_event(Event({
			func = function ()
                add_tag(Tag('tag_coupon'))
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                return true
			end
		}))
    end,
    can_use = function(self, card)
        return true--G.GAME.current_round.reroll_cost > 1
    end
}