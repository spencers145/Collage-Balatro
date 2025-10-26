local reshape = {
    object_type = "Consumable",
	key = 'reshape',
	set = 'Spectral',
    atlas = 'consumable_atlas',
	pos = { x = 7, y = 6 },
	cost = 4,
	unlocked = true,
	discovered = false,
    order = 9,
	config ={},
    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards > 1 then 
            return true 
        end
        return false
    end,
	use = function(self, card, area, copier)
        local i -- code used from Bunco's Universe tarot
        for _, playing_card in ipairs(G.hand.cards) do
            local new_seal = SMODS.poll_seal({guaranteed = true, key = 'aij_reshape'})
            local new_enhancement = SMODS.poll_enhancement({guaranteed = true, key = 'aij_reshape'})
            local new_edition = poll_edition('aij_reshape', nil, true, true)
            local new_suit = pseudorandom_element(SMODS.Suits, pseudoseed('aij_reshape')).key
            local new_rank = pseudorandom_element(SMODS.Ranks, pseudoseed('aij_reshape')).key

            event({delay = 0.2, trigger = 'before', func = function()
                i = i and (i + 1) or 1
                play_sound('card1', 0.85 + (i * 0.05))
                big_juice(playing_card)

                if playing_card.seal then
                    playing_card:set_seal(new_seal, true, true)
                end

                if playing_card.config.center ~= G.P_CENTERS.c_base then
                    playing_card:set_ability(G.P_CENTERS[new_enhancement])
                end

                if playing_card.edition then
                    playing_card:set_edition(new_edition, true)
                end

                SMODS.change_base(playing_card, new_suit, new_rank)

            return true end})
        end
    end,
}
return {name = {"Spectrals"}, items = {reshape}}