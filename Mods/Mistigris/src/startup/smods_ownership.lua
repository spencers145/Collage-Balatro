-- Wheel of Fortune Description Hotfix
SMODS.Consumable:take_ownership("wheel_of_fortune", {
    loc_vars = function(self, info_queue, card)
        if not card.fake_card then
            info_queue[#info_queue + 1] = G.P_CENTERS.e_foil;
            info_queue[#info_queue + 1] = G.P_CENTERS.e_holo;
            info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome;
        end
        return { vars = { G.GAME.probabilities.normal, card.ability.extra } }
    end
}, true)
