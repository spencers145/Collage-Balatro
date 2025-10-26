SMODS.Joker({
    key = "hit_the_gym",
    atlas = "jokers",
    pos = {x = 0, y = 8},
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config = {extra = {gain = 0.75, xmult = 1}},
    artist_credits = {'akai'},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.gain, card.ability.extra.xmult, localize('Jack', 'ranks')}}
    end,
	set_ability = function(self, card, initial)
		card.ability.extra.base = card.ability.extra.xmult
	end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = card.ability.extra.base
            return {
                message = localize('ortalab_joker_miles_reset')
            }
        end
        if context.before and not context.blueprint then
            for _, _card in pairs(context.scoring_hand) do
                if _card:get_id() == 11 then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "xmult",
                        scalar_value = "gain",
                        message_colour = G.C.RED
                    })
                end            
            end
        end
        if context.joker_main and card.ability.extra.xmult > 1 then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end    
})