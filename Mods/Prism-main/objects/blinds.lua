SMODS.Atlas({
    key = 'prismblinds',
    path = 'blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
    px = 34,
    py = 34
})

SMODS.Blind({
    key = 'birch',
    atlas = 'prismblinds',
    pos = {x = 0, y = 2},
    dollars = 5,
    mult = 2,
    boss = {min = 1, max = 10},
    discovered = false,
    boss_colour = HEX('a6c4a0'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
			if G.PRISM.is_even(card)
			then
				return true
			end
			return false
		end
    end,
})
SMODS.Blind({
    key = 'yew',
    atlas = 'prismblinds',
    pos = {x = 0, y = 3},
    dollars = 5,
    mult = 2,
    boss = {min = 1, max = 10},
    discovered = false,
    boss_colour = HEX('66916b'),
    recalc_debuff = function(self, card, from_blind)
        if card.area ~= G.jokers and not G.GAME.blind.disabled then
			if G.PRISM.is_odd(card)
			then
				return true
			end
			return false
		end
    end,
})
SMODS.Blind({
    key = 'rose_club',
    atlas = 'prismblinds',
    pos = {x = 0, y = 0},
    dollars = 8,
    mult = 2,
    boss = {showdown = true, min = 10, max = 10},
    discovered = false,
    boss_colour = HEX('c4729b'),
    loc_vars = function(self)
        return {vars = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}}
    end,
    collection_loc_vars = function(self)
        return {vars = {localize('ph_most_played')}}
    end,

    press_play = function(self)
        if not G.GAME.blind.disabled then
            if G.FUNCS.get_poker_hand_info(G.hand.highlighted) == G.GAME.current_round.most_played_poker_hand then
                for _, card in pairs(G.hand.highlighted) do
                    card.boss_debuff = true
                    card:set_debuff(true)
                end
                G.GAME.blind:wiggle()
                G.GAME.blind.triggered = true
            end
        end
    end,
    defeat = function(self)
        for _, card in pairs(G.playing_cards) do
            if card.boss_debuff then card:set_debuff(); card.boss_debuff = nil end
        end
    end
})