SMODS.Joker({
	key = "mystery_soda",
	atlas = "jokers",
	pos = {x = 1, y = 6},
	rarity = 2,
	cost = 12,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	config = {extra = {amount = 2}},
    artist_credits = {'salad'},
	loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.amount}}
    end,
    calculate = function(self, card, context) --Mystery Soda Logic
        if context.selling_self then
            local available_tags = get_current_pool('Tag')
            local selected_tags = {}
            for i = 1, card.ability.extra.amount do
                local tag = pseudorandom_element(available_tags, pseudoseed('mystery_soda'))
                while tag == 'UNAVAILABLE' do
                    tag = pseudorandom_element(available_tags, pseudoseed('mystery_soda_reroll'))
                end
                selected_tags[i] = tag
            end
            G.E_MANAGER:add_event(Event({
                func = (function()
                    for _, tag in pairs(selected_tags) do
                        add_tag(Tag(tag, false, 'Small'))
                    end
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))
        end
    end
})