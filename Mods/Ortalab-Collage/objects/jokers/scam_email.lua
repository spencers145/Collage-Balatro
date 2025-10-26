SMODS.Joker({
	key = "scam_email",
	atlas = "jokers",
	pos = {x=5,y=5},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {dollars = 3, rank = 'Jack'}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.dollars, localize(card.ability.extra.rank, 'ranks')}}
	end,
    set_ability = function(self, card)
        if G.playing_cards and #G.playing_cards > 0 then
            card.ability.extra.rank = self.rank_from_deck()
        end
    end,
	calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.rank = self.rank_from_deck()
            return {
                message = localize(card.ability.extra.rank, 'ranks'),
                no_retrigger = true
            }
        end
		if context.cardarea == G.play and context.individual and context.other_card.base.value == card.ability.extra.rank then
            return {
                dollars = card.ability.extra.dollars
            }
        end
        
    end,
    rank_from_deck = function()
        return pseudorandom_element(G.playing_cards, pseudoseed('ortalab_scam_email')).base.value
    end
})

--[[SMODS.JimboQuip({
    key = 'scam_email',
    extra = {
        center = 'j_ortalab_scam_email',
        particle_colours = {
            G.ARGS.LOC_COLOURS.Ortalab,
            darken(G.ARGS.LOC_COLOURS.Ortalab, 0.5),
            lighten(G.ARGS.LOC_COLOURS.Ortalab, 0.5)
        }
    },
    filter = function(self, type)
		if next(SMODS.find_card('j_ortalab_scam_email')) then
            if type == 'win' then
                self.extra.text_key = self.key..'_win'
                return true, { weight = 5 } 
            elseif type == 'loss' then
                self.extra.text_key = self.key..'_loss_'..math.random(1,2)
                return true, { weight = 5 }
            end
		end
    end
})]]