SMODS.Consumable {
    key = 'desideratum',
    set = "Spectral",
	cost = 4,
    atlas = "TextureAtlasConsumables",
    discovered = false,
    pools = { ["c_Visibility"] = true },
    pos = { x = 7, y = 2 },
    config = { extra = { level_downs = 2 } },
    credits = {
        idea = "WarpedCloset",
        art = "WarpedCloset",
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS['tag_vis_foresight']
        return { vars = { card.ability.extra.level_downs, localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands'), to_big(G.GAME.hands[G.GAME.current_round.most_played_poker_hand].level) } }
    end,
    use = function (self, card, area, copier)
        -- Next shop is guaranteed to be all (initial) spectral cards, 
        -- but your most played poker hand will be downgraded by 2 levels
        local most_played = G.GAME.current_round.most_played_poker_hand
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(most_played, 'poker_hands'),chips = G.GAME.hands[most_played].chips, mult = G.GAME.hands[most_played].mult, level=G.GAME.hands[most_played].level})
        level_up_hand(card, most_played, nil, -card.ability.extra.level_downs)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                add_tag(Tag("tag_vis_foresight"))
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function (self, card)
        return to_big(G.GAME.hands[G.GAME.current_round.most_played_poker_hand].level) - to_big(card.ability.extra.level_downs) >= to_big(1)
    end
}