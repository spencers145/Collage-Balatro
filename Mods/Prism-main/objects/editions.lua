----Not Implemented---
SMODS.Shader {
    key = 'gold_foil',
    path = 'gold_foil.fs'
}

SMODS.Edition {
    key = 'gold_foil',
    shader = 'gold_foil',
    sound = {
        sound = 'prism_gold_foil',
        per = 1,
        vol = 0.4
    },
    discovered = true,
    weight = 3,
    in_shop = true,
    extra_cost = 5,
    get_weight = function(self)
        return self.weight
    end,
	calculate = function(self, card, context)
		if context.other_card == card and ((context.repetition and context.cardarea == G.play)
        or (context.retrigger_joker_check and not context.retrigger_joker))
		then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card,
			}
		end
	end,
}

local orig_calculate_retriggers = SMODS.calculate_retriggers
function SMODS.calculate_retriggers(card, context, _ret)
    local compat = card.config and card.config.center and card.config.center.blueprint_compat == true or not (card.edition and card.edition.key == "e_prism_gold_foil")
    return compat and orig_calculate_retriggers(card, context, _ret) or {}
end

local orig_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = orig_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if card.config.center.set == "Joker" and not card.config.center.blueprint_compat and card.edition and card.edition.key == "e_prism_gold_foil" then
        local edition
        while edition == "e_prism_gold_foil" do 
            edition = poll_edition('edi'..(key_append or '')..G.GAME.round_resets.ante)
        end
        card:set_edition(edition)
        check_for_unlock({type = 'have_edition'})
    end
    return card
end