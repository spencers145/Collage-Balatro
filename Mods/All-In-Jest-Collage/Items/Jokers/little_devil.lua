---- local little_devil = {
----   object_type = "Joker",
----   order = 10,

----   key = "little_devil",
----   rarity = 2,
----   cost = 6,
----   unlocked = true,
----   discovered = false,
----   pos = { x = 9, y = 0 },
----   atlas = 'joker_atlas',
----   blueprint_compat = true,
----   eternal_compat = true,

 
----   loc_vars = function(self, info_queue, card)
----       local possible_tags = {'tag_standard', 'tag_charm', 'tag_meteor', 'tag_buffoon', 'tag_ethereal'}
----       for _, tag_key in ipairs(possible_tags) do
----           info_queue[#info_queue+1] = {set = 'Tag', key = tag_key}
----       end
----       return {}
----   end,

----   calculate = function(self, card, context)
----       local eff_card = context.blueprint_card or card
----       if context.skip_blind then
----               local possible_tags = {'tag_standard', 'tag_charm', 'tag_meteor', 'tag_buffoon', 'tag_ethereal'}
----               local chosen_tag_key = pseudorandom_element(possible_tags, pseudoseed('little_devil_tag'..G.GAME.round_resets.ante))
----               local tag_name = localize{type = 'name_text', set = 'Tag', key = chosen_tag_key}
----               add_tag(Tag(chosen_tag_key))
----               card:juice_up(0.4, 0.4)
----               play_sound('tarot1') 
----               card_eval_status_text(eff_card, 'extra', nil, nil, nil, {
----                   message = '+'..tag_name, 
----               })
----               return nil, true
----           end
----   end
---- }
---- return { name = {"Jokers"}, items = {little_devil} }
