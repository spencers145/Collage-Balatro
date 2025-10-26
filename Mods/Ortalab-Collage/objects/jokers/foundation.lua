SMODS.Joker({
    key = "foundation",
    atlas = "jokers",
    pos = {x = 9, y = 4},
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    config = {extra = {xmult = 1, gain = 0.1, most_played = 'High Card'}},
    artist_credits = {'gappie'},
    loc_vars = function(self, info_queue, card)
        local _handname, _played, _order = 'High Card', -1, 100
        for k, v in pairs(G.GAME.hands) do
            if v.played > _played or (v.played == _played and _order > v.order) then 
                _played = v.played
                _handname = k
            end
        end
        card.ability.extra.most_played = _handname
        return {vars = {card.ability.extra.xmult, card.ability.extra.gain, localize(card.ability.extra.most_played, 'poker_hands')}}
    end,
    set_ability = function(self, card, initial)
		card.ability.extra.base = card.ability.extra.xmult
	end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local _handname, _played, _order = 'High Card', -1, 100
            for k, v in pairs(G.GAME.hands) do
                if v.played > _played or (v.played == _played and _order > v.order) then 
                    _played = v.played
                    _handname = k
                end
            end
            card.ability.extra.most_played = _handname
            if context.scoring_name == _handname then
                SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmult",
					scalar_value = "gain",
					message_key = 'a_xmult'
				})
            else
                card.ability.extra.xmult = card.ability.extra.base
                return {
                    message = localize('ortalab_joker_miles_reset'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end    
})