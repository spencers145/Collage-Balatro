local card_isfaceref = Card.is_face

function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
	
	if self.config.center == G.P_CENTERS.m_buf_porcelain_g then
		return true
	end
	
	return card_isfaceref(self, from_boss)
end

SMODS.Enhancement {  -- Royal Porcelain Cards
	key = "porcelain_g",
	atlas = "buf_enhancements",
	pos = {x = 1, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	in_pool = function(self)
		return false
    end,
	
	config = {extra = {Xchips = 2, limit = 3, played = 0, marked = false, money = 6}},
	
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'buf_fragile_info'}
        return {
            vars = { card.ability.extra.Xchips, card.ability.extra.limit, card.ability.extra.money}
        }
    end,
	
	calculate = function(self, card, context, ret)
		if context.before and card.area == G.hand then  -- This code block makes sure the card is not marked while in hand,
			card.ability.extra.marked = false			-- useful for when the card is detroyed and copied with Extra Credit's
		end												-- Ship of Theseus, for example.
		
		if context.cardarea == G.play and context.main_scoring then
			card.ability.extra.played = #context.scoring_hand
			if card.ability.extra.played > card.ability.extra.limit and card.area == G.play then -- the 'card.area' part makes sure the card is only marked if it's in the scoring cards area
				card.ability.extra.marked = true
			end
			return {
				xchips = card.ability.extra.Xchips
			}
		end
		
		if context.destroy_card == card and card.ability.extra.marked then
			return {
				remove = true
			}
		end
		
		if context.remove_playing_cards then
			for k, val in ipairs(context.removed) do
				if val==card then
					return {
						dollars = card.ability.extra.money
					}
				end
			end
		end
	end,
	
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Enhanced[#G.P_CENTER_POOLS.Enhanced] = nil
		else
			SMODS.Enhancement.super.inject(self)
		end
	end
}