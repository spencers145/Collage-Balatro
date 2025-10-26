SMODS.Joker({
	key = "miracle_cure",
	atlas = "jokers",
	pos = {x = 5, y = 3},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {repetitions = 1}},
    artist_credits = {'gappie'},
    calculate = function(self, card, context)
        if context.press_play then
            for _, playing_card in ipairs(G.hand.highlighted) do
                if playing_card.debuff or playing_card.curse or playing_card.facing == 'back' then
                    playing_card.cured = true
                    playing_card.cured_debuff = playing_card.debuff
                    playing_card.debuff = false
                end
            end
        end
        if context.before then
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card.cured then
                    G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function ()
                        playing_card.cured_debuff = false
                        card:juice_up()
                        if playing_card.facing == 'back' then playing_card:flip() end
                        return true
                    end}))
                    SMODS.calculate_effect({message = localize('ortalab_cured'), colour = G.C.PURPLE}, playing_card)
                end
            end
        end
        if context.repetition and context.cardarea == G.play and context.other_card.cured then
            return {
                repetitions = card.ability.extra.repetitions,
                message = localize('k_again_ex'),
                colour = G.C.PURPLE
            }
        end
        if context.after then
            for _, playing_card in ipairs(context.scoring_hand) do
                playing_card.cured = false
            end
        end
    end
})

SMODS.DrawStep {
    key = 'miracle_cure',
    order = 1,
    func = function(self, layer)
        if self.cured_debuff then
            self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
            if self.children.front and self.ability.effect ~= 'Stone Card' and not self.config.center.replace_base_card then
                self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}