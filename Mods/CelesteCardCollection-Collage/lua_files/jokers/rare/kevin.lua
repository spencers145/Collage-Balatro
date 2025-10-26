-- region Kevin

local kevin = {
	name = "ccc_Kevin",
	key = "kevin",
	config = {},
	pos = { x = 8, y = 3 },
	rarity = 3,
	cost = 8,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Scoring face cards act as a copy of the rightmost played card"
}

local scorecard_ref = SMODS.score_card
function SMODS.score_card(card, context)
	local ccard = card
	
	if context.cardarea == G.play 
	and card.playing_card and card:is_face() 
	and #SMODS.find_card('j_ccc_kevin') >= 1 
	and #G.play.cards >= 1 then
		ccard = G.play.cards[#G.play.cards]
		G.ccc_kevin_moment = card -- i'm going insane
	else
		G.ccc_kevin_moment = nil
	end
	return scorecard_ref(ccard, context)
end

local trigeff_ref = SMODS.trigger_effects
SMODS.trigger_effects = function(effects, card)
	local ccard = card
	if G.ccc_kevin_moment then
		ccard = G.ccc_kevin_moment
	end
	return trigeff_ref(effects, ccard)
end

local calceff_ref = SMODS.calculate_effect
SMODS.calculate_effect = function(effect, scored_card, from_edition, pre_jokers)
	if G.ccc_kevin_moment then
		effect.message_card = G.ccc_kevin_moment
	end
	return calceff_ref(effect, scored_card, from_edition, pre_jokers)
end


return kevin
-- endregion Kevin