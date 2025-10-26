SMODS.Joker({
	key = "flashback",
	atlas = "jokers",
	pos = {x = 7, y = 5},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {tag = 'tag_ortalab_rewind'}},
    artist_credits = {'gappie'},
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_ortalab_rewind
        return {vars = {localize({type = 'name_text', set = 'Tag', key = self.config.extra.tag})}}
    end,
    calculate = function(self, card, context)
        if context.skip_blind then
            card:juice_up()
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('ortalab_flashback')})
            add_tag(Tag(card.ability.extra.tag))
            G.GAME.tags[#G.GAME.tags]:apply_to_run({type = 'immediate'})
            return nil, {}
        end
    end
})